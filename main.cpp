/* BibRef, a project dedicated to find citations of the
 * Septuagint in the Greek New Testament.
 * This code is in the public domain
 * and contributed by Zoltán Kovács <zoltan@geogebra.org>.
 */

#include <algorithm>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

using namespace std;

#include "books.h"
#include "cli.h"
#include "fingerprint.h"

// @author Iain Hull (https://stackoverflow.com/a/868894/1044586)
class InputParser
{
public:
    InputParser(int &argc, char **argv)
    {
        for (int i = 1; i < argc; ++i)
            this->m_tokens.emplace_back(argv[i]);
    }

    const string &getCmdOption(const string &option) const
    {
        vector<string>::const_iterator itr;
        itr = find(this->m_tokens.cbegin(), this->m_tokens.cend(), option);
        if (itr != this->m_tokens.end() && ++itr != this->m_tokens.end()) {
            return *itr;
        }
        static const string empty_string;
        return empty_string;
    }

    bool cmdOptionExists(const string &option) const
    {
        return find(this->m_tokens.begin(), this->m_tokens.end(), option) != this->m_tokens.end();
    }

private:
    vector<string> m_tokens;
};

void showHelp(const string &executable)
{
    cout << "Usage: " << executable << " [options]\n";
    cout << " where options can be:\n";
    cout << " -h            this help\n";
    cout << " -e            show input/output to fit examples\n";
    cout << " -a            run the addbooks command on startup\n";
    cout << " -c            use colored output\n";
}

#ifndef __EMSCRIPTEN__
int main(int argc, char **argv)
{
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
#endif

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
