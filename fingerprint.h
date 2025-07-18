#ifndef FINGERPRINT_H
#define FINGERPRINT_H

#define N_GREEK_LETTERS 26
// we don't use q and w

#include "book.h"

typedef struct Fingerprint
{
    unsigned short int m_data[N_GREEK_LETTERS][N_GREEK_LETTERS];
} Fingerprint;

Fingerprint getFingerprint(Book book, int start, int length);
Fingerprint getFingerprint(string text);
int dist(Fingerprint f1, Fingerprint f2);
int dist(const string &text1, const string &text2);
void printDist(Fingerprint f1, Fingerprint f2);
double jaccard_dist(const string &text1, const string &text2);
string best_jaccard_substr(const string &fixtext, const string &subtext);

#endif // FINGERPRINT_H
