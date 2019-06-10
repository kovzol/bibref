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

string lookupVerse(string book, string info, string verse) {
    for (int i=0; i<books.size(); i++) {
        Book b = books[i];
        if (b.getName().compare(book) == 0 && b.getInfo().compare(info) == 0) {
            return b.getVerse(verse);
        }
    }
}

fingerprint getTextFingerprint(string book, string info, int start, int length) {
    for (int i=0; i<books.size(); i++) {
        Book b = books[i];
        if (b.getName().compare(book) == 0 && b.getInfo().compare(info) == 0) {
            fingerprint f = getFingerprint(b, start, length);
            return f;
        }
    }
}

fingerprint getTextFingerprint(string book, string info, string start, string end, int startOffset, int endOffset) {
    for (int i=0; i<books.size(); i++) {
        Book b = books[i];
        if (b.getName().compare(book) == 0 && b.getInfo().compare(info) == 0) {
            int startPos = b.getVerseStart(start) + startOffset;
            int endPos = b.getVerseEnd(end) - endOffset;
            fingerprint f = getFingerprint(b, startPos, endPos - startPos);
            return f;
        }
    }
}

fingerprint getTextFingerprint(string book, string info, string start, string end) {
    return getTextFingerprint(book, info, start, end, 0, 0);
}

