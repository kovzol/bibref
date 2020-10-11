#include <iostream>
#include <string.h>
#include <string>
#include <algorithm>
#include <vector>
#include <readline/readline.h>
#include <readline/history.h>
#include <boost/algorithm/string/trim.hpp>
#include <boost/algorithm/string/predicate.hpp>
#include <boost/algorithm/string/split.hpp>

#include "books.h"
#include "cli.h"

using namespace std;
bool booksAdded = false;
string text[2];
vector<bool> textset = {false, false};

string addbooksCmd = "addbooks";
string compareCmd = "compare";
string textCmd = "text";
string latintextCmd = "latintext";
string lookupCmd = "lookup";
string findCmd = "find";
string lengthCmd = "length";
string minuniqueCmd = "minunique";
string extendCmd = "extend";
string getrefsCmd = "getrefs";
string maxresultsCmd = "maxresults";

string errorNotRecognized = "Sorry, the command you entered was not recognized or its syntax is invalid.";
string errorTextIncomplete = "Either " + textCmd + "1 or " + textCmd + "2 must be used.";
string errorTextParameters = textCmd + " requires at least one parameter.";
string errorLatintextIncomplete = "Either " + latintextCmd + "1 or " + latintextCmd + "2 must be used.";
string errorLatintextParameters = latintextCmd + " requires at least one parameter.";
string errorLookupIncomplete = "Either " + lookupCmd + "1 or " + lookupCmd + "2 must be used.";
string errorLookupParameters = lookupCmd + " requires 3 or 4 parameters.";
string errorFindIncomplete = "Either " + textCmd + "1 or " + textCmd + "2 must be used.";
string errorFindParameters = findCmd + " requires one parameter.";
string errorFindEmpty = "No text to find is defined yet.";
string errorLengthIncomplete = "Either " + lengthCmd + "1 or " + lengthCmd + "2 must be used.";
string errorMinuniqueParameters = minuniqueCmd + " requires one parameter";
string errorExtendParameters = extendCmd + " requires 4 or 5 parameters.";
string errorGetrefsParameters = getrefsCmd + " requires 3, 4 or 5 parameters.";
string errorMaxresultsParameters = maxresultsCmd + " requires one parameter.";

vector<string> vocabulary {addbooksCmd, compareCmd + "12",
                           textCmd + "1", textCmd + "2", lookupCmd + "1", lookupCmd + "2", "quit",
                                   "help", findCmd + "1", findCmd + "2", lengthCmd + "1", lengthCmd + "2",
                                   minuniqueCmd + "1", latintextCmd + "1", latintextCmd + "2",
                                   extendCmd, getrefsCmd, lookupCmd, maxresultsCmd
                          };

void add_vocabulary_item(string item) {
    replace(item.begin(), item.end(), ' ', '_');
    vocabulary.push_back(item);
}

void error(string message) {
    cerr << "\033[1;31m" << message << "\033[0m" << endl << flush;
}

void info(string message) {
    cerr << output_prepend_set << message << endl << flush;
}

// readline related code was taken mostly from https://eli.thegreenplace.net/2016/basics-of-using-the-readline-library/
char* completion_generator(const char* text, int state) {
    // This function is called with state=0 the first time; subsequent calls are
    // with a nonzero state. state=0 can be used to perform one-time
    // initialization for this completion session.
    static vector<string> matches;
    static size_t match_index = 0;

    if (state == 0) {
        // During initialization, compute the actual matches for 'text' and keep
        // them in a static vector.
        matches.clear();
        match_index = 0;

        // Collect a vector of matches: vocabulary words that begin with text.
        string textstr = string(text);
        for (auto word : vocabulary) {
            if (word.size() >= textstr.size() &&
                    word.compare(0, textstr.size(), textstr) == 0) {
                matches.push_back(word);
            }
        }
    }

    if (match_index >= matches.size()) {
        // We return nullptr to notify the caller no more matches are available.
        return nullptr;
    } else {
        // Return a malloc'd char* for the match. The caller frees it.
        return strdup(matches[match_index++].c_str());
    }
}

char** completer(const char* text, int start, int end) {
    // Don't do filename completion even if our generator finds no matches.
    rl_attempted_completion_over = 1;

    // Note: returning nullptr here will make readline use the default filename
    // completer.
    return rl_completion_matches(text, completion_generator);
}

void cli(const char *input_prepend, const char *output_prepend) {
    output_prepend_set = new char[4]; // FIXME: this is hardcoded.
    strcpy(output_prepend_set, output_prepend);
    rl_attempted_completion_function = completer;
    info("This is bibref-cli 2020Aug30, nice to meet you.");
    showAvailableBibles();

    maxresults = 100;

    char* buf;
    while ((buf = readline(input_prepend)) != nullptr) {
        if (strlen(buf) > 0) {
            add_history(buf);
        }

        string rawinput(buf);
        boost::algorithm::trim(rawinput);
        vector<string> commentTokens;
        boost::split(commentTokens, rawinput, boost::is_any_of("#"));
        string input = commentTokens[0];
        boost::algorithm::trim(input);

        if (input.compare(addbooksCmd) == 0) {
            if (booksAdded) {
                cerr << "Books already added." << endl << flush;
            } else {
                if (addBooks() == 0) {
                    booksAdded = true;
                }
            }
            goto end;
        }

        if (input.compare("quit") == 0) {
            info("Goodbye.");
            exit(0);
        }

        if (input.compare("help") == 0) {
            info("Please visit https://github.com/kovzol/bibref to get online help.");
            goto end;
        }

        if (boost::starts_with(input, textCmd)) {
            int index;
            int commandLength = textCmd.length();
            if (input.length() == commandLength) {
                error(errorTextIncomplete);
                goto end;
            }
            if (input.at(commandLength) == '1') {
                index = 0;
            }
            else if (input.at(commandLength) ==  '2') {
                index = 1;
            } else {
                error(errorTextIncomplete);
                goto end;
            }
            if (input.length() < textCmd.length() + 2) {
                error(errorTextParameters);
                goto end;
            }
            if (input.at(commandLength + 1) != ' ') {
                error("Either " + textCmd + "1 or " + textCmd + "2 must be used.");
                goto end;
            }
            string rest = input.substr(input.find(" ") + 1);
            string processed = processVerse(rest);
            if (processed.length() == 0) {
                error("Text does not contain Greek letters, ignored.");
                goto end;
            }
            text[index] = processed;
            textset[index] = true;
            info("Stored internally as " + processed + ".");
            goto end;
        }

        if (boost::starts_with(input, latintextCmd)) {
            int index;
            int commandLength = latintextCmd.length();
            if (input.length() == commandLength) {
                error(errorLatintextIncomplete);
                goto end;
            }
            if (input.at(commandLength) == '1') {
                index = 0;
            }
            else if (input.at(commandLength) ==  '2') {
                index = 1;
            } else {
                error(errorLatintextIncomplete);
                goto end;
            }
            if (input.length() < textCmd.length() + 2) {
                error(errorLatintextParameters);
                goto end;
            }
            if (input.at(commandLength + 1) != ' ') {
                error("Either " + latintextCmd + "1 or " + latintextCmd + "2 must be used.");
                goto end;
            }
            string rest = input.substr(input.find(" ") + 1);
            text[index] = rest;
            textset[index] = true;
            info("Stored.");
            goto end;
        }

        if (boost::starts_with(input, lookupCmd)) {
            int index;
            int commandLength = lookupCmd.length();
            if (input.length() == commandLength) {
                error(errorLookupIncomplete);
                goto end;
            }
            if (input.at(commandLength) == ' ') {
                string rest = input.substr(input.find(" ") + 1);
                vector<string> tokens;
                boost::split(tokens, rest, boost::is_any_of(" "));
                int restSize = tokens.size();
                if (restSize == 3) {
                    lookupTranslation(tokens[0], tokens[1], tokens[2]);
                } else {
                    error(errorLookupParameters);
                }
                goto end;
            }
            if (input.at(commandLength) == '1') {
                index = 0;
            }
            else if (input.at(commandLength) ==  '2') {
                index = 1;
            } else {
                error(errorLookupIncomplete);
                goto end;
            }
            if (input.length() < lookupCmd.length() + 2) {
                error(errorLookupParameters);
                goto end;
            }
            if (input.at(commandLength + 1) != ' ') {
                error(errorLookupIncomplete);
                goto end;
            }
            string rest = input.substr(input.find(" ") + 1);
            vector<string> tokens;
            boost::split(tokens, rest, boost::is_any_of(" "));
            int restSize = tokens.size();
            if (restSize == 3) {
                string verse = "";
                try {
                    verse = lookupVerse(tokens[1], tokens[0], tokens[2]);
                    text[index] = verse;
                    textset[index] = true;
                    info("Stored internally as " + verse + ".");
                } catch (exception &e) {
                    error(e.what());
                }
                goto end;
            }
            if (restSize == 4) {
                string verse = "";
                try {
                    vector<string> tokens2, tokens3;
                    int start = 0, end = 0;
                    boost::split(tokens2, tokens[2], boost::is_any_of("+"));
                    if (tokens2.size() > 1) {
                        start = stoi(tokens2[1]);
                    }
                    boost::split(tokens3, tokens[3], boost::is_any_of("-"));
                    if (tokens3.size() > 1) {
                        end = stoi(tokens3[1]);
                    }
                    verse = getText(tokens[1], tokens[0], tokens2.at(0), tokens3.at(0), start, end);
                    text[index] = verse;
                    textset[index] = true;
                    info("Stored internally as " + verse + ".");
                } catch (exception &e) {
                    error(e.what());
                }
                goto end;
            }
            error(errorLookupParameters);
            goto end;
        }

        if (boost::starts_with(input, findCmd)) {
            int index;
            int commandLength = findCmd.length();
            if (input.length() == commandLength) {
                error(errorFindIncomplete);
                goto end;
            }
            if (input.at(commandLength) == '1') {
                index = 0;
            }
            else if (input.at(commandLength) ==  '2') {
                index = 1;
            } else {
                error(errorFindIncomplete);
                goto end;
            }
            if (input.length() < lookupCmd.length() + 1) {
                error(errorFindParameters);
                goto end;
            }
            string rest = input.substr(input.find(" ") + 1);
            if (text[index].length() == 0) {
                error(errorFindEmpty);
                goto end;
            }
            find(text[index], rest, maxresults, 1);
            goto end;
        }

        if (boost::starts_with(input, lengthCmd)) {
            int index;
            int commandLength = lengthCmd.length();
            if (input.length() == commandLength) {
                error(errorLengthIncomplete);
                goto end;
            }
            if (input.at(commandLength) == '1') {
                index = 0;
            }
            else if (input.at(commandLength) ==  '2') {
                index = 1;
            } else {
                error(errorLengthIncomplete);
                goto end;
            }
            info("Length of text " + to_string(index + 1) + " is "
                 + to_string(text[index].length()) + ".");
            goto end;
        }

        if (boost::starts_with(input, maxresultsCmd)) {
            int index;
            int commandLength = maxresultsCmd.length();
            if (input.length() == commandLength) {
                error(errorMaxresultsParameters);
                goto end;
            }
            string rest = input.substr(input.find(" ") + 1);
            maxresults = stoi(rest);
            info("Set to " + to_string(maxresults) + ".");
            goto end;
        }

        if (boost::starts_with(input, compareCmd + "12")) {
            if (textset.at(0) && textset.at(1)) {
                compareLatin(text[0], text[1]);
            } else {
                error("Text 1 or 2 is not set.");
            }
            goto end;
        }

        if (boost::starts_with(input, minuniqueCmd + "1")) {
            int commandLength = minuniqueCmd.length();
            if (input.length() == commandLength) {
                error(errorMinuniqueParameters);
                goto end;
            }
            if (input.length() < minuniqueCmd.length() + 2) {
                error(errorMinuniqueParameters);
                goto end;
            }
            string rest = input.substr(input.find(" ") + 1);
            find_min_unique(text[0], rest, 1);
            goto end;
        }

        if (boost::starts_with(input, extendCmd)) {
            int commandLength = extendCmd.length();
            if (input.length() == commandLength) {
                error(errorExtendParameters);
                goto end;
            }
            if (input.at(commandLength) != ' ') {
                error(errorExtendParameters);
                goto end;
            }
            string rest = input.substr(input.find(" ") + 1);
            vector<string> tokens;
            boost::split(tokens, rest, boost::is_any_of(" "));
            int restSize = tokens.size();
            string moduleName1 = tokens[0];
            string moduleName2 = tokens[1];
            string book2 = tokens[2];
            string verse2S, verse2E;
            if (restSize == 4) {
                verse2S = tokens[3] + "+0";
                verse2E = tokens[3] + "-0";
            } else if (restSize == 5) {
                verse2S = tokens[3];
                verse2E = tokens[4];
            } else {
                error(errorExtendParameters);
                goto end;
            }
            vector<string> verse2ST, verse2ET;
            int start = 0, end = 0;
            boost::split(verse2ST, verse2S, boost::is_any_of("+"));
            if (verse2ST.size() > 1) {
                start = stoi(verse2ST[1]);
            }
            boost::split(verse2ET, verse2E, boost::is_any_of("-"));
            if (verse2ET.size() > 1) {
                end = stoi(verse2ET[1]);
            }
            try {
                extend(moduleName1, moduleName2, book2, verse2ST[0], start, verse2ET[0], end);
            } catch (exception &e) {
                error(e.what());
            }
            goto end;
        }

        if (boost::starts_with(input, getrefsCmd)) {
            int commandLength = getrefsCmd.length();
            if (input.length() == commandLength) {
                error(errorGetrefsParameters);
                goto end;
            }
            if (input.at(commandLength) != ' ') {
                error(errorGetrefsParameters);
                goto end;
            }
            string rest = input.substr(input.find(" ") + 1);
            vector<string> tokens;
            boost::split(tokens, rest, boost::is_any_of(" "));
            int restSize = tokens.size();
            string moduleName2 = tokens[0];
            string moduleName1 = tokens[1];
            string book1 = tokens[2];
            string verse1S, verse1E;
            if (restSize == 3) { // TODO: implement this
                error("Getting references from full books is not yet implemented, sorry.");
                goto end;
            }
            if (restSize == 4) {
                verse1S = tokens[3] + "+0";
                verse1E = tokens[3] + "-0";
            } else if (restSize == 5) {
                verse1S = tokens[3];
                verse1E = tokens[4];
            } else {
                error(errorExtendParameters);
                goto end;
            }
            vector<string> verse1ST, verse1ET;
            int start = 0, end = 0;
            boost::split(verse1ST, verse1S, boost::is_any_of("+"));
            if (verse1ST.size() > 1) {
                start = stoi(verse1ST[1]);
            }
            boost::split(verse1ET, verse1E, boost::is_any_of("-"));
            if (verse1ET.size() > 1) {
                end = stoi(verse1ET[1]);
            }
            try {
                getrefs(moduleName2, moduleName1, book1, verse1ST[0], start, verse1ET[0], end);
            } catch (exception &e) {
                error(e.what());
            }
            goto end;
        }

        if (input.length() != 0) {
            error(errorNotRecognized);
        }
end:
        // readline malloc's a new buffer every time.
        free(buf);
    }
}
