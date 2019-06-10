/* BibRef, a project dedicated to find citations of the
 * Septuagint in the Greek New Testament.
 * This code is in the public domain
 * and contributed by Zoltán Kovács <zoltan@geogebra.org>.
 */

using namespace std;

#include <iostream>
#include "books.h"
#include "fingerprint.h"

int main(int argc, char **argv) {
    addBooks();
    cout << "Comparing Habakkuk 2:4 and Romans 1:17..." << endl;
    cout << lookupVerse("Habakkuk", "LXX", "2:4") << endl;
    cout << lookupVerse("Romans", "SBLGNT", "1:17") << endl;
    fingerprint Hab_2_4 = getTextFingerprint("Habakkuk", "LXX", "2:4", "2:4", 39, 0);
    fingerprint Rom_1_17 = getTextFingerprint("Romans", "SBLGNT", "1:17", "1:17", 68, 0);
    cout << dist(Hab_2_4, Rom_1_17) << endl;

    cout << "Comparing Psalms 51:4 and Romans 3:4..." << endl;
    cout << lookupVerse("Psalms", "LXX", "51:4") << endl;
    cout << lookupVerse("Romans", "SBLGNT", "3:4") << endl;
    fingerprint Ps_51_4 = getTextFingerprint("Psalms", "LXX", "51:4", "51:4", 43, 0);
    fingerprint Rom_3_4 = getTextFingerprint("Romans", "SBLGNT", "3:4", "3:4", 63, 0);
    cout << dist(Ps_51_4, Rom_3_4) << endl;

    exit(0);
}
