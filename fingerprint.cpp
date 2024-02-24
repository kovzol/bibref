#include <string>
#include <iostream>

using namespace std;

#include "book.h"
#include "fingerprint.h"

Fingerprint getFingerprint(string text) {
  Fingerprint f;
  for (int i=0; i<N_GREEK_LETTERS; ++i)
    for (int j=0; j<N_GREEK_LETTERS; ++j) {
      f.m_data[i][j] = 0;
    }
  for (int i=0; i<text.length() - 1; ++i) {
    char first = text.at(i) - 'a';
    char second = text.at(i+1) - 'a';
    (f.m_data[first][second])++;
  }
  /*
  int u = 0;
  printf("Unused: ");
  for (int i=0; i<N; ++i)
    for (int j=0; j<N; ++j) {
      if (f.data[i][j] == 0) {
        printf("%d-%d ",i,j);
        u++;
      }
    }
  printf("(%d instances)\n", u);
  */

  return f;
}

Fingerprint getFingerprint(Book b, int start, int length) {
  string text = b.getText().substr(start, length);
  return getFingerprint(text);
}

int dist(Fingerprint f1, Fingerprint f2) {
  int d = 0;
  for (int i=0; i<N_GREEK_LETTERS; ++i)
    for (int j=0; j<N_GREEK_LETTERS; ++j) {
      d += abs(f1.m_data[i][j]-f2.m_data[i][j]);
    }
  return d;
}

void printDist(Fingerprint f1, Fingerprint f2) {
  cout << " ";
  for (int j=0; j<N_GREEK_LETTERS; ++j)
    printf("%c", j + 'a');
  cout << endl;
  for (int i=0; i<N_GREEK_LETTERS; ++i) {
    printf("%c", i + 'a');
    for (int j=0; j<N_GREEK_LETTERS; ++j) {
      if (f1.m_data[i][j] == 0 && f2.m_data[i][j] == 0)
        cout << " ";
      else
        printf("%1d", abs(f1.m_data[i][j]-f2.m_data[i][j]));
    }
    cout << endl;
  }
}

int dist(const string& text1, const string& text2) {
  return dist(getFingerprint(text1), getFingerprint(text2));
}

double jaccard_dist(const string& text1, const string& text2) {
  int d1 = 0;
  int d2 = 0;
  int d = 0;
  Fingerprint f1 = getFingerprint(text1);
  Fingerprint f2 = getFingerprint(text2);
  for (int i=0; i<N_GREEK_LETTERS; ++i)
    for (int j=0; j<N_GREEK_LETTERS; ++j) {
      d1 += f1.m_data[i][j];
      d2 += f2.m_data[i][j];
      d += min(f1.m_data[i][j], f2.m_data[i][j]);
    }
  /* We compute the Jaccard similarity for bags
     * (see Leskovec, Rajamaran, Ullman: Mining of massive datasets,
     * Cambridge Univ. Press, 2014, p. 77, footnote 2)
     * with the redefinition of the union of bags.
     * Then we compute the Jaccard distance.
     */
  return 1-((double) d)/max(d1,d2);
}
