#ifndef BOOKS_H
#define BOOKS_H

#include "fingerprint.h"

int addBooks();
string lookupVerse(string book, string info, string verse);
fingerprint getTextFingerprint(string book, string info, int start, int length);
fingerprint getTextFingerprint(string book, string info, string start, string end);
fingerprint getTextFingerprint(string book, string info, string start, string end, int startOffset, int endOffset);
int compare(string book1, string info1, string verseInfo1s, string verseInfo1e, int startOffset1, int endOffset1,
             string book2, string info2, string verseInfo2s, string verseInfo2e, int startOffset2, int endOffset2);
int compare(string verse1, string verse2);
int compareLatin(string verse1, string verse2);
int findBestFit(string book1, string info1, string verseInfo1s, string verseInfo1e,
                string book2, string info2, string verseInfo2s, string verseInfo2e);
string processVerse(const string &verse);
string getText(string book, string info, string VerseInfoS, string VerseInfoE, int startOffset, int endOffset);
int find(string text, string info, int maxFound, int verb);
vector<string> find_min_unique(string text, string moduleName, int verb);
void extend(string moduleName1, string moduleName2, string book2, string verse2S,
            int start, string verse2E, int end);
void getrefs(string moduleName2, string moduleName1, string book1, string verse1S,
            int start, string verse1E, int end);
int lookupTranslation(string moduleName, string book, string verse);
void showAvailableBibles();

#endif // BOOKS_H
