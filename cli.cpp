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

string textCmd = "text";
string lookupCmd = "lookup";
string findCmd = "find";
string lengthCmd = "length";

string errorNotRecognized = "Sorry, the command you entered was not recognized or its syntax is invalid.";
string errorTextIncomplete = "Either " + textCmd + "1 or " + textCmd + "2 must be used.";
string errorTextParameters = textCmd + " requires at least one parameter.";
string errorLookupIncomplete = "Either " + lookupCmd + "1 or " + lookupCmd + "2 must be used.";
string errorLookupParameters = lookupCmd + " requires 3 or 4 parameters.";
string errorFindIncomplete = "Either " + textCmd + "1 or " + textCmd + "2 must be used.";
string errorFindParameters = findCmd + " requires at least one parameter.";
string errorLengthIncomplete = "Either " + lengthCmd + "1 or " + lengthCmd + "2 must be used.";

vector<string> vocabulary {"addbooks", "compare12",
                           textCmd + "1", textCmd + "2", lookupCmd + "1", lookupCmd + "2", "quit",
                                   "help", findCmd + "1", lengthCmd + "1", lengthCmd + "2"};

void add_vocabulary_item(string item) {
    replace(item.begin(), item.end(), ' ', '_');
    vocabulary.push_back(item);
}

void error(string message) {
    cerr << "\033[1;31m" << message << "\033[0m" << endl << flush;
}

void info(string message) {
    cerr << message << endl << flush;
}

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

void cli() {
    rl_attempted_completion_function = completer;
    info("This is bibref-cli 2020Apr15, nice to meet you.");

    char* buf;
    while ((buf = readline(">> ")) != nullptr) {
        if (strlen(buf) > 0) {
            add_history(buf);
        }

        string input(buf);
        boost::algorithm::trim(input);
        if (input.compare("addbooks") == 0) {
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

        if (boost::starts_with(input, lookupCmd)) {
            int index;
            int commandLength = lookupCmd.length();
            if (input.length() == commandLength) {
                error(errorLookupIncomplete);
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
            typedef vector<string> Tokens;
            Tokens tokens;
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
                    Tokens tokens2, tokens3;
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
            if (input.length() < lookupCmd.length() + 2) {
                error(errorFindParameters);
                goto end;
            }
            string rest = input.substr(input.find(" ") + 1);
            find(text[index], rest, 100);
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

        if (boost::starts_with(input, "compare12")) {
            if (textset.at(0) && textset.at(1)) {
                compareLatin(text[0], text[1]);
            } else {
                error("Text 1 or 2 is not set.");
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
