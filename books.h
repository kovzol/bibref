#ifndef BOOKS_H
#define BOOKS_H

#include "fingerprint.h"

int addBibles();
string lookupVerse(const string& book, const string& info, const string& verse);
Fingerprint getTextFingerprint(const string& book, const string& info, int start, int length);
Fingerprint getTextFingerprint(const string& book, const string& info, const string& start, const string& end);
Fingerprint getTextFingerprint(const string& book, const string& info, const string& start, const string& end, int startOffset, int endOffset);
int compare(const string& book1, const string& info1, const string& verseInfo1s, const string& verseInfo1e, int startOffset1, int endOffset1,
            const string& book2, const string& info2, const string& verseInfo2s, const string& verseInfo2e, int startOffset2, int endOffset2);
int compare(string verse1, string verse2);
int compareLatin(string verse1, string verse2);
/*
int findBestFit(const string& book1, const string& info1, const string& verseInfo1s, const string& verseInfo1e,
                const string& book2, const string& info2, const string& verseInfo2s, const string& verseInfo2e);
*/
string processVerse(const string &verse);
string getText(const string& book, const string& info, const string& VerseInfoS, const string& VerseInfoE, int startOffset, int endOffset);
int find(const string& text, const string& moduleName, int maxFound, bool verbose);
vector<string> find_min_unique(string text, const string& moduleName, bool verbose);
void extend(const string& moduleName1, const string& moduleName2, const string& book2, const string& verse2S,
            int start, const string& verse2E, int end);
void getrefs(const string& moduleName2, const string& moduleName1, const string& book1, const string& verse1S,
             int start, const string& verse1E, int end);
int lookupTranslation(string moduleName, string book, const string& verse);
void showAvailableBibles();
int getPsalmLastVerse(const string& moduleName, int psalm);
string getRaw(const string& modulename, const string& book, int startPos, int length);
string latinToGreek(const string& latin);
int getTokens(const string& moduleName, const string& book, const string& verse);
vector<string> searchTokenset(string moduleName, vector<int> pattern, int length, bool verbose);

#endif // BOOKS_H
