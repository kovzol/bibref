using namespace std;

#define MIN_CITATION_LENGTH 10
// FIXME: static arrays are too big here, find a dynamic solution
#define MAXSIZE 1000

#include <limits>
#include <string>
#include <string.h>
#include <stdio.h>
#include <dirent.h>
#include <fstream>
#include <sstream>
#include <vector>
#include <boost/algorithm/string/trim.hpp>
#include <boost/algorithm/string/predicate.hpp>
#include <boost/algorithm/string/split.hpp>
#include <boost/algorithm/string/replace.hpp>
#ifndef __EMSCRIPTEN__
#include <boost/filesystem.hpp>
#endif

#include "swmgr.h"
#include "swmodule.h"
#include "swtext.h"
#include "markupfiltmgr.h"
#include "utf8greekaccents.h"

#include "book.h"
#include "fingerprint.h"
#include "cli.h"
#include "psalmsinfo.h"

class InvalidModule: public exception
{
  virtual const char* what() const throw()
  {
    return "Invalid module.";
  }
} InvalidModule;

class InvalidBook: public exception
{
    virtual const char* what() const throw()
    {
        return "Invalid book.";
    }
} InvalidBook;

class InvalidVerse: public exception
{
    virtual const char* what() const throw()
    {
        return "Invalid verse.";
    }
} InvalidVerse;

class InvalidPassage: public exception
{
    virtual const char* what() const throw()
    {
        return "Invalid passage.";
    }
} InvalidPassage;

class NoCitation: public exception
{
    virtual const char* what() const throw()
    {
        return "Passage is not a citation.";
    }
} NoCitation;

using namespace sword;

vector<Book> books;
vector<PsalmsInfo> psalmsInfos;

string greekToLatin(string word) {
    string rewritten;
    for (int i = 0; i < word.length(); i += 2) {
        auto c1 = static_cast<unsigned char>(word[i]);
        auto c2 = static_cast<unsigned char>(word[i + 1]);
        char c;
        // keep care of special characters
        if (c1 == 0x80) {
            i--;
        }
        // keep only Greek characters
        if (c1 == 0xCE || c1 == 0xCF) {
            switch (c1) {
            case 0xCE:
                switch (c2) {
                case 0xB1:
                    c = 'a';
                    break;
                case 0xB2:
                    c = 'b';
                    break;
                case 0xB3:
                    c = 'g';
                    break;
                case 0xB4:
                    c = 'd';
                    break;
                case 0xB5:
                    c = 'e';
                    break;
                case 0xB6:
                    c = 'q'; // it should be z (zeta) but we change it to free one letter at the end of alphabet
                    break;
                case 0xB7:
                    c = 'h'; // eta
                    break;
                case 0xB8:
                    c = 'u'; // theta
                    break;
                case 0xB9:
                    c = 'i';
                    break;
                case 0xBA:
                    c = 'k';
                    break;
                case 0xBB:
                    c = 'l';
                    break;
                case 0xBC:
                    c = 'm';
                    break;
                case 0xBD:
                    c = 'n';
                    break;
                case 0xBE:
                    c = 'j'; // xi
                    break;
                case 0xBF:
                    c = 'o';
                    break;
                }
                break;
            case 0xCF:
                switch (c2) {
                case 0x80:
                    c = 'p';
                    break;
                case 0x81:
                    c = 'r';
                    break;
                case 0x82:
                    // c = 'w'; // sigma at the end of the word
                    c = 's'; // no difference to normal sigma is made
                    break;
                case 0x83:
                    c = 's';
                    break;
                case 0x84:
                    c = 't';
                    break;
                case 0x85:
                    c = 'y';
                    break;
                case 0x86:
                    c = 'f'; // phi
                    break;
                case 0x87:
                    c = 'x'; // chi
                    break;
                case 0x88:
                    c = 'c'; // psi
                    break;
                case 0x89:
                    c = 'v'; // omega
                    break;
                }
                break;
            default:
                break;
            }
            rewritten.push_back(c);
        }
    }
    return rewritten;
}

string processWord(string word) {
    string rewritten;
    for (int i = 0; i < word.length(); i += 2) {
        auto c1 = static_cast<unsigned char>(word[i]);
        auto c2 = static_cast<unsigned char>(word[i + 1]);
        // keep care of special characters
        if (c1 == 0x80) {
            i--;
        }
        if (c1 == '(' || c1 == ')') {
            i--;
        }
        if (c1 == 0xe2) {
            i++; // handle ⸂ (0xe2 0xb8 0x82), fix issue #4
        }
        if (c1 == 'c') { // Some systems do not support greek ϲ so we fall back sometimes to latin c in the input
            i--;
            rewritten.push_back(0xCF);
            rewritten.push_back(0x83);
        }
        // keep only Greek characters
        if (c1 == 0xCE || c1 == 0xCF) {
            // force lowercase
            if (c1 == 0xCE && c2 < 0xB1 &&
                    !(c2 >= 0xA0 && c2 <= 0xA9)) {
                // letters before Pi (excluding Chi, Pi, Omega, Y, Sigma, Tau, Psi, Phi)
                c2 += 0x20;
            }
            if (c1 == 0xCE && c2 >= 0xA0 && c2 <= 0xA9) {
                // Chi, Pi, Omega, Y, Sigma, Tau, Psi, Phi
                c1 = 0xCF;
                c2 -= 0x20;
            }
            if (c1 == 0xCF && c2 < 0x80) {
                c2 += 0x20;
            }
            rewritten.push_back(c1);
            rewritten.push_back(c2);
        }
    }
    return rewritten;
}

string processVerse(const string &verse) {
    string out;
    string word;
    stringstream ss(verse);

    while (ss >> word) {
        word = greekToLatin(processWord(word));
        out.append(word);
    }

    return out;
}

typedef struct VerseInfo {
    string bookName;
    string reference;
} VerseInfo;

VerseInfo splitVerseInfo(string verseInfo) {
    // split book name and verse reference
    string reference;
    string bookName;
    for (int i=verseInfo.length()-1; i>0; i--) {
        if (verseInfo.at(i) == ' ') {
            bookName = verseInfo.substr(0,i);
            reference = verseInfo.substr(i+1);
            return {bookName, reference};
        }
    }
    throw InvalidPassage;
}

int lookupTranslation(string moduleName, string book, string verse) {
    SWMgr library(new MarkupFilterMgr(FMT_PLAIN));
    SWModule *module;
    library.setGlobalOption("Greek Accents", "Off");
    module = library.getModule(moduleName.c_str());
    if (!module) {
        error("The SWORD module " + moduleName + " is not installed.");
        return 1;
    }
    boost::replace_all(book, "_", " ");
    string lookupString = book + " " + verse;
    module->setKey(lookupString.c_str());
    string text;
    if (moduleName == "LXX")
        text += ot_color;
    if (moduleName == "SBLGNT")
        text += nt_color;
    text += module->renderText().c_str();
    text += reset_color;
    info(text);
    return 0;
}

int addBook_cached(string moduleName) {
    vector<string> bookNames;
    // This is needed for correct alphabetical ordering:
    if (moduleName == "LXX") {
        bookNames={"Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy",
            "Joshua", "Judges", "Ruth",
            "I_Samuel", "II_Samuel", "I_Kings", "II_Kings", "I_Chronicles", "II_Chronicles",
            "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs", "Ecclesiastes", "Song_of_Solomon",
            "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel",
            "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah",
                "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi"};
        }
    if (moduleName == "SBLGNT") {
        bookNames={"Matthew", "Mark", "Luke", "John", "Acts",
            "Romans", "I_Corinthians", "II_Corinthians", "Galatians",
                "Ephesians", "Philippians", "Colossians",
                "I_Thessalonians", "II_Thessalonians", "I_Timothy", "II_Timothy",
                "Titus", "Philemon",
            "Hebrews", "James",
            "I_Peter", "II_Peter",
            "I_John", "II_John", "III_John",
            "Jude",
            "Revelation_of_John"};
        }

    string path = ".bibref/" + moduleName;

    PsalmsInfo pi = PsalmsInfo(moduleName);
    for (int i=1; i<=151; i++) pi.setLastVerse(i, 0); // initialize

    for (vector<string>::iterator i=bookNames.begin(); i!=bookNames.end(); ++i) {
        string bookName = *i;
        std::ifstream bookFile(path + "/" + bookName + ".book");
        std::stringstream buffer;
        buffer << bookFile.rdbuf();
        Book book = Book(bookName);
        book.setText(string(buffer.str()));
        // Loading verses:
        string verseFileName = path + "/" + bookName + ".verses";
        FILE *verseFile = fopen(verseFileName.c_str(), "r");
        char reference[8]; // Psalms 119:176 needs 7 characters + "\n"
        int start, end;
        while (fscanf(verseFile, "%s %d %d", &reference, &start, &end) != EOF) {
            if (bookName == "Psalms") {
                vector<string> r;
                boost::split(r, reference, boost::is_any_of(":"));
                pi.setLastVerse(stoi(r[0]), stoi(r[1])); // this overwrites the previous entry
                }
            book.addVerse(start, end - start + 1, string(reference));
            }
        fclose(verseFile);
        add_vocabulary_item(bookName);
        book.setInfo(moduleName);
        books.push_back(book);
        }
    psalmsInfos.push_back(pi);
    info("Done loading books of " + moduleName + " (cached).");
    return 0;
}

int addBook(string moduleName, string firstVerse, string lastVerse, bool removeAccents) {
    DIR* cache_dir = opendir((".bibref/" + moduleName).c_str());
    if (cache_dir) {
        closedir(cache_dir);
        addBook_cached(moduleName);
        return 0;
    }
    SWMgr library(new MarkupFilterMgr(FMT_PLAIN));
    SWModule *module;
    module = library.getModule(moduleName.c_str());
    if (!module) {
        error("The SWORD module " + moduleName + " is not installed.");
        return 1;
    }
    module->setKey(firstVerse.c_str());
    int bookStart = module->getIndex();
    module->setKey(lastVerse.c_str());
    int bookEnd = module->getIndex();

    SWBuf verse;
    SWOptionFilter *filter = new UTF8GreekAccents();
    filter->setOptionValue("off");

    info("Loading " + moduleName + "...");
    string path = ".bibref/" + moduleName;
#ifndef __EMSCRIPTEN__
    boost::filesystem::create_directories(path);
#endif
    add_vocabulary_item(moduleName);

    string lastBookName = splitVerseInfo(firstVerse).bookName;
    Book lastBook = Book(lastBookName);
    bool firstInfoSet = false;
    FILE *lastBookVersesFile = NULL;

    // Iterate on verses of the whole Bible version:
    for (long v = bookStart; v <= bookEnd; ++v) {
        module->setIndex(v);
        verse = module->renderText();
        if (removeAccents)
            filter->processText(verse);
        // Some entries may be empty (e.g. book or chapter titles):
        if (verse.size() > 0) {
            string verseInfo = module->getKeyText();
            if (!firstInfoSet) {
                lastBook.setInfo(module->getBibliography().c_str());
                lastBook.setInfo(moduleName);
                firstInfoSet = true;
            }
            string verseText = processVerse(verse.c_str());
            // split book name and verse reference
            bool found = false;
            string reference;
            string bookName;
            VerseInfo vi = splitVerseInfo(verseInfo);
            bookName = vi.bookName;
            // Use I_Peter instead of "I Peter" on all occurrences:
            boost::replace_all(bookName, " ", "_");
            reference = vi.reference;
            if (lastBookName.compare(bookName) != 0) {
                books.push_back(lastBook);
                string lastBookText = lastBook.getText();
#ifndef __EMSCRIPTEN__
                FILE *lastBookFile = fopen((path + "/" + lastBookName + ".book").c_str(), "wa");
                fprintf(lastBookFile, "%s", lastBookText.c_str());
                fclose(lastBookFile);
#endif
                info(lastBookName + " contains " + to_string(lastBookText.length()) + " characters,");
                add_vocabulary_item(lastBookName);
                // new book
                Book book = Book(bookName);
                book.setInfo(module->getBibliography().c_str());
                book.setInfo(moduleName);
                lastBook = book;
                lastBookName = bookName;
                fclose(lastBookVersesFile);
                lastBookVersesFile = fopen((path + "/" + lastBookName + ".verses").c_str(), "wa");
            } else {
                if (lastBookVersesFile == NULL)
                   lastBookVersesFile = fopen((path + "/" + lastBookName + ".verses").c_str(), "wa");
            }
            lastBook.addVerse(verseText, reference);
#ifndef __EMSCRIPTEN__
            int start = lastBook.getVerseStart(reference);
            int end = lastBook.getVerseEnd(reference);
            fprintf(lastBookVersesFile, "%s %d %d\n", reference.c_str(), start, end);
#endif
            if (verseInfo.compare(lastVerse)==0) {
                books.push_back(lastBook);
                string lastBookText = lastBook.getText();
#ifndef __EMSCRIPTEN__
                FILE *lastBookFile = fopen((path + "/" + lastBookName + ".book").c_str(), "wa");
                fprintf(lastBookFile, "%s\n", lastBookText.c_str());
                fclose(lastBookFile);
                fclose(lastBookVersesFile);
#endif
                info("and " + lastBookName + " contains " + to_string(lastBook.getText().length()) + " characters.");
                add_vocabulary_item(lastBookName);
            }
        }
    }
    info("Done loading books of " + moduleName + ".");
    return 0;
}

int addBooks() {
    int success = 0;
    if (addBook("LXX", "Genesis 1:1", "Malachi 4:6", false) !=0 ) {
        success = 1;
    }
    if (addBook("SBLGNT", "Matthew 1:1", "Revelation of John 22:21", true) != 0) {
        success = 1;
    }
    return success;
}

Book getBook(string book, string info) {
    for (int i=0; i<books.size(); i++) {
        Book b = books[i];
        if (b.getName().compare(book) == 0 && b.getInfo().compare(info) == 0) {
            return b;
        }
    }
    throw InvalidBook;
}

string lookupVerse(string book, string info, string verse) {
    try {
        Book b = getBook(book, info);
        string ret = b.getVerse(verse);
        if (ret.length() == 0) {
            throw InvalidVerse;
        }
        return ret;
    } catch (exception &e) {
        error(e.what());
        throw InvalidVerse;
    }
}

fingerprint getTextFingerprint(string book, string info, int start, int length) {
    return getFingerprint(getBook(book, info), start, length);
}

fingerprint getTextFingerprint(string book, string info, string start, string end, int startOffset, int endOffset) {
    Book b = getBook(book, info);
    int startPos = b.getVerseStart(start) + startOffset;
    int endPos = b.getVerseEnd(end) - endOffset;
    return getFingerprint(b, startPos, endPos - startPos + 1);
}

fingerprint getTextFingerprint(string book, string info, string start, string end) {
    return getTextFingerprint(book, info, start, end, 0, 0);
}

int compare(string book1, string info1, string verseInfo1s, string verseInfo1e, int startOffset1, int endOffset1,
            string book2, string info2, string verseInfo2s, string verseInfo2e, int startOffset2, int endOffset2) {
    info("Comparing " + book1 + " (" + info1 + ") " + verseInfo1s + "-" + verseInfo1e + " and "
         + book2 + " (" + info2 + ") " + verseInfo2s + "-" + verseInfo2e);
    Book b1 = getBook(book1, info1);
    Book b2 = getBook(book2, info2);
    int verse1s = b1.getVerseStart(verseInfo1s) + startOffset1;
    int verse1e = b1.getVerseEnd(verseInfo1e) - endOffset1;
    string verse1part = b1.getText().substr(verse1s, verse1e - verse1s + 1);
    int verse2s = b2.getVerseStart(verseInfo2s) + startOffset2;
    int verse2e = b2.getVerseEnd(verseInfo2e) - endOffset2;
    fingerprint f1 = getTextFingerprint(book1, info1, verseInfo1s, verseInfo1e, startOffset1, endOffset1);
    fingerprint f2 = getTextFingerprint(book2, info2, verseInfo2s, verseInfo2e, startOffset2, endOffset2);
    string verse2part = b2.getText().substr(verse2s, verse2e - verse2s + 1);
    int d = dist(f1, f2);
    info(verse1part + " ~ " + verse2part + " = " + to_string(d));
    float ratio = ((float) d+1) / (verse1part.length() + verse2part.length());
    info("difference = " + to_string(ratio));
    // printDist(f1, f2);
    return d;
}

string getText(string book, string info, string verseInfoS, string verseInfoE, int startOffset, int endOffset) {
    Book b = getBook(book, info);
    int verseS = b.getVerseStart(verseInfoS) + startOffset;
    int verseE = b.getVerseEnd(verseInfoE) - endOffset;
    if (verseS > verseE) {
        throw InvalidPassage;
    }
    string text = b.getText().substr(verseS, verseE - verseS + 1);
    return text;
}

int compareLatin(string verse1, string verse2) {
    int d = dist(verse1, verse2);
    info("Comparing '" + verse1 + "' ~ '" + verse2 + "' = " + to_string(d));
    float ratio = ((float) d+1) / (verse1.length() + verse2.length());
    info("difference = " + to_string(ratio));
    return d;
}

int compare(string verse1, string verse2) {
    int d = dist(processVerse(verse1), processVerse(verse2));
    info("Comparing '" + verse1 + "' ~ '" + verse2 + "' = " + to_string(d));
    float ratio = ((float) d+1) / (verse1.length() + verse2.length());
    info("difference = " + to_string(ratio));
    return d;
}

typedef struct fingerprintInfo {
    fingerprint fp;
    Book *book;
    int start, length;
} fingerprintInfo;

vector<fingerprintInfo> fingerprints;

void addFingerprint(fingerprint f, Book &b, int s, int l) {
    fingerprintInfo fpi = { f, &b, s, l };
    fingerprints.push_back(fpi);
}

fingerprint getFingerprintCached(Book &b, int s, int l) {
    for (int i = 0; i<fingerprints.size(); ++i) {
        fingerprintInfo fpi = fingerprints.at(i);
        if (fpi.book == &b)
            if ((fpi.start == s) && (fpi.length == l))
                return fpi.fp;
    }
}

typedef struct int2 {
    int coords[2];
} int2;

int findBestFit(string book1, string info1, string verseInfo1s, string verseInfo1e,
                string book2, string info2, string verseInfo2s, string verseInfo2e) {
    info("Comparing " + book1 + " (" + info1 + ") " + verseInfo1s + "-" + verseInfo1e + " and "
         + book2 + " (" + info2 + ") " + verseInfo2s + "-" + verseInfo2e);
    fingerprints.clear();
    Book b1 = getBook(book1, info1);
    Book b2 = getBook(book2, info2);
    int verse1s = b1.getVerseStart(verseInfo1s);
    int verse1e = b1.getVerseEnd(verseInfo1e);
    int verse1len = verse1e - verse1s;
    int verse2s = b2.getVerseStart(verseInfo2s);
    int verse2e = b2.getVerseEnd(verseInfo2e);
    int verse2len = verse2e - verse2s;
    int minlen = min(verse1len, verse2len);
    int maxlen = max(verse1len, verse2len);
    int bestValues[verse1len - MIN_CITATION_LENGTH + 1][verse2len - MIN_CITATION_LENGTH + 1],
            best1s[verse1len - MIN_CITATION_LENGTH + 1][verse2len - MIN_CITATION_LENGTH + 1],
            best1e[verse1len - MIN_CITATION_LENGTH + 1][verse2len - MIN_CITATION_LENGTH + 1],
            best2s[verse1len - MIN_CITATION_LENGTH + 1][verse2len - MIN_CITATION_LENGTH + 1],
            best2e[verse1len - MIN_CITATION_LENGTH + 1][verse2len - MIN_CITATION_LENGTH + 1];

    for (int i=0; i<verse1len - MIN_CITATION_LENGTH + 1; ++i)
        for (int j=0; j<verse2len - MIN_CITATION_LENGTH + 1; ++j)
            bestValues[i][j] = std::numeric_limits<int>::max();

    for (int i=0; i<verse1len - MIN_CITATION_LENGTH + 1; ++i) {
        int jmax = verse1len;
        for (int j=i + MIN_CITATION_LENGTH - 1; j<jmax; ++j) {
            fingerprint f = getTextFingerprint(book1, info1, verseInfo1s, verseInfo1e, i, verse1len - j);
            addFingerprint(f, b1, i, j-i+1);
        }
    }
    for (int i=0; i<verse2len - MIN_CITATION_LENGTH + 1; ++i) {
        int jmax = verse2len;
        for (int j=i + MIN_CITATION_LENGTH - 1; j<jmax; ++j) {
            fingerprint f = getTextFingerprint(book2, info2, verseInfo2s, verseInfo2e, i, verse2len - j);
            addFingerprint(f, b2, i, j-i+1);
        }
    }
    int imax = verse1len - MIN_CITATION_LENGTH + 1;
    for (int i=0; i<imax; ++i) {
        int jmax = verse1len;
        cout << (int) (i*100/imax) << "% done" << "\r";
        for (int j=i + MIN_CITATION_LENGTH - 1; j<jmax; ++j) {
            int kmax = verse2len - MIN_CITATION_LENGTH + 1;
            for (int k=0; k<kmax; ++k) {
                int lmax = verse2len;
                for (int l=k+MIN_CITATION_LENGTH - 1; l<lmax; ++l) {
                    fingerprint f1 = getFingerprintCached(b1, i, j-i+1);
                    fingerprint f2 = getFingerprintCached(b2, k, l-k+1);

                    int v1start = b1.getVerseStart(verseInfo1s);
                    string t1 = b1.getText().substr(v1start+i,j-i+1);
                    int v2start = b2.getVerseStart(verseInfo2s);
                    string t2 = b2.getText().substr(v2start+k,l-k+1);

                    int d = dist(f1, f2);
                    int length = max(j-i, l-k) + 1;
                    if (d < bestValues[j-i-MIN_CITATION_LENGTH][l-k-MIN_CITATION_LENGTH]) {
                        bestValues[j-i-MIN_CITATION_LENGTH][l-k-MIN_CITATION_LENGTH] = d;
                        best1s[j-i-MIN_CITATION_LENGTH][l-k-MIN_CITATION_LENGTH] = i;
                        best1e[j-i-MIN_CITATION_LENGTH][l-k-MIN_CITATION_LENGTH] = verse1len - j;
                        best2s[j-i-MIN_CITATION_LENGTH][l-k-MIN_CITATION_LENGTH] = k;
                        best2e[j-i-MIN_CITATION_LENGTH][l-k-MIN_CITATION_LENGTH] = verse2len - l;
                    }
                }
            }
        }
    }
    cout << endl;

    vector<int2> candidates;
    for (int i=0; i<verse1len-MIN_CITATION_LENGTH; ++i) {
        for (int j=0; j<verse2len-MIN_CITATION_LENGTH; ++j) {
            printf("%4d", bestValues[i][j]);
            if ((i>0) && (j>0) && (i<verse1len-MIN_CITATION_LENGTH-1) && (j<verse2len-MIN_CITATION_LENGTH)) {
                if ((bestValues[i][j] < bestValues[i-1][j]) &&
                        (bestValues[i][j] < bestValues[i][j-1]) &&
                        (bestValues[i][j] < bestValues[i+1][j]) &&
                        (bestValues[i][j] < bestValues[i][j+1]) &&
                        (bestValues[i][j] < bestValues[i+1][j+1])
                        ) {
                    candidates.push_back({i,j});
                }
            }
        }
        printf("\n");
    }

    for (int k=0; k<candidates.size(); ++k) {
        int2 c = candidates.at(k);
        int i = c.coords[0];
        int j = c.coords[1];
        compare(book1, info1, verseInfo1s, verseInfo1e, best1s[i][j],
                best1e[i][j],
                book2, info2, verseInfo2s, verseInfo2e, best2s[i][j],
                best2e[i][j]);
    }

    return 0;
}

string _find(string text, string moduleName, int maxFound, int verb) {
    int found = 0;
    size_t pos;
    string book;
    for (int i=0; i<books.size(); i++) {
        Book b = books[i];
        if (b.getInfo().compare(moduleName) == 0) {
            book = b.getName();
            string bookText = b.getText();
            pos = bookText.find(text);
            while (pos != std::string::npos) {
                if (verb == 1) {
                    info("Found in " + book + " " + b.getVerseInfoStart(pos) + " "
                         + b.getVerseInfoEnd(pos + text.length() - 1)
                         + " (book position " + to_string(pos + 1)
                         + "-" + to_string(pos + text.length())
                         + ")");
                }
                maxFound--;
                found++;
                if (maxFound == 0) {
                    goto end;
                }
                pos = bookText.find(text, pos + text.size());
            }
        }
    }
end:
    if (verb == 1) {
        info(to_string(found) + " occurrences.");
    }
    return to_string(found) + "," + book + "," + to_string(pos);
}

int find(string text, string moduleName, int maxFound, int verb) {
    string f = _find(text, moduleName, maxFound, verb);
    vector<string> info;
    boost::split(info, f, boost::is_any_of(","));
    return stoi(info[0]);
}

string find(string text, string moduleName) {
    string f = _find(text, moduleName, 1, 0);
    vector<string> info;
    boost::split(info, f, boost::is_any_of(","));
    return info[1] + "," + info[2];
}

vector<string> find_min_unique(string text, string moduleName, int verb) {
    vector<string> retval;
    int l = text.length();
    vector<vector<int>> is_unique(l, vector<int> (l)); // TODO: improve this to use just the half
    // Initialization:
    for (int i = 0; i < l; ++i) {
        for (int j = 0; j < l - i; ++j) {
            is_unique[i][j] = -1; // no info yet
        }
    }
    for (int i = 0; i < l; ++i) {
        for (int j = 0; j < l - i; ++j) {
            if (i > 0 && (is_unique[i - 1][j + 1] > 0 || is_unique[i - 1][j] > 0)) {
                is_unique[i][j] = 2;
            } else {
                string subtext = text.substr(j, i+1);
                int unique = find(subtext, moduleName, 2, 0);
                if (unique == 1) {
                    is_unique[i][j] = 1;
                    if (verb == 1) {
                        info("Text " + subtext + " is minimal unique.");
                    }
                    retval.push_back(subtext);
                } else {
                    is_unique[i][j] = 0;
                }
            }
        }
    }
    return retval;
}

string _extend(string moduleName1, string moduleName2, string book2, int pos2S, int pos2E, int verb) {
    Book b2 = getBook(book2, moduleName2);
    string text = b2.getText().substr(pos2S, pos2E - pos2S + 1);

    // checking the input
    if (find(text, moduleName1, 2, 0) != 1) {
        throw NoCitation;
    }

    bool citation = true;
    string found = find(text, moduleName1);
    vector<string> info1;
    boost::split(info1, found, boost::is_any_of(","));
    string book1 = info1[0];
    Book b1 = getBook(book1, moduleName1);
    int pos1S = stoi(info1[1]);

    string text1 = b1.getText();
    string text2 = b2.getText();

    while (citation && pos1S > 0 && pos2S > 0) {
        pos1S--;
        pos2S--;
        citation = text1.at(pos1S) == text2.at(pos2S);
    }
    pos1S++;
    pos2S++;
    citation = true;
    int pos1E = pos1S + pos2E - pos2S;
    while (citation && pos1E < text1.length() - 1 && pos2E < text2.length() - 1) {
        pos1E++;
        pos2E++;
        citation = text1.at(pos1E) == text2.at(pos2E);
    }
    pos1E--;
    pos2E--;
    string verse1infoS = b1.getVerseInfoStart(pos1S);
    string verse1infoE = b1.getVerseInfoEnd(pos1E);
    string verse2infoS = b2.getVerseInfoStart(pos2S);
    string verse2infoE = b2.getVerseInfoEnd(pos2E);
    if (verb == 1) {
        info("Extended match is " + ot_color + moduleName1 + " " + book1 + " "
            + verse1infoS + " " + verse1infoE + reset_color + " = " + nt_color + moduleName2 + " "
            + book2 + " " + verse2infoS + " " + verse2infoE + reset_color + " ("
            + ot_color + text1.substr(pos1S, pos1E - pos1S + 1) + reset_color + ", length "
            + to_string(pos1E - pos1S + 1) + ").");
    }
    return ot_color + moduleName1 + " " + book1 + " "
            + verse1infoS + " " + verse1infoE + reset_color + " = " + nt_color + moduleName2 + " "
            + book2 + " " + verse2infoS + " " + verse2infoE + reset_color + ","
            + to_string(pos1S) + "," + to_string(pos1E - pos1S + 1) + "," + to_string(pos2S);
}

void extend(string moduleName1, string moduleName2, string book2, string verse2S,
            int start, string verse2E, int end) {
    Book b2 = getBook(book2, moduleName2);
    int pos2S = b2.getVerseStart(verse2S) + start;
    int pos2E = b2.getVerseEnd(verse2E) - end;
    _extend(moduleName1, moduleName2, book2, pos2S, pos2E, 1);
}

vector<string> find_all(string text, string moduleName, int maxFound) {
    vector<string> retval;
    int found = 0;
    size_t pos;
    string book;
    for (int i=0; i<books.size(); i++) {
        Book b = books[i];
        if (b.getInfo().compare(moduleName) == 0) {
            book = b.getName();
            string bookText = b.getText();
            pos = bookText.find(text);
            while (pos != std::string::npos) {
                retval.push_back(book + "," + to_string(pos));
                maxFound--;
                found++;
                if (maxFound == 0) {
                    goto end;
                }
                pos = bookText.find(text, pos + text.size());
            }
        }
    }
end:
    return retval;
}

struct Reference {
    int pos1, pos2;
    int length;
    string text;
};

// Sort references.
bool compareReference(Reference r1, Reference r2) {
    return ((r1.length == r2.length) && r1.text.compare(r2.text) < 0)
            || r1.length < r2.length;
}

bool equalReference(Reference r1, Reference r2) {
    return (r1.text.compare(r2.text) == 0);
}

void getrefs(string moduleName2, string moduleName1, string book1, string verse1S,
            int start, string verse1E, int end) {
    vector<Reference> refs;
    Book b1 = getBook(book1, moduleName1);
    int pos1S = b1.getVerseStart(verse1S) + start;
    int pos1E = b1.getVerseEnd(verse1E) - end;
    string text = b1.getText().substr(pos1S, pos1E - pos1S + 1);
    vector<string> minunique = find_min_unique(text, moduleName1, 0);
    for (string m : minunique) {
        vector<string> found = find_all(m, moduleName2, maxresults);
        for (string f : found) {
            vector<string> info1, info2;
            boost::split(info1, f, boost::is_any_of(","));
            string book2 = info1[0];
            int pos = stoi(info1[1]);
            string ext = _extend(moduleName1, moduleName2, book2, pos, pos + m.length() - 1, 0);
            boost::split(info2, ext, boost::is_any_of(","));
            Reference r = {stoi(info2[1]), stoi(info2[3]), stoi(info2[2]), info2[0]};
            refs.push_back(r);
        }
    }
    sort(refs.begin(), refs.end(), compareReference);
    vector<Reference>::iterator it;
    it = unique(refs.begin(), refs.end(), equalReference);
    refs.resize(distance(refs.begin(), it));
    for (Reference r : refs) {
        info(r.text + " (length=" + to_string(r.length) + ", pos1=" + ot_color + to_string(r.pos1 + 1) + reset_color +
             ", pos2=" + nt_color + to_string(r.pos2 + 1) + reset_color + ")");
        if (sql) {
            info("insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values");
            string output = " (?, ?, ?, '" + ot_color + book1 + reset_color + "', ";
            output += ot_color;
            if (book1.compare("Psalms") == 0) {
                vector<string> verse1_split;
                boost::split(verse1_split, verse1S, boost::is_any_of(":"));
                output += verse1_split[0];
            } else {
                output += "null";
            }
            output += reset_color;
            output += ", ";
            vector<string> reference_split;
            boost::split(reference_split, r.text, boost::is_any_of("="));
            boost::algorithm::trim(reference_split[0]);
            boost::algorithm::trim(reference_split[1]);
            output += "'" + ot_color + reference_split[0] + reset_color + "', ";

            vector<string> verse2_split;
            boost::split(verse2_split, reference_split[1], boost::is_any_of(" "));
            output += "'" + nt_color + verse2_split[1] + reset_color + "', ";
            output += "'" + nt_color + reference_split[1] + reset_color + "', ";

            output += ot_color + to_string(r.pos1 + 1) + reset_color + ", ";
            output += ot_color + to_string(r.length) + reset_color + ", ";
            output += nt_color + to_string(r.pos2 + 1) + reset_color + ", ";
            output += nt_color + to_string(r.length) + reset_color + ", ";
            output += "'getrefs');";

            info(output);
        }
    }
}

void showAvailableBibles() {
    SWMgr manager(new MarkupFilterMgr(FMT_XHTML));
    ModMap::iterator it;
    int first = 1;
    string translations = "Available Bible translations: ";
    for (it = manager.Modules.begin(); it != manager.Modules.end(); ++it) {
        if (strcmp((*it).second->getType(), "Biblical Texts")==0) {
            if (first != 1) {
                translations += ", ";
            }
            string moduleName = (*it).second->getName();
            add_vocabulary_item(moduleName);
            translations += moduleName.c_str();
            first = 0;
        }
    }
    translations += ".";
    info(translations);
}

int getPsalmLastVerse(string moduleName, int psalm) {
    for (vector<PsalmsInfo>::iterator i=psalmsInfos.begin(); i!=psalmsInfos.end(); ++i) {
        PsalmsInfo pi = *i;
        if (pi.getInfo() == moduleName) {
            return pi.getLastVerse(psalm);
        }
    }
    throw InvalidModule;
}

