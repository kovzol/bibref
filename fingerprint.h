#ifndef FINGERPRINT_H
#define FINGERPRINT_H

#define N 25

#include "book.h"

typedef struct fingerprint {
    unsigned short int data [N][N];
} fingerprint;

fingerprint getFingerprint(Book b, int start, int length);
fingerprint getFingerprint(string text);
int dist(fingerprint f1, fingerprint f2);
int dist(string text1, string text2);
void printDist(fingerprint f1, fingerprint f2);
double jaccard_sim(string text1, string text2);

#endif // FINGERPRINT_H
