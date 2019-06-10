#ifndef BOOKS_H
#define BOOKS_H

#include "fingerprint.h"

void addLxx();
void addBooks();
string lookupVerse(string book, string info, string verse);
fingerprint getTextFingerprint(string book, string info, int start, int length);
fingerprint getTextFingerprint(string book, string info, string start, string end);
fingerprint getTextFingerprint(string book, string info, string start, string end, int startOffset, int endOffset);

#endif // BOOKS_H
