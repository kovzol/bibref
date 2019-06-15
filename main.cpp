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


    /* Example of comparison based on text modules. */

    addBooks();

    //findBestFit("Habakkuk", "LXX", "2:4", "2:4", "Romans", "SBLGNT", "1:17", "1:17");
    //findBestFit("Psalms", "LXX", "62:12", "62:12", "Romans", "SBLGNT", "2:6", "2:6");
    //findBestFit("Exodus", "LXX", "20:14", "20:15", "Romans", "SBLGNT", "2:21", "2:22");
    //findBestFit("Isaiah", "LXX", "52:5", "52:5", "Romans", "SBLGNT", "2:24", "2:24");
    findBestFit("Exodus", "LXX", "20:14", "20:14", "Romans", "SBLGNT", "2:22", "2:22");
    findBestFit("Exodus", "LXX", "20:15", "20:15", "Romans", "SBLGNT", "2:21", "2:21");
    //findBestFit("Psalms", "LXX", "51:4", "51:4", "Romans", "SBLGNT", "3:4", "3:4");
    //findBestFit("Genesis", "LXX", "15:6", "15:6", "Romans", "SBLGNT", "4:3", "4:3");
    //findBestFit("Psalms", "LXX", "31:1", "31:2", "Romans", "SBLGNT", "4:7", "4:8");
    //findBestFit("Genesis", "LXX", "15:6", "15:6", "Romans", "SBLGNT", "4:9", "4:9");
    //findBestFit("Genesis", "LXX", "17:5", "17:5", "Romans", "SBLGNT", "4:17", "4:17");
    //findBestFit("Genesis", "LXX", "15:5", "15:5", "Romans", "SBLGNT", "4:17", "4:17");
    findBestFit("Genesis", "LXX", "15:6", "15:6", "Romans", "SBLGNT", "4:22", "4:22");
    findBestFit("Genesis", "LXX", "15:6", "15:6", "Romans", "SBLGNT", "4:23", "4:23");

    exit(0);

    compare("Habakkuk", "LXX", "2:4", "2:4", 39, 0, "Romans", "SBLGNT", "1:17", "1:17", 68, 0);
    compare("Psalms", "LXX", "62:12", "62:12", 34+7, 0, "Romans", "SBLGNT", "2:6", "2:6", 0+2, 0);
    compare("Exodus", "LXX", "20:14", "20:15", 2, 1, "Romans", "SBLGNT", "2:21", "2:22", 55, 42);
    compare("Isaiah", "LXX", "52:5", "52:5", 90, 0, "Romans", "SBLGNT", "2:24", "2:24", 6, 14);
    compare("Psalms", "LXX", "51:4", "51:4", 43, 0, "Romans", "SBLGNT", "3:4", "3:4", 63, 0);
    compare("Psalms", "LXX", "14:2", "14:3", 59, 0, "Romans", "SBLGNT", "3:11", "3:18", 3, 0);

    /* Example of direct comparison. */
    // Hab 2:4 (01) ~ Rom 1:17 (01)
    compare("ο δε δικαιοc εκ πιcτεωc μ ζηcεται", "ο δε δικοc εκ πιcτεωc ζηcεται");
    // Ps 61:13 (01,03) ~ Rom 2:6 (01,03)
    compare("αποδωσεις εκαστω κατα τα εργα αυτου", "αποδωcει εκαcτω κατα τα εργα αυτου");
    // exit(0);

    exit(0);
}
