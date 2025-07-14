#include <iostream>
#include <string>
#include <limits>

using namespace std;

#include "book.h"
#include "fingerprint.h"

Fingerprint getFingerprint(string text)
{
    Fingerprint f;
    for (int i = 0; i < N_GREEK_LETTERS; ++i)
        for (int j = 0; j < N_GREEK_LETTERS; ++j) {
            f.m_data[i][j] = 0;
        }
    if (text.empty()) {
        return f; // return here, otherwise text.length() - 1 will be 2^64-1
        }
    for (int i = 0; i < text.length() - 1; ++i) {
        char first = text.at(i) - 'a';
        char second = text.at(i + 1) - 'a';
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

Fingerprint getFingerprint(Book b, int start, int length)
{
    string text = b.getText().substr(start, length);
    return getFingerprint(text);
}

int dist(Fingerprint f1, Fingerprint f2)
{
    int d = 0;
    for (int i = 0; i < N_GREEK_LETTERS; ++i)
        for (int j = 0; j < N_GREEK_LETTERS; ++j) {
            d += abs(f1.m_data[i][j] - f2.m_data[i][j]);
        }
    return d;
}

void printDist(Fingerprint f1, Fingerprint f2)
{
    cout << " ";
    for (int j = 0; j < N_GREEK_LETTERS; ++j)
        printf("%c", j + 'a');
    cout << endl;
    for (int i = 0; i < N_GREEK_LETTERS; ++i) {
        printf("%c", i + 'a');
        for (int j = 0; j < N_GREEK_LETTERS; ++j) {
            if (f1.m_data[i][j] == 0 && f2.m_data[i][j] == 0)
                cout << " ";
            else
                printf("%1d", abs(f1.m_data[i][j] - f2.m_data[i][j]));
        }
        cout << endl;
    }
}

int dist(const string &text1, const string &text2)
{
    return dist(getFingerprint(text1), getFingerprint(text2));
}

double jaccard_dist(const string &text1, const string &text2)
{
    if (text1.length() < 2 || text2.length() < 2)
        return std::numeric_limits<double>::quiet_NaN();
    int d1 = 0;
    int d2 = 0;
    int d = 0;
    Fingerprint f1 = getFingerprint(text1);
    Fingerprint f2 = getFingerprint(text2);
    for (int i = 0; i < N_GREEK_LETTERS; ++i)
        for (int j = 0; j < N_GREEK_LETTERS; ++j) {
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
    return 1 - ((double) d) / max(d1, d2);
}

string best_jaccard_substr(const string &fixtext, const string &subtext)
{
    if (fixtext.length() < 2 || subtext.length() < 2)
        return ""; // TODO: this should be an error (exception)
    Fingerprint f1 = getFingerprint(fixtext);
    int maxlen = subtext.length();
    double best = 1.0;
    int best_s1, best_s2;
    int d1 = fixtext.length() - 1;
    for (int s1 = 0; s1 < maxlen; s1++) {
        Fingerprint f2 = getFingerprint(""); // empty

        // When starting a new value of s1, these should be reset:
        int d2 = 0;
        int d = 0;

        for (int s2 = s1 + 1; s2 + 1 < maxlen; s2++) { // update fingerprint for subtext
            char first = subtext.at(s2) - 'a';
            char second = subtext.at(s2 + 1) - 'a';
            (f2.m_data[first][second])++;

            d2++;
            // If the fix text has more (or equally many) occurrences for this 2-shingle than the
            // currently considered one from the subtext, then the minimum of
            // them has just been increased by 1, so we increase d as well:
            if (f1.m_data[first][second] >= f2.m_data[first][second]) d++;
            // Otherwise, the currently considered 2-shingle of the subtext is already
            // greater than the occurrences in the fix text, so the minimum of them
            // remains the same number: no change should be done for d.

            double dist = 1 - ((double) d) / max(d1, d2);
            if (dist < best) {
                // std::cout << "d1=" << d1 << " d2=" << d2 << " d=" << d << std::endl;
                best = dist;
                best_s1 = s1;
                best_s2 = s2;
                // printf("best=%4.2f best_s1=%d best_s2=%d\n", best, best_s1, best_s2);
                }
            }
        }
    return subtext.substr(best_s1, best_s2 - best_s1 + 2) + " " + to_string(best);
}
// Example call:
// best_jaccard_substr("panarsendianoigonmhtranagiontvkyrivklhuhsetai",
// "kaiafeleispandianoigonmhtrantaarsenikatvkyrivpandianoigonmhtranektvnboykolivnhentoiskthnesinsoyosaeangenhtaisoitaarsenikaagiaseistvkyriv")
// should return "kaiafeleispandianoigonmhtrantaarsenikatvkyriv" (taken from Luke 2:23 and Exodus 13:12)
