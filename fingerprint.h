#ifndef FINGERPRINT_H
#define FINGERPRINT_H

#define N 25

#include "book.h"

typedef struct fingerprint {
    unsigned short int data [N][N];
} fingerprint;

fingerprint getFingerprint(Book b, int start, int length);
int dist(fingerprint f1, fingerprint f2);

#endif // FINGERPRINT_H