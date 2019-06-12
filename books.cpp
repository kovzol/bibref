using namespace std;

#include <string>
#include <sstream>
#include <vector>

#include "swmgr.h"
#include "swmodule.h"
#include "swtext.h"
#include "markupfiltmgr.h"
#include "utf8greekaccents.h"

#include "book.h"
#include "fingerprint.h"

using namespace sword;

vector<Book> books;

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
                    c = 'w'; // sigma at the end of the word
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
}

void addBook(string moduleName, string firstVerse, string lastVerse, bool removeAccents) {
    SWMgr library(new MarkupFilterMgr(FMT_PLAIN));
    SWModule *module;
    module = library.getModule(moduleName.c_str());
    if (!module) {
        cerr << "The SWORD module " << moduleName << " is not installed" << "\n";
        exit(1);
    }
    module->setKey(firstVerse.c_str());
    int bookStart = module->getIndex();
    module->setKey(lastVerse.c_str());
    int bookEnd = module->getIndex();

    SWBuf verse;
    SWOptionFilter *filter = new UTF8GreekAccents();
    filter->setOptionValue("off");

    cerr << "Loading " << moduleName << "..." << flush;

    string lastBookName = splitVerseInfo(firstVerse).bookName;
    Book lastBook = Book(lastBookName);
    bool firstInfoSet = false;
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
            reference = vi.reference;
            if (lastBookName.compare(bookName) != 0) {
                books.push_back(lastBook);
                cerr << lastBookName << " has " << lastBook.getText().length() << " characters" << endl;
                // new book
                Book book = Book(bookName);
                book.setInfo(module->getBibliography().c_str());
                book.setInfo(moduleName);
                lastBook = book;
                lastBookName = bookName;
            }
            lastBook.addVerse(verseText, reference);
            if (verseInfo.compare(lastVerse)==0) {
                books.push_back(lastBook);
                cerr << lastBookName << " has " << lastBook.getText().length() << " characters" << endl;
            }
        }
    }
    cerr << " done" << "\n";
}

void addBooks() {
    addBook("LXX", "Genesis 1:1", "Malachi 4:6", false);
    addBook("SBLGNT", "Matthew 1:1", "Revelation of John 22:21", true);
}

Book getBook(string book, string info) {
    for (int i=0; i<books.size(); i++) {
        Book b = books[i];
        if (b.getName().compare(book) == 0 && b.getInfo().compare(info) == 0) {
            return b;
        }
    }
}

string lookupVerse(string book, string info, string verse) {
    return getBook(book, info).getVerse(verse);
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
    cout << "Comparing " << book1 << " (" << info1 << ") " << verseInfo1s << "-" << verseInfo1e << " and "
         << book2 << " (" << info2 << ") " << verseInfo2s << "-" << verseInfo2e << endl;
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
    cout << verse1part << " ~ " << verse2part << " = " << d << endl;
    return d;
}

int compare(string verse1, string verse2) {
    int d = dist(processVerse(verse1), processVerse(verse2));
    cout << "Comparing '" << verse1 << "' ~ '" << verse2 << "' = " << d << endl;
}
