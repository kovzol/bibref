/* BibRef, a project dedicated to find citations of the
 * Septuagint in the Greek New Testament.
 * This code is in the public domain
 * and contributed by Zoltán Kovács <zoltan@geogebra.org>.
 */

using namespace std;

#include <iostream>
#include <readline/readline.h>
#include <readline/history.h>

#include "books.h"
#include "fingerprint.h"
#include "cli.h"


int main(int argc, char **argv) {

    cli();

    exit(0);
    compare("ου μοιχευσεις ου κλεψεις", "κλεπτεις ο λεγων μη μοιχευειν μοιχευεις");
    compare("ων το στομα αρας και πικριας γεμει","ου αρας το στομα αυτου γεμει και πικριας");
    compare("πατρος προς υιον και καρδιαν", "καρδιας πατερων");

    /* Example of comparison based on text modules. */

    addBooks();
    compare("Psalms", "LXX", "91:11", "91:11", 0, 20, "Luke", "SBLGNT", "4:10", "4:10", 12, 0);

    compare("Deuteronomy", "LXX", "6:16", "6:16", 0, 33, "Luke", "SBLGNT", "4:12", "4:12", 39, 0);
    compare("Psalms", "LXX", "22:18", "22:18", 0, 0, "Matthew", "SBLGNT", "27:35", "27:35", 19, 0);
    compare("Psalms", "LXX", "22:18", "22:18", 0, 43, "Matthew", "SBLGNT", "27:35", "27:35", 19, 20);
    compare("Psalms", "LXX", "22:18", "22:18", 0, 1, "Matthew", "SBLGNT", "27:35", "27:35", 19, 1);
    compare("Psalms", "LXX", "22:18", "22:18", 1, 1, "Matthew", "SBLGNT", "27:35", "27:35", 20, 1);
    compare("Psalms", "LXX", "146:6", "146:6", 3, 32, "Acts", "SBLGNT", "4:24", "4:24", 62, 0);
    compare("Psalms", "LXX", "110:1", "110:1", 62, 3, "Hebrews", "SBLGNT", "10:13", "10:13", 31, 5);
    compare("Psalms", "LXX", "110:1", "110:1", 13, 0, "Matthew", "SBLGNT", "22:44", "22:44", 0, 0);
    compare("Psalms", "LXX", "106:20", "106:20", 0, 20, "Romans", "SBLGNT", "1:23", "1:23", 0, 56);
    compare("Psalms", "LXX", "95:7", "95:11", 65, 0, "Hebrews", "SBLGNT", "3:7", "3:11", 28, 0);
    compare("Psalms", "LXX", "90:4", "90:4", 3, 33, "II Peter", "SBLGNT", "3:8", "3:8", 65, 3);
    compare("Amos", "LXX", "5:25", "5:27", 0, 45, "Acts", "SBLGNT", "7:42", "7:43", 93, 9);
    compare("Psalms", "LXX", "69:25", "69:25", 0, 0, "Acts", "SBLGNT", "1:20", "1:20", 25, 38);
    compare("Psalms", "LXX", "69:22", "69:23", 0, 0, "Romans", "SBLGNT", "11:9", "11:10", 13, 0);
    compare("Psalms", "LXX", "69:4", "69:4", 40, 69, "John", "SBLGNT", "15:25", "15:25", 46, 0);
    compare("Psalms", "LXX", "8:4", "8:5", 0, 0, "Hebrews", "SBLGNT", "2:6", "2:7", 25, 0);
    compare("Psalms", "LXX", "8:4", "8:6", 0, 0, "Hebrews", "SBLGNT", "2:6", "2:8", 25, 84);
    compare("Psalms", "LXX", "8:6", "8:6", 39, 0, "Hebrews", "SBLGNT", "2:8", "2:8", 0, 84);
    compare("Psalms", "LXX", "34:12", "34:16", 17, 37, "I Peter", "SBLGNT", "3:10", "3:12", 4, 0);
    compare("Psalms", "LXX", "34:8", "34:8", 0, 28, "I Peter", "SBLGNT", "2:3", "2:3", 3, 0);
    compare("Psalms", "LXX", "32:1", "32:2", 15, 30, "Romans", "SBLGNT", "4:7", "4:8", 0, 0);
    compare("Psalms", "LXX", "28:4", "28:4", 63, 25, "Romans", "SBLGNT", "2:6", "2:6", 2, 0); // távoli
    compare("Psalms", "LXX", "62:12", "62:12", 34+7, 0, "Romans", "SBLGNT", "2:6", "2:6", 0+2, 0); // lásd lent is
    compare("Proverbs", "LXX", "24:12", "24:12", 95, 0, "Romans", "SBLGNT", "2:6", "2:6", 0, 0);
    compare("Psalms", "LXX", "24:1", "24:1", 28, 39, "I Corinthians", "SBLGNT", "10:26", "10:26", 0, 0);
    compare("Psalms", "LXX", "86:9", "86:9", 0, 28, "Revelation of John", "SBLGNT", "15:4", "15:4", 54, 30);
    compare("Psalms", "LXX", "22:7", "22:8", 0, 0, "Matthew", "SBLGNT", "27:39", "27:43", 0, 0);
    compare("Micah", "LXX", "5:2", "5:2", 0, 65, "Matthew", "SBLGNT", "2:6", "2:6", 0, 41); // ? maybe just paraphrase
    // compare("Micah", "LXX", "5:2", "5:2", 0, 65, "Matthew", "SBLGNT", "2:7", "2:7", 0, 41); a non-example!
    compare("Hosea", "LXX", "11:1", "11:1", 38, 12, "Matthew", "SBLGNT", "2:15", "2:15", 77, 10);
    compare("Jeremiah", "LXX", "31:15", "31:15", 16, 0, "Matthew", "SBLGNT", "2:18", "2:18", 0, 0);
    compare("Isaiah", "LXX", "40:3", "40:3", 0, 8, "Matthew", "SBLGNT", "3:3", "3:3", 48, 0);
    compare("Deuteronomy", "LXX", "8:3", "8:3", 92, 16, "Matthew", "SBLGNT", "4:4", "4:4", 27, 0);
    compare("Deuteronomy", "LXX", "6:16", "6:16", 0, 33, "Matthew", "SBLGNT", "4:7", "4:7", 28, 0);
    compare("Deuteronomy", "LXX", "6:13", "6:13", 0, 41, "Matthew", "SBLGNT", "4:10", "4:10", 43, 0);
    compare("Isaiah", "LXX", "7:14", "7:14", 35, 0, "Matthew", "SBLGNT", "1:23", "1:23", 0, 34);
    compare("Psalms", "LXX", "106:10", "106:10", 15, 2, "Luke", "SBLGNT", "1:71", "1:71", 10, 4);
    compare("Exodus", "LXX", "13:12", "13:12", 10, 91, "Luke", "SBLGNT", "2:23", "2:23", 29, 10);
    compare("Leviticus", "LXX", "5:11", "5:11", 24, 137, "Luke", "SBLGNT", "2:24", "2:24", 47, 0);
    compare("Exodus", "LXX", "20:14", "20:15", 2, 1, "Romans", "SBLGNT", "2:21", "2:22", 55, 42);
    compare("Psalms", "LXX", "40:6", "40:8", 0, 50, "Hebrews", "SBLGNT", "10:5", "10:7", 32, 0);
    compare("Psalms", "LXX", "41:9", "41:9", 45, 5, "John", "SBLGNT", "13:18", "13:18", 74, 7);
    compare("Psalms", "LXX", "117:1", "117:1", 8, 0, "Romans", "SBLGNT", "15:11", "15:11", 8, 0);
    compare("Psalms", "LXX", "118:22", "118:22", 0, 0, "Acts", "SBLGNT", "4:11", "4:11", 0, 0);
    compare("Psalms", "LXX", "2:9", "2:9", 0, 10, "Revelation of John", "SBLGNT", "2:27", "2:27", 3, 5);
    compare("Psalms", "LXX", "2:9", "2:9", 0, 32, "Revelation of John", "SBLGNT", "12:5", "12:5", 26, 55);
    compare("Psalms", "LXX", "16:8", "16:11", 0, 31, "Acts", "SBLGNT", "2:25", "2:28", 21, 0);
    compare("Psalms", "LXX", "14:2", "14:3", 59, 0, "Romans", "SBLGNT", "3:11", "3:18", 3, 0);
    exit(0);

    // findBestFit("Habakkuk", "LXX", "2:4", "2:4", "Romans", "SBLGNT", "1:17", "1:17");
    // findBestFit("Psalms", "LXX", "62:12", "62:12", "Romans", "SBLGNT", "2:6", "2:6");
    // findBestFit("Exodus", "LXX", "20:14", "20:15", "Romans", "SBLGNT", "2:21", "2:22");
    // findBestFit("Isaiah", "LXX", "52:5", "52:5", "Romans", "SBLGNT", "2:24", "2:24"); lassú
    // findBestFit("Exodus", "LXX", "20:14", "20:14", "Romans", "SBLGNT", "2:22", "2:22"); crash
    // findBestFit("Exodus", "LXX", "20:15", "20:15", "Romans", "SBLGNT", "2:21", "2:21"); crash
    // findBestFit("Psalms", "LXX", "51:4", "51:4", "Romans", "SBLGNT", "3:4", "3:4"); lassú
    // findBestFit("Genesis", "LXX", "15:6", "15:6", "Romans", "SBLGNT", "4:3", "4:3"); jó
    // findBestFit("Psalms", "LXX", "31:1", "31:2", "Romans", "SBLGNT", "4:7", "4:8"); lassú
    // findBestFit("Genesis", "LXX", "15:6", "15:6", "Romans", "SBLGNT", "4:9", "4:9"); jó, de sok lehetőséget ad, hasznos a továbbgondolásra
    // findBestFit("Genesis", "LXX", "17:5", "17:5", "Romans", "SBLGNT", "4:17", "4:17"); lassú
    // findBestFit("Genesis", "LXX", "15:5", "15:5", "Romans", "SBLGNT", "4:17", "4:17"); lassú
    // findBestFit("Genesis", "LXX", "15:6", "15:6", "Romans", "SBLGNT", "4:22", "4:22"); jó
    // findBestFit("Genesis", "LXX", "15:6", "15:6", "Romans", "SBLGNT", "4:23", "4:23"); jó

    findBestFit("Isaiah", "LXX", "26:19", "26:19", "Ephesians", "SBLGNT", "5:14", "5:14");

    compare("Habakkuk", "LXX", "2:4", "2:4", 39, 0, "Romans", "SBLGNT", "1:17", "1:17", 68, 0);
    compare("Psalms", "LXX", "62:12", "62:12", 34+7, 0, "Romans", "SBLGNT", "2:6", "2:6", 0+2, 0);
    compare("Exodus", "LXX", "20:14", "20:15", 2, 1, "Romans", "SBLGNT", "2:21", "2:22", 55, 42);
    compare("Isaiah", "LXX", "52:5", "52:5", 90, 0, "Romans", "SBLGNT", "2:24", "2:24", 6, 14);
    compare("Psalms", "LXX", "51:4", "51:4", 43, 0, "Romans", "SBLGNT", "3:4", "3:4", 63, 0);

    /* Example of direct comparison. */
    // Hab 2:4 (01) ~ Rom 1:17 (01)
    compare("ο δε δικαιοc εκ πιcτεωc μ ζηcεται", "ο δε δικοc εκ πιcτεωc ζηcεται");
    // Ps 61:13 (01,03) ~ Rom 2:6 (01,03)
    compare("αποδωσεις εκαστω κατα τα εργα αυτου", "αποδωcει εκαcτω κατα τα εργα αυτου");
    compare("αναστησονται οι νεκροι και εγερθησονται οι εν τοις μνημειοις και ευφρανθησονται οι εν τη γη η γαρ δροσος η παρα σου ιαμα αυτοις εστιν η δε γη των ασεβων πεσειται",
            "εγειρε ο καθευδων και αναστα εκ των νεκρων και επιφαυσει σοι ο χριστος");
    compare("αναστησονται οι νεκροι και εγερθησονται",
            "εγειρε ο καθευδων και αναστα εκ των νεκρων");
    compare("αναστησονται οι νεκροι και εγερθησονται",
            "εγειρε ο καθευδων και αναστα εκ των νεκρ");
    compare("αναστησονται οι νεκροι και εγε",
            "εγειρε ο καθευδων και αναστα εκ των νεκρ");
    exit(0);
}

/*
 * Planned long term syntax:
 * T = Habakkuk 2:4 +39 -0
 * unique T
 * U = Romans 1:17 +68 -0
 * compare T U
 *
 * Short term:
 * text 1 = Hab 2:4 +39 -0
 * text 2 = Rom 1:17 +68 -0
 * compare 1 2
 *
 * Now:
 * text1 ο δε δικαιοc εκ πιcτεωc μ ζηcεται
 * text2 ο δε δικοc εκ πιcτεωc ζηcεται
 * compare12
 *
 * More examples:
 * addbooks
 * ...
 * >> lookup1 Psalms LXX 118:22
 * Stored internally as liuononapedokimasanoioikodomoyntewoytowegenhuheiwkefalhngvniaw.
 * >> lookup2 Acts SBLGNT 4:11
 * Stored internally as oytowestinoliuowoejoyuenhueiwyfymvntvnoikodomvnogenomenoweiwkefalhngvniaw.
 * >> compare12
 * Comparing 'liuononapedokimasanoioikodomoyntewoytowegenhuheiwkefalhngvniaw' ~ 'oytowestinoliuowoejoyuenhueiwyfymvntvnoikodomvnogenomenoweiwkefalhngvniaw' = 57
 * difference = 0.42963
 *
 * >> lookup1 Psalms LXX 117:1
 * Stored internally as allhloyiaaineitetonkyrionpantataeunhepainesateaytonpantewoilaoi.
 * >> lookup2 Romans SBLGNT 15:11
 * Stored internally as kaipalinaineiteantataeunhtonkyrionkaiepainesatvsanaytonpantewoilaoi.
 * >> compare12
 * Comparing 'allhloyiaaineitetonkyrionpantataeunhepainesateaytonpantewoilaoi' ~ 'kaipalinaineiteantataeunhtonkyrionkaiepainesatvsanaytonpantewoilaoi' = 28
 * difference = 0.223077
 *
 * >> lookup1 Psalms LXX 117:1+9 117:1-0
 * Stored internally as aineitetonkyrionpantataeunhepainesateaytonpantewoilaoi.
 * >> lookup2 Romans SBLGNT 15:11+8 15:11
 * Stored internally as aineiteantataeunhtonkyrionkaiepainesatvsanaytonpantewoilaoi.
 * >> compare12
 * Comparing 'aineitetonkyrionpantataeunhepainesateaytonpantewoilaoi' ~ 'aineiteantataeunhtonkyrionkaiepainesatvsanaytonpantewoilaoi' = 15
 * difference = 0.141593
 *
 * >> lookup1 Habakkuk LXX 2:4+39 2:4
 * Stored internally as odedikaiowekpistevwmoyqhsetai.
 * >> lookup2 Romans SBLGNT 1:17+68 1:17
 * Stored internally as odedikaiowekpistevwqhsetai.
 * >> compare12
 * Comparing 'odedikaiowekpistevwmoyqhsetai' ~ 'odedikaiowekpistevwqhsetai' = 5
 * difference = 0.109091
 *
 */
