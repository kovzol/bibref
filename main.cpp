/* BibRef, a project dedicated to find citations of the
 * Septuagint in the Greek New Testament.
 * This code is in the public domain
 * and contributed by Zoltán Kovács <zoltan@geogebra.org>.
 */

using namespace std;

#include <iostream>
#include "books.h"

int main(int argc, char **argv) {
    addBooks();
    cout << lookupVerse("Isaiah", "LXX", "25:3") << endl;
    cout << lookupVerse("Romans", "SBLGNT", "1:17") << endl;
    exit(0);
}
