#ifndef BOOKS_H
#define BOOKS_H

#include "fingerprint.h"

void addLxx();
void addBooks();
string lookupVerse(string book, string info, string verse);
fingerprint getTextFingerprint(string book, string info, int start, int length);
fingerprint getTextFingerprint(string book, string info, string start, string end);
fingerprint getTextFingerprint(string book, string info, string start, string end, int startOffset, int endOffset);
int compare(string book1, string info1, string verseInfo1s, string verseInfo1e, int startOffset1, int endOffset1,
             string book2, string info2, string verseInfo2s, string verseInfo2e, int startOffset2, int endOffset2);
int compare(string verse1, string verse2);
int findBestFit(string book1, string info1, string verseInfo1s, string verseInfo1e,
                string book2, string info2, string verseInfo2s, string verseInfo2e);

#endif // BOOKS_H
