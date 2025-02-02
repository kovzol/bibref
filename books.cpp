#define BIBREF_ADDBOOKS_CACHE_DIR "bibref-addbooks-cache/" // this is hardcoded

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

using namespace std;

#include "swmgr.h"
#include "swmodule.h"
#include "swtext.h"
#include "markupfiltmgr.h"
#include "utf8greekaccents.h"
#include "versekey.h"

#include "book.h"
#include "fingerprint.h"
#include "cli.h"
#include "psalmsinfo.h"

class InvalidModuleException: public exception
{
  virtual const char* what() const throw()
  {
    return "Invalid module.";
  }
} InvalidModuleException;

class InvalidBookException: public exception
{
  virtual const char* what() const throw()
  {
    return "Invalid book.";
  }
} InvalidBookException;

class InvalidVerseException: public exception
{
  virtual const char* what() const throw()
  {
    return "Invalid verse.";
  }
} InvalidVerseException;

class InvalidPassageException: public exception
{
  virtual const char* what() const throw()
  {
    return "Invalid passage.";
  }
} InvalidPassageException;

class NoCitationException: public exception
{
  virtual const char* what() const throw()
  {
    return "Passage is not a citation.";
  }
} NoCitationException;

using namespace sword;

vector<Book> books;
vector<PsalmsInfo> psalmsInfos;

string latinToGreek(const string& latin) {
  string greek = latin;
  string to[25] = {"α", "β", "ψ", "δ", "ε", "φ", "γ", "η", "ι", "ξ", "κ",
    "λ", "μ", "ν", "ο", "π", "ζ", "ρ", "σ", "τ", "θ", "ω", "ς", "χ", "υ"};
  for (char c = 'a'; c < 'z'; c++) {
    string from;
    from = c;
    boost::replace_all(greek, from, to[c - 'a']);
  }
  return greek;
}

/// Convert the input word to a-y encoding.
string greekToLatin(string word) {
  /*
  int D=0;
  if (word.find("ησαΰας") == 0) {
    cout << "DEBUG1: " << word << "\n";
    D=1;
    }
  */
  // This could be simplified, similarly to the latinToGreek conversion.
  string rewritten; // Here we store the output step by step, for each letter.
  for (int i = 0; i < word.length(); i += 2) { // jumping by 2 bytes in Unicode
    auto c1 = static_cast<unsigned char>(word[i]); // first Unicode byte
    auto c2 = static_cast<unsigned char>(word[i + 1]); // second Unicode byte
    /* if (D==1) { printf("c1=%x c2=%x\n", c1, c2); } */
    // keep care of special characters
    if (c1 == 0x80) {
      i--; // jump 1 byte back
    }
    // keep only Greek characters
    if (c1 == 0xCE || c1 == 0xCF) { // Greek characters begin with one of these two bytes.
      char c = '-'; // by default we don't have a candidate
      switch (c1) {
      case 0xCE: // Characters from alpha to omicron...
        switch (c2) {
        case 0xB0:
          c = 'i'; // this is actually ΰ (upsilon) in Unicode, but Sword internally identifies it as an iota (in e.g. Romans 9:29)
          break;
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
        case 0xD0:
          c = 'y'; // In πραΰς (Matthew 11:29)
          break;
        }
        break;
      case 0xCF: // Characters from pi to omega...
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
        break; // by default, no character will be stored
      }
      if (c=='-') {
        char s[5];
        sprintf(s, "%2x%2x", c1, c2);
        error("Unidentified Greek character in word " + word + " (" + string(s) + ")");
        exit(1);
      }
      rewritten.push_back(c); // store c in the output
    }
  }
  /*
  if (rewritten.find("hsa-a") == 0) {
    cout << "DEBUG2: " << rewritten << "\n";
    // exit(1);
    }
  */
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
    if (c1 == '|') { // in BHPGNT, e.g. "kyrios" is preceded with this
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
      rewritten.push_back((unsigned char)0xCF);
      rewritten.push_back((unsigned char)0x83);
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

int processWordAsToken(string word) {
  int num = 0;
  for (int i = 0; i < word.length(); i += 2) {
    auto c1 = static_cast<unsigned char>(word[i]);
    auto c2 = static_cast<unsigned char>(word[i + 1]);
    // keep care of special characters
    if (c1 == 0x80) {
      i--;
    }
    if (c1 == '|') { // in BHPGNT, e.g. "kyrios" is preceded with this
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
    }
    // check Greek characters
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
    }
    if (c1 >= '0' && c1 <= '9') {
      // glue this after num, e.g. 123 will be processed like ((0+1)*10+2)*10+3
      num *= 10;
      num += (c1 - '0');
      i--;
    }
  }
  return num;
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

vector<int> processTokens(const string &verse) {
  vector<int> out;
  string word;
  stringstream ss(verse);

  while (ss >> word) {
    int token = processWordAsToken(word);
    if (token > 0) {
      out.push_back(token);
    }
  }

  return out;
}

typedef struct VerseInfo {
  string m_bookName;
  string m_reference;
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
  throw InvalidPassageException;
}

bool isOTBook(const string& moduleName) {
  if (moduleName == "LXX") return true;
  return false;
}

bool isNTBook(const string& moduleName) {
  if (moduleName == "SBLGNT" || moduleName == "StatResGNT") return true;
  return false;
}

int lookupTranslation(string moduleName, string book, const string& verse) {
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
  // This seems to be required for some strange reason, see
  // SWORD's example "simplechapter". We create the key from
  // the lookup string (e.g. "Psalms 114:9") and then
  // re-read it:
  VerseKey *key = (VerseKey*) module->getKey();
  int verseN = key->getVerse();
  key->setVerse(verseN);
  // Maybe, in some cases, this is required because of
  // the internal structure of the module.
  string text;
  if (isOTBook(moduleName))
    text += ot_color;
  if (isNTBook(moduleName))
    text += nt_color;
  text += module->renderText().c_str();
  if (isOTBook(moduleName) || isNTBook(moduleName))
    text += reset_color;
  info(text);
  return 0;
}

/// Loaded all books of a Bible edition.
int addBooks_cached(string moduleName) {
  vector<string> bookNames;
  // This is needed for correct alphabetical ordering:
  if (isOTBook(moduleName)) { // These books should be loaded from the Old Testament...
    bookNames={"Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy",
               "Joshua", "Judges", "Ruth",
               "I_Samuel", "II_Samuel", "I_Kings", "II_Kings", "I_Chronicles", "II_Chronicles",
               "I_Esdras",
               "Ezra", "Nehemiah", "Esther",
               "Judith", "Tobit", "I_Maccabees", "II_Maccabees", "III_Maccabees", "IV_Maccabees",
               "Psalms",
               "Prayer_of_Manasses", // missing from LXX 3.0
               "Proverbs", "Ecclesiastes", "Song_of_Solomon",
               "Job",
               "Wisdom", "Sirach", "Psalms_of_Solomon",
               "Hosea", "Amos", "Micah", "Joel", "Obadiah", "Jonah",
               "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi",
               "Isaiah", "Jeremiah",
               "Baruch",
               "Lamentations", "Epistle_of_Jeremiah",
               "Ezekiel",
               "Prayer_of_Azariah", // missing from LXX 3.0
               "Susanna",
               "Daniel",
               "Bel_and_the_Dragon",
               "I_Enoch", // missing from LXX 3.0
               "Odes"
               };
  }
  if (isNTBook(moduleName)) { // These books should be loaded from the New Testament...
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

  string path = BIBREF_ADDBOOKS_CACHE_DIR + moduleName;

  PsalmsInfo pi = PsalmsInfo(moduleName); // create database for Psalms
  for (int i=1; i<=151; i++) pi.setLastVerse(i, 0); // initialize

  for (vector<string>::iterator i=bookNames.begin(); i!=bookNames.end(); ++i) {
    string bookName = *i;
    std::ifstream bookFile(path + "/" + bookName + ".book"); // open a-y encoded raw book
    if (!bookFile.good()) continue; // do not continue for this book, because it does not exist in the module
    // TODO: This check should be done for the other file types to handle non-existence properly
    std::stringstream buffer;
    buffer << bookFile.rdbuf();
    Book book = Book(bookName);
    book.setText(string(buffer.str()));

    std::ifstream tokensFile(path + "/" + bookName + ".tokens"); // open tokens for the given book
    vector<int> tokens;
    int t;
    while (tokensFile >> t)
    {
      tokens.push_back(t); // read tokens
    }
    book.setTokens(tokens);

    // Loading verses:
    string verseFileName = path + "/" + bookName + ".verses";
    FILE *verseFile = fopen(verseFileName.c_str(), "r");
    int start, end, tokensStart, tokensEnd;
    try {
      char reference[8]; // Psalms 119:176 needs 7 characters + "\n"
      // cout << bookName << endl;
      while (fscanf(verseFile, "%7s %d %d %d %d", reference, &start, &end, &tokensStart, &tokensEnd) != EOF) {
        if (bookName == "Psalms") {
          vector<string> r;
          boost::split(r, reference, boost::is_any_of(":"));
          pi.setLastVerse(stoi(r[0]), stoi(r[1])); // this overwrites the previous entry
        }
        book.addVerse(start, end - start + 1, string(reference), tokensStart, tokensEnd - tokensStart + 1);
      }
    } catch (exception &e) {
      error("Data loading error from cache file " + verseFileName + ".");
      error("Cache may be corrupt or incompatible with this version. Consider removing it, then retry.");
      error("To avoid data corruption, bibref exits now. Sorry for any inconveniences.");
      exit(1); // Inform the user and exit, since this is a fatal error.
    }

    fclose(verseFile);
    add_vocabulary_item(bookName); // add readline entry for this book
    book.setModuleName(moduleName); // put this book in the given Bible edition
    books.push_back(book);
  }
  psalmsInfos.push_back(pi); // store Psalm database
  info("Done loading books of " + moduleName + " (cached).");
  return 0; // Success!
}

/// Load a Bible edition, and save it on the disk for a future cache (if there is no cache saved yet).
int addBooks(string moduleName, string firstVerse, string lastVerse, bool removeAccents) {
  DIR* cache_dir = opendir((BIBREF_ADDBOOKS_CACHE_DIR + moduleName).c_str());
  if (cache_dir) { // If there is a cache saved on the disk, we'll use it.
    closedir(cache_dir);
    addBooks_cached(moduleName); // Load the book from the cache.
    return 0; // No further operation is required.
  }
  SWMgr library(new MarkupFilterMgr(FMT_PLAIN));
  SWModule *module;
  module = library.getModule(moduleName.c_str()); // Trying to load the Sword module.
  if (!module) {
    error("The SWORD module " + moduleName + " is not installed.");
    return 1; // If not possible, return with an error.
  }

  string version = module->getConfigEntry("Version");
  // It's better to avoid LXX 3.0, it is a completely different edition!
  if (moduleName == "LXX" && version == "3.0") {
    removeAccents = true; // force removing accents
    // lastVerse = "Daniel 12:13"; // order of books is different
    lastVerse = "Odes 1:19"; // order of books is different
  }

  // Set first and last verses of the book.
  module->setKey(firstVerse.c_str());
  int bookStart = module->getIndex();
  module->setKey(lastVerse.c_str());
  int bookEnd = module->getIndex();

  SWBuf verse;
  SWOptionFilter *filter = new UTF8GreekAccents();
  filter->setOptionValue("off");
  library.setGlobalOption("Strong's Numbers", "On");

  info("Loading " + moduleName + "...");
  string path = "bibref-addbooks-cache/" + moduleName;
  bool create_cache = true; // Hopefully we can set up a new cache.

#ifndef __EMSCRIPTEN__ // In the web version we don't save the cache, but assume that it exists.
  try {
    boost::filesystem::create_directories(path);
  } catch (exception &e) {
    error("The addbooks cache cannot be saved in this folder.");
    create_cache = false; // No, we cannot use a cache in this session.
  }
#endif
  add_vocabulary_item(moduleName); // Add the name of this Bible edition to the readline vocabulary.

  string lastBookName = splitVerseInfo(firstVerse).m_bookName;
  Book lastBook = Book(lastBookName);
  bool firstInfoSet = false;
  FILE *lastBookVersesFile = NULL;

  PsalmsInfo pi = PsalmsInfo(moduleName); // We store the number of verses for the Psalms.
  // TODO: This is probably unnecessary, remove it, if it is not required:
  for (int i=1; i<=151; i++) pi.setLastVerse(i, 0); // initialize

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
        lastBook.setModuleName(module->getBibliography().c_str());
        lastBook.setModuleName(moduleName);
        firstInfoSet = true;
      }
      string verseText = processVerse(verse.c_str());
      vector<int> tokens = processTokens(verse.c_str());
      // split book name and verse reference
      bool found = false;
      string reference;
      string bookName;
      VerseInfo vi = splitVerseInfo(verseInfo);
      bookName = vi.m_bookName;
      // Use I_Peter instead of "I Peter" on all occurrences:
      boost::replace_all(bookName, " ", "_");
      reference = vi.m_reference;
      if (lastBookName.compare(bookName) != 0) {
        books.push_back(lastBook);
        string lastBookText = lastBook.getText();
        vector<int> lastBookTokens = lastBook.getTokens();
#ifndef __EMSCRIPTEN__
        if (create_cache) { // Create the cache if it is possible. Open the raw book and tokens.
          FILE *lastBookFile = fopen((path + "/" + lastBookName + ".book").c_str(), "wa");
          fprintf(lastBookFile, "%s", lastBookText.c_str());
          fclose(lastBookFile);
          FILE *lastTokensFile = fopen((path + "/" + lastBookName + ".tokens").c_str(), "wa");
          for (auto t: lastBookTokens) {
            fprintf(lastTokensFile, "%d ", t);
          }
          fclose(lastTokensFile);
        }
#endif
        info(lastBookName + " contains " + to_string(lastBookText.length()) + " characters,");
        add_vocabulary_item(lastBookName); // Add the name of the current book to the readline vocabulary.
        // new book
        Book book = Book(bookName);
        book.setModuleName(module->getBibliography().c_str());
        book.setModuleName(moduleName);
        lastBook = book;
        lastBookName = bookName;

        if (create_cache) {
          fclose(lastBookVersesFile);
          lastBookVersesFile = fopen((path + "/" + lastBookName + ".verses").c_str(), "wa");
        }
      } else {
        if (lastBookVersesFile == NULL && create_cache)
          lastBookVersesFile = fopen((path + "/" + lastBookName + ".verses").c_str(), "wa");
      }
      lastBook.addVerse(verseText, reference, tokens);

      if (bookName == "Psalms") {
        vector<string> r;
        boost::split(r, reference, boost::is_any_of(":"));
        pi.setLastVerse(stoi(r[0]), stoi(r[1])); // this overwrites the previous entry
      }

#ifndef __EMSCRIPTEN__
      if (create_cache) {
        int start = lastBook.getVerseStart(reference);
        int end = lastBook.getVerseEnd(reference);
        int tokensStart = lastBook.getVerseTokensStart(reference);
        int tokensEnd = lastBook.getVerseTokensEnd(reference);
        // Save the character positions for the a-y raw text and for the tokens.
        fprintf(lastBookVersesFile, "%s %d %d %d %d\n", reference.c_str(), start, end, tokensStart, tokensEnd);
      }
#endif
      if (verseInfo.compare(lastVerse)==0) {
        books.push_back(lastBook); // Add this book to the Bible edition.
        string lastBookText = lastBook.getText();
        vector<int> lastBookTokens = lastBook.getTokens();
#ifndef __EMSCRIPTEN__
        if (create_cache) {
          FILE *lastBookFile = fopen((path + "/" + lastBookName + ".book").c_str(), "wa");
          fprintf(lastBookFile, "%s\n", lastBookText.c_str()); // Dump the a-y raw book as string.
          fclose(lastBookFile);

          FILE *lastTokensFile = fopen((path + "/" + lastBookName + ".tokens").c_str(), "wa");
          for (auto t: lastBookTokens) {
            fprintf(lastTokensFile, "%d ", t); // Save the tokens as numbers.
          }
          fclose(lastTokensFile);

          fclose(lastBookVersesFile);
        }
#endif
        info("and " + lastBookName + " contains " + to_string(lastBook.getText().length()) + " characters.");
        add_vocabulary_item(lastBookName); // Add the name of the last book to the readline vocabulary.
      }
    }
  }
  psalmsInfos.push_back(pi); // Save the last verse numbers of the Psalms.

  info("Done loading books of " + moduleName + ".");
  return 0; // Success!
}

int addBibles() {
  int success = 0;
  if (addBooks("LXX", "Genesis 1:1", "Malachi 4:6", false) !=0 ) {
    success = 1;
  }
  if (addBooks("SBLGNT", "Matthew 1:1", "Revelation of John 22:21", true) != 0) {
    success = 1;
  }
  if (addBooks("StatResGNT", "Matthew 1:1", "Revelation of John 22:21", true) != 0) {
    success = 1;
  }
  return success;
}

Book getBook(string book, string info) {
  for (int i=0; i<books.size(); i++) {
    Book b = books[i];
    if (b.getName().compare(book) == 0 && b.getModuleName().compare(info) == 0) {
      return b;
    }
  }
  throw InvalidBookException;
}

string lookupVerse(const string& book, const string& info, const string& verse) {
  try {
    Book b = getBook(book, info);
    string ret = b.getVerse(verse);
    if (ret.length() == 0) {
      throw InvalidVerseException;
    }
    return ret;
  } catch (exception &e) {
    error(e.what());
    throw InvalidVerseException;
  }
}

int lookupVerseStart(const string& book, const string& info, const string& verse) {
  try {
    Book b = getBook(book, info);
    int ret = b.getVerseStart(verse);
    return ret;
  } catch (exception &e) {
    error(e.what());
    throw InvalidVerseException;
  }
}

Fingerprint getTextFingerprint(const string& book, const string& info, int start, int length) {
  return getFingerprint(getBook(book, info), start, length);
}

Fingerprint getTextFingerprint(const string& book, const string& info, const string& start, const string& end, int startOffset, int endOffset) {
  Book b = getBook(book, info);
  int startPos = b.getVerseStart(start) + startOffset;
  int endPos = b.getVerseEnd(end) - endOffset;
  return getFingerprint(b, startPos, endPos - startPos + 1);
}

Fingerprint getTextFingerprint(const string& book, const string& info, const string& start, const string& end) {
  return getTextFingerprint(book, info, start, end, 0, 0);
}

int compare(const string& book1, const string& info1, const string& verseInfo1s, const string& verseInfo1e, int startOffset1, int endOffset1,
            const string& book2, const string& info2, const string& verseInfo2s, const string& verseInfo2e, int startOffset2, int endOffset2) {
  info("Comparing " + book1 + " (" + info1 + ") " + verseInfo1s + "-" + verseInfo1e + " and "
       + book2 + " (" + info2 + ") " + verseInfo2s + "-" + verseInfo2e);
  Book b1 = getBook(book1, info1);
  Book b2 = getBook(book2, info2);
  int verse1s = b1.getVerseStart(verseInfo1s) + startOffset1;
  int verse1e = b1.getVerseEnd(verseInfo1e) - endOffset1;
  string verse1part = b1.getText().substr(verse1s, verse1e - verse1s + 1);
  int verse2s = b2.getVerseStart(verseInfo2s) + startOffset2;
  int verse2e = b2.getVerseEnd(verseInfo2e) - endOffset2;
  Fingerprint f1 = getTextFingerprint(book1, info1, verseInfo1s, verseInfo1e, startOffset1, endOffset1);
  Fingerprint f2 = getTextFingerprint(book2, info2, verseInfo2s, verseInfo2e, startOffset2, endOffset2);
  string verse2part = b2.getText().substr(verse2s, verse2e - verse2s + 1);
  int d = dist(f1, f2);
  info(verse1part + " ~ " + verse2part + " = " + to_string(d));
  float ratio = ((float) d+1) / (verse1part.length() + verse2part.length());
  info("difference = " + to_string(ratio));
  // printDist(f1, f2);
  return d;
}

string getText(const string& book, const string& info, const string& verseInfoS, const string& verseInfoE, int startOffset, int endOffset) {
  Book b = getBook(book, info);
  int verseS = b.getVerseStart(verseInfoS) + startOffset;
  int verseE = b.getVerseEnd(verseInfoE) - endOffset;
  if (verseS > verseE) {
    throw InvalidPassageException;
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


/* The following part is experimental code and currently unmaintained. */

/*

class InternalErrorException: public exception
{
  virtual const char* what() const throw()
  {
    return "Internal error.";
  }
} InternalErrorException;

typedef struct FingerprintInfo {
  Fingerprint m_fp;
  Book *m_book;
  int m_start, m_length;
} FingerprintInfo;

vector<FingerprintInfo> fingerprints;

void addFingerprint(Fingerprint f, Book &b, int s, int l) {
  FingerprintInfo fpi = { f, &b, s, l };
  fingerprints.push_back(fpi);
}

Fingerprint getFingerprintCached(Book &b, int s, int l) {
  for (int i = 0; i<fingerprints.size(); ++i) {
    FingerprintInfo fpi = fingerprints.at(i);
    if (fpi.m_book == &b)
      if ((fpi.m_start == s) && (fpi.m_length == l))
        return fpi.m_fp;
  }
  throw InternalErrorException;
}

typedef struct Int2 {
  int m_coords[2];
} Int2;

#define MIN_CITATION_LENGTH 10
// FIXME: static arrays are too big here, find a dynamic solution

int findBestFit(const string& book1, const string& info1, const string& verseInfo1s, const string& verseInfo1e,
                const string& book2, const string& info2, const string& verseInfo2s, const string& verseInfo2e) {
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
  // int minlen = min(verse1len, verse2len);
  // int maxlen = max(verse1len, verse2len);
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
      Fingerprint f = getTextFingerprint(book1, info1, verseInfo1s, verseInfo1e, i, verse1len - j);
      addFingerprint(f, b1, i, j-i+1);
    }
  }
  for (int i=0; i<verse2len - MIN_CITATION_LENGTH + 1; ++i) {
    int jmax = verse2len;
    for (int j=i + MIN_CITATION_LENGTH - 1; j<jmax; ++j) {
      Fingerprint f = getTextFingerprint(book2, info2, verseInfo2s, verseInfo2e, i, verse2len - j);
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
          Fingerprint f1 = getFingerprintCached(b1, i, j-i+1);
          Fingerprint f2 = getFingerprintCached(b2, k, l-k+1);

          int v1start = b1.getVerseStart(verseInfo1s);
          string t1 = b1.getText().substr(v1start+i,j-i+1);
          int v2start = b2.getVerseStart(verseInfo2s);
          string t2 = b2.getText().substr(v2start+k,l-k+1);

          int d = dist(f1, f2);
          // int length = max(j-i, l-k) + 1;
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

  vector<Int2> candidates;
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
    Int2 c = candidates.at(k);
    int i = c.m_coords[0];
    int j = c.m_coords[1];
    compare(book1, info1, verseInfo1s, verseInfo1e, best1s[i][j],
            best1e[i][j],
            book2, info2, verseInfo2s, verseInfo2e, best2s[i][j],
            best2e[i][j]);
  }

  return 0;
}

*/

/* End of experimental code. */

/// Low level algorithm to find exact string match in the a-y encoded books.
/// @return "f,b,p" where f is the number of occurrences, b is the book name of the last occurrence and p is its position.
string _find(string text, string moduleName, int maxFound, bool verbose) {
  int found = 0; // number of occurrences
  size_t pos; // character position of last result
  string book; // book to search for
  for (int i=0; i<books.size(); i++) { // iterate on all books...
    Book b = books[i];
    if (b.getModuleName().compare(moduleName) == 0) { // ...in this Bible edition
      book = b.getName();
      string bookText = b.getText();
      pos = bookText.find(text); // find first occurrence
      while (pos != std::string::npos) { // if found
        if (verbose) {
          info("Found in " + book + " " + b.getVerseInfoStart(pos) + " "
               + b.getVerseInfoEnd(pos + text.length() - 1)
               + " (book position " + to_string(pos + 1)
               + "-" + to_string(pos + text.length())
               + ")"); // report success in verbose mode is on
        }
        maxFound--;
        found++;
        if (maxFound == 0) {
          goto end; // stop searching if the limit is reached
        }
        pos = bookText.find(text, pos + text.size()); // find next occurrence
      }
    }
  }
end:
  if (verbose) {
    info(to_string(found) + " occurrences."); // verbose report the number of occurrences
  }
  return to_string(found) + "," + book + "," + to_string(pos); // return concise data
}

/// Return the number of occurrences of an a-y encoded text in Bible edition moduleName.
int find(const string& text, const string& moduleName, int maxFound, bool verbose) {
  string f = _find(text, moduleName, maxFound, verbose);
  vector<string> info;
  boost::split(info, f, boost::is_any_of(","));
  return stoi(info[0]);
}

/// Return the book name and position of the last occurrence of an a-y encoded text in Bible edition moduleName.
/// @return "b,p" where b is the book name of the last occurrence and p is its position.
string find(const string& text, const string& moduleName) {
  string f = _find(text, moduleName, 1, 0);
  vector<string> info;
  boost::split(info, f, boost::is_any_of(","));
  return info[1] + "," + info[2];
}

vector<string> find_min_unique(string text, const string& moduleName, bool verbose) {
  int long_limit = 10000; // below this the algorithm should work fast enough
  int extreme_limit = 50000; // above this there is no hope to get a result because of out of memory error
  vector<string> retval;
  int l = text.length();
  if (l > extreme_limit) { // warn the user, but don't stop
    error("Input is extremely long (" + to_string(l) + " characters), expect out of memory error.");
  } else if (l > long_limit) {
    error("Input is very long (" + to_string(l) + " characters), expect very slow operation.");
  }
  vector<vector<int>> is_unique(l, vector<int> (l)); // TODO: improve this to use just the half
  if (l > long_limit) {
    error("Memory successfully reserved.");
  }

  // Initialization:
  for (int i = 0; i < l; ++i) {
    for (int j = 0; j < l - i; ++j) {
      is_unique[i][j] = -1; // no info yet
    }
  }
  for (int i = 0; i < l; ++i) {
    for (int j = 0; j < l - i; ++j) {
      if (i > 0 && (is_unique[i - 1][j + 1] > 0 || is_unique[i - 1][j] > 0)) {
        is_unique[i][j] = 2; // this entry can already be ignored
      } else {
        string subtext = text.substr(j, i+1);
        int unique = find(subtext, moduleName, 2, 0); // decide if this subtext is unique
        if (unique == 1) {
          is_unique[i][j] = 1; // if yes, fill in the database
          if (verbose) {
            info("Text " + subtext + " is minimal unique."); // inform the user if needed
          }
          retval.push_back(subtext); // store this result
        } else {
          is_unique[i][j] = 0; // if no, fill in the database
        }
      }
    }
  }
  return retval; // return the list of minimally unique subtexts
}

/// Low level algorithm to extend a passage that is unique in another edition to be maximally long, and keep verbatim equality.
string _extend(const string& moduleName1, const string& moduleName2, const string& book2, int pos2S, int pos2E, bool verbose) {
  Book b2 = getBook(book2, moduleName2); // the book where the passage will be extended
  string text = b2.getText().substr(pos2S, pos2E - pos2S + 1); // the passage to extend

  // checking the input
  if (find(text, moduleName1, 2, 0) != 1) {
    throw NoCitationException; // this passage is not present in the assumed Bible edition, that's an error
  }

  bool citation = true;
  string found = find(text, moduleName1);
  vector<string> info1;
  boost::split(info1, found, boost::is_any_of(","));
  string book1 = info1[0]; // last occurrence of passage in the other edition is in book1
  Book b1 = getBook(book1, moduleName1);
  int pos1S = stoi(info1[1]); // last position of passage in the other edition is pos1S

  string text1 = b1.getText(); // the whole Bible text of the other edition
  string text2 = b2.getText(); // the whole Bible text of the edition of the passage

  while (citation && pos1S > 0 && pos2S > 0) { // shift left in both Bible editions
    pos1S--;
    pos2S--;
    citation = text1.at(pos1S) == text2.at(pos2S); // until there is no plausible verbatim citation anymore
  }
  pos1S++; // fix start pointer for the other edition
  pos2S++; // fix start pointer for the edition of the input passage
  citation = true;
  int pos1E = pos1S + pos2E - pos2S;
  while (citation && pos1E < text1.length() - 1 && pos2E < text2.length() - 1) { // shift right in both editions
    pos1E++;
    pos2E++;
    citation = text1.at(pos1E) == text2.at(pos2E);
  }
  pos1E--; // fix end pointer for the other edition
  pos2E--; // fix end pointer for the edition of the input passage
  string verse1infoS = b1.getVerseInfoStart(pos1S);
  string verse1infoE = b1.getVerseInfoEnd(pos1E);
  string verse2infoS = b2.getVerseInfoStart(pos2S);
  string verse2infoE = b2.getVerseInfoEnd(pos2E);
  if (verbose) {
    info("Extended match is " + ot_color + moduleName1 + " " + book1 + " "
         + verse1infoS + " " + verse1infoE + reset_color + " = " + nt_color + moduleName2 + " "
         + book2 + " " + verse2infoS + " " + verse2infoE + reset_color + " ("
         + ot_color + text1.substr(pos1S, pos1E - pos1S + 1) + reset_color + ", length "
         + to_string(pos1E - pos1S + 1) + ")."); // report info verbosely
  }
  return ot_color + moduleName1 + " " + book1 + " "
      + verse1infoS + " " + verse1infoE + reset_color + " = " + nt_color + moduleName2 + " "
      + book2 + " " + verse2infoS + " " + verse2infoE + reset_color + ","
      + to_string(pos1S) + "," + to_string(pos1E - pos1S + 1) + "," + to_string(pos2S); // return concise report
}

void extend(const string& moduleName1, const string& moduleName2, const string& book2, const string& verse2S,
            int start, const string& verse2E, int end) {
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
    if (b.getModuleName().compare(moduleName) == 0) {
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
  int m_pos1, m_pos2;
  int m_length;
  string m_text;
};

// Sort references.
bool compareReference(Reference r1, Reference r2) {
  return ((r1.m_length == r2.m_length) && r1.m_text.compare(r2.m_text) < 0)
      || r1.m_length < r2.m_length;
}

bool equalReference(Reference r1, Reference r2) {
  return (r1.m_text.compare(r2.m_text) == 0);
}

void getrefs(const string& moduleName2, const string& moduleName1, const string& book1, const string& verse1S,
             int start, const string& verse1E, int end) {
  vector<Reference> refs; // store plausible references in a vector
  Book b1 = getBook(book1, moduleName1); // the input passage is in book b1
  int pos1S = b1.getVerseStart(verse1S) + start; // exact start position of the input passage
  int pos1E = b1.getVerseEnd(verse1E) - end; // exact end position of the input passage
  string text = b1.getText().substr(pos1S, pos1E - pos1S + 1); // the input passage
  vector<string> minunique = find_min_unique(text, moduleName1, 0); // get all minimally unique subtexts of the input
  for (string m : minunique) { // For each subtext...
    vector<string> found = find_all(m, moduleName2, maxresults); // find all plausible verbatim quotations in the other edition
    for (string f : found) { // For each candidate...
      vector<string> info1, info2;
      boost::split(info1, f, boost::is_any_of(","));
      string book2 = info1[0]; // book2 contains the book of the other edition
      int pos = stoi(info1[1]); // pos stores the position of plausible verbatim quotation in the other edition
      string ext = _extend(moduleName1, moduleName2, book2, pos, pos + m.length() - 1, 0); // Extend the plausible quotation...
      boost::split(info2, ext, boost::is_any_of(","));
      Reference r = {stoi(info2[1]), stoi(info2[3]), stoi(info2[2]), info2[0]};
      refs.push_back(r); // Store the result.
    }
  }
  sort(refs.begin(), refs.end(), compareReference); // Sort the results by text length (of the extension).
  vector<Reference>::iterator it;
  it = unique(refs.begin(), refs.end(), equalReference); // Delete duplicates.
  refs.resize(distance(refs.begin(), it)); // Free memory.
  for (Reference r : refs) { // Show all references.
    info(r.m_text + " (length=" + to_string(r.m_length) + ", pos1=" + ot_color + to_string(r.m_pos1 + 1) + reset_color +
         ", pos2=" + nt_color + to_string(r.m_pos2 + 1) + reset_color + ")");
    if (sql) { // In sql mode output the required SQL statement skeleton as well.
      info("insert into quotations (nt_quotation_id, ot_id, nt_id, ot_book, psalm, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method) values");
      string output = " (?, ?, ?, '" + ot_color + book1 + reset_color + "', ";
      output += ot_color;
      if (book1.compare("Psalms") == 0) { // handle Psalms in a special way (because of the SQL database)
        vector<string> verse1_split;
        boost::split(verse1_split, verse1S, boost::is_any_of(":"));
        output += verse1_split[0];
      } else {
        output += "null";
      }
      output += reset_color;
      output += ", ";
      vector<string> reference_split;
      boost::split(reference_split, r.m_text, boost::is_any_of("="));
      boost::algorithm::trim(reference_split[0]);
      boost::algorithm::trim(reference_split[1]);
      output += "'" + ot_color + reference_split[0] + reset_color + "', ";

      vector<string> verse2_split;
      boost::split(verse2_split, reference_split[1], boost::is_any_of(" "));
      output += "'" + nt_color + verse2_split[1] + reset_color + "', ";
      output += "'" + nt_color + reference_split[1] + reset_color + "', ";

      output += ot_color + to_string(r.m_pos1 + 1) + reset_color + ", ";
      output += ot_color + to_string(r.m_length) + reset_color + ", ";
      output += nt_color + to_string(r.m_pos2 + 1) + reset_color + ", ";
      output += nt_color + to_string(r.m_length) + reset_color + ", ";
      output += "'getrefs');";

      info(output); // End of sql mode.
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

int getPsalmLastVerse(const string& moduleName, int psalm) {
  for (vector<PsalmsInfo>::iterator i=psalmsInfos.begin(); i!=psalmsInfos.end(); ++i) {
    PsalmsInfo pi = *i;
    if (pi.getInfo() == moduleName) {
      return pi.getLastVerse(psalm);
    }
  }
  throw InvalidModuleException;
}

string getRaw(const string& moduleName, const string& bookName, int startPos, int length) {
  Book b = getBook(bookName, moduleName);
  string text = b.getText();
  // handle special request: if startPos == 0 and length == -1, we assume that the whole text is requested:
  if (startPos == 0 && length == -1)
    return text;
  if (startPos >= text.length() || startPos < 0 || length < 1 || startPos + length > text.length())
    throw InvalidPassageException;
  return text.substr(startPos, length);
}

int getTokens(const string& moduleName, const string& book, const string& verse) {
  Book b = getBook(book, moduleName);
  vector<int> tokens = b.getVerseTokens(verse);
  string tokensS = "";
  for (auto t: tokens) {
    tokensS += to_string(t) + " ";
  }
  info(tokensS);
  return 0;
}

vector<string> searchTokenset(string moduleName, vector<int> pattern, int length, bool verbose) {
  vector<string> retval;
  // int found = 0;
  size_t pos;
  string book;
  for (int i=0; i<books.size(); i++) { // Search in all books in a given Bible edition...
    Book b = books[i];
    if (b.getModuleName().compare(moduleName) == 0) {
      book = b.getName();
      vector<int> bookTokens = b.getTokens();
      int tokensLength = bookTokens.size();
      // Check all possible consecutive tokensets in the book:
      for (int tpos=0; tpos < tokensLength - length; tpos++) {
        int tokensFound = 0;
        // For each token we check if it is in the tokenset:
        for (auto token: pattern) {
          bool tokenFound = false;
          for (int j=0; j < length && !tokenFound; j++) {
            if (bookTokens.at(tpos + j) == token) {
              tokenFound = true;
            }
          }
          if (tokenFound) {
            tokensFound++; // Count the number of tokens being found.
          }
        }
        // Did we find all tokens in the pattern?
        if (tokensFound == pattern.size()) {
          string infoStart = b.getVerseTokensInfoStart(tpos);
          string infoEnd = b.getVerseTokensInfoEnd(tpos + length - 1);
          retval.push_back(book + "," + to_string(tpos)); // Store the raw result.
          if (verbose) { // Return some informative answer...
            info("Found in " + book + " " + infoStart + " " + infoEnd +
                 " (tpos=" + to_string(tpos) + "-" + to_string(tpos + length - 1) + ")");
          }
        }
      }
    }
  }
  return retval; // Return the raw result as a vector of strings.
}

