/* BibRef, a project dedicated to find citations of the
 * Septuagint in the Greek New Testament.
 * This code is in the public domain
 * and contributed by Zoltán Kovács <zoltan@geogebra.org>.
 */

using namespace std;

#include <iostream>
#include <readline/readline.h>
#include <readline/history.h>
#include <algorithm>
#include <string>
#include <sstream>
#include <vector>

#include "books.h"
#include "fingerprint.h"
#include "cli.h"

// @author Iain Hull (https://stackoverflow.com/a/868894/1044586)
class InputParser {
public:
    InputParser(int &argc, char **argv) {
        for (int i = 1; i < argc; ++i)
            this->tokens.emplace_back(argv[i]);
    }

    const string &getCmdOption(const string &option) const {
        vector<string>::const_iterator itr;
        itr = find(this->tokens.cbegin(), this->tokens.cend(), option);
        if (itr != this->tokens.end() && ++itr != this->tokens.end()) {
            return *itr;
        }
        static const string empty_string;
        return empty_string;
    }

    bool cmdOptionExists(const string &option) const {
        return find(this->tokens.begin(), this->tokens.end(), option)
               != this->tokens.end();
    }

private:
    vector<string> tokens;
};

void showHelp(const string &executable) {
    cout << "Usage: " << executable << " [options]\n";
    cout << " where options can be:\n";
    cout << " -h            this help\n";
    cout << " -e            show input/output to fit examples\n";
    cout << " -a            run the addbooks command on startup\n";
    cout << " -c            use colored output\n";
}

int main(int argc, char **argv) {
    InputParser input(argc, argv);
    if (input.cmdOptionExists("-h")) {
        showHelp(argv[0]);
        exit(0);
    }

    bool ab = false;
    if (input.cmdOptionExists("-a")) {
        ab = true;
    }

    bool c = false;
    if (input.cmdOptionExists("-c")) {
        c = true;
    }

    if (input.cmdOptionExists("-e")) {
        cli("", "# ", ab, c);
    } else {
        cli(">> ", "", ab, c);
    }

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
 */
