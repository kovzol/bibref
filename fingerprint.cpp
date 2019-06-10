using namespace std;

#include <string>

#include "book.h"
#include "fingerprint.h"

fingerprint getFingerprint(Book b, int start, int length) {
    fingerprint f;
    for (int i=0; i<N; ++i)
        for (int j=0; j<N; ++j) {
            f.data[i][j] = 0;
        }
    string text = b.getText().substr(start, length);
    for (int i=0; i<length - 1; ++i) {
        char first = text.at(i) - 'a';
        char second = text.at(i+1) - 'a';
        (f.data[first][second])++;
    }
    return f;
}

int dist(fingerprint f1, fingerprint f2) {
    int d = 0;
    for (int i=0; i<N; ++i)
        for (int j=0; j<N; ++j) {
            d += abs(f1.data[i][j]-f2.data[i][j]);
        }
    return d;
}
