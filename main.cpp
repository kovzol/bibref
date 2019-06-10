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
    fingerprint f1 = getTextFingerprint("Habakkuk", "LXX", "2:4", "2:4", 39, 0);
    fingerprint f2 = getTextFingerprint("Romans", "SBLGNT", "1:17", "1:17", 68, 0);
    cout << dist(f1, f2) << endl;

    cout << "Comparing Psalms 62:12 and Romans 2:6..." << endl;
    cout << lookupVerse("Psalms", "LXX", "62:12") << endl;
    cout << lookupVerse("Romans", "SBLGNT", "2:6") << endl;
    f1 = getTextFingerprint("Psalms", "LXX", "62:12", "62:12", 34, 0);
    f2 = getTextFingerprint("Romans", "SBLGNT", "2:6", "2:6", 0, 0);
    cout << dist(f1, f2) << endl;
    f1 = getTextFingerprint("Psalms", "LXX", "62:12", "62:12", 34+7, 0);
    f2 = getTextFingerprint("Romans", "SBLGNT", "2:6", "2:6", 2, 0);
    cout << dist(f1, f2) << endl;

    cout << "Comparing Exodus 20:14-15 and Romans 2:21-22..." << endl;
    cout << lookupVerse("Exodus", "LXX", "20:14") << "/" << lookupVerse("Exodus", "LXX", "20:15") << endl;
    cout << lookupVerse("Romans", "SBLGNT", "2:21") << "/" << lookupVerse("Romans", "SBLGNT", "2:22") << endl;
    f1 = getTextFingerprint("Exodus", "LXX", "20:14", "20:15", 2, 1);
    f2 = getTextFingerprint("Romans", "SBLGNT", "2:21", "2:22", 55, 42);
    cout << dist(f1, f2) << endl;

    cout << "Comparing Isaiah 52:5 and Romans 2:24..." << endl;
    cout << lookupVerse("Isaiah", "LXX", "52:5") << endl;
    cout << lookupVerse("Romans", "SBLGNT", "2:24") << endl;
    f1 = getTextFingerprint("Isaiah", "LXX", "52:5", "52:5", 90, 0);
    f2 = getTextFingerprint("Romans", "SBLGNT", "2:24", "2:24", 6, 14);
    cout << dist(f1, f2) << endl;

    cout << "Comparing Psalms 51:4 and Romans 3:4..." << endl;
    cout << lookupVerse("Psalms", "LXX", "51:4") << endl;
    cout << lookupVerse("Romans", "SBLGNT", "3:4") << endl;
    f1 = getTextFingerprint("Psalms", "LXX", "51:4", "51:4", 43, 0);
    f2 = getTextFingerprint("Romans", "SBLGNT", "3:4", "3:4", 63, 0);
    cout << dist(f1, f2) << endl;

    cout << "Comparing Psalms 14:2-3 and Romans 3:11-18..." << endl;
    cout << lookupVerse("Psalms", "LXX", "14:2") << "/" << lookupVerse("Psalms", "LXX", "14:3") << endl;
    cout << lookupVerse("Romans", "SBLGNT", "3:11") << "..." << lookupVerse("Romans", "SBLGNT", "3:18") << endl;
    f1 = getTextFingerprint("Psalms", "LXX", "14:2", "14:3", 59, 0);
    f2 = getTextFingerprint("Romans", "SBLGNT", "3:11", "3:18", 3, 0);
    cout << dist(f1, f2) << endl;

    exit(0);
}
