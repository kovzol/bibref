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

using namespace sword;

vector<Book> books;

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
        word = processWord(word);
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
            }
        }
    }
    cerr << " done" << "\n";
}

void addBooks() {
    addBook("LXX", "Genesis 1:1", "Malachi 4:6", false);
    addBook("SBLGNT", "Matthew 1:1", "Revelation 22:21", true);
}

string lookupVerse(string book, string info, string verse) {
    for (int i=0; i<books.size(); i++) {
        Book b = books[i];
        if (b.getName().compare(book) == 0 && b.getInfo().compare(info) == 0) {
            return b.getVerse(verse);
        }
    }
}
