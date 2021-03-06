using namespace std;

#include <string>
#include <iostream>

#include "book.h"
#include "fingerprint.h"

fingerprint getFingerprint(string text) {
    fingerprint f;
    for (int i=0; i<N; ++i)
        for (int j=0; j<N; ++j) {
            f.data[i][j] = 0;
        }
    for (int i=0; i<text.length() - 1; ++i) {
        char first = text.at(i) - 'a';
        char second = text.at(i+1) - 'a';
        (f.data[first][second])++;
    }
    return f;
}

fingerprint getFingerprint(Book b, int start, int length) {
    string text = b.getText().substr(start, length);
    return getFingerprint(text);
}

int dist(fingerprint f1, fingerprint f2) {
    int d = 0;
    for (int i=0; i<N; ++i)
        for (int j=0; j<N; ++j) {
            d += abs(f1.data[i][j]-f2.data[i][j]);
        }
    return d;
}

void printDist(fingerprint f1, fingerprint f2) {
    cout << " ";
    for (int j=0; j<N; ++j)
        printf("%c", j + 'a');
    cout << endl;
    for (int i=0; i<N; ++i) {
        printf("%c", i + 'a');
        for (int j=0; j<N; ++j) {
            if (f1.data[i][j] == 0 && f2.data[i][j] == 0)
                cout << " ";
            else
            printf("%1d", abs(f1.data[i][j]-f2.data[i][j]));
        }
        cout << endl;
    }
}

int dist(string text1, string text2) {
    return dist(getFingerprint(text1), getFingerprint(text2));
}

double jaccard_dist(string text1, string text2) {
    int d1 = 0;
    int d2 = 0;
    int d = 0;
    fingerprint f1 = getFingerprint(text1);
    fingerprint f2 = getFingerprint(text2);
    for (int i=0; i<N; ++i)
        for (int j=0; j<N; ++j) {
            d1 += f1.data[i][j];
            d2 += f2.data[i][j];
            d += min(f1.data[i][j], f2.data[i][j]);
        }
    /* We compute the Jaccard similarity for bags
     * (see Leskovec, Rajamaran, Ullman: Mining of massive datasets,
     * Cambridge Univ. Press, 2014, p. 77, footnote 2)
     * with the redefinition of the union of bags.
     * Then we compute the Jaccard distance.
     */
    return 1-((double) d)/max(d1,d2);
}
