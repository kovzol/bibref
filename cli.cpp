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

vector<string> vocabulary {"addbooks", "compare12", "text1", "text2", "lookup1", "lookup2", "quit"};

void add_vocabulary_item(string item) {
    replace(item.begin(), item.end(), ' ', '_');
    vocabulary.push_back(item);
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
    cout << "This is bibref-cli 2020Apr14, nice to meet you." << endl << flush;

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
              addBooks();
              booksAdded = true;
          }
      }
      else if (input.compare("quit") == 0) {
          cout << "Goodbye." << endl << flush;
          exit(0);
      }
      else if (boost::starts_with(input, "text")) {
          int index;
          int commandLength = string("text").length();
          if (input.at(commandLength) == '1') {
              index = 0;
          }
          else if (input.at(commandLength) ==  '2') {
              index = 1;
          } else {
              cerr << "Either text1 or text2 must be used." << endl << flush;
          }
          if (input.at(commandLength + 1) != ' ') {
              cerr << "Either text1 or text2 must be used." << endl << flush;
          } else {
              string rest = input.substr(input.find(" ") + 1);
              string processed = processVerse(rest);
              if (processed.length() == 0) {
                  cerr << "Text does not contain Greek letters, ignored." << endl << flush;
              } else {
                  text[index] = processed;
                  textset[index] = true;
                  cout << "Stored internally as " << processed << "." << endl << flush;
              }
          }
      }
      else if (boost::starts_with(input, "lookup")) {
          int commandLength = string("lookup").length();
          int index;
          if (input.at(commandLength) == '1') {
              index = 0;
          }
          else if (input.at(commandLength) ==  '2') {
              index = 1;
          } else {
              cerr << "Either lookup1 or lookup2 must be used." << endl << flush;
          }
          if (input.at(commandLength + 1) != ' ') {
              cerr << "Either lookup1 or lookup2 must be used." << endl << flush;
          } else {
              string rest = input.substr(input.find(" ") + 1);
              typedef vector<string> Tokens;
              Tokens tokens;
              boost::split(tokens, rest, boost::is_any_of(" "));
              int restSize = tokens.size();
              if (restSize == 3) {
                  string verse = "";
                  try {
                      verse = lookupVerse(tokens[0], tokens[1], tokens[2]);
                      text[index] = verse;
                      textset[index] = true;
                      cout << "Stored internally as " << verse << "." << endl << flush;
                  } catch (exception &e) {
                      cout << e.what() << endl << flush;
                  }
              }
              else if (restSize == 4) {
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
                      verse = getText(tokens[0], tokens[1], tokens2.at(0), tokens3.at(0), start, end);
                      text[index] = verse;
                      textset[index] = true;
                      cout << "Stored internally as " << verse << "." << endl << flush;
                  } catch (exception &e) {
                      cout << e.what() << endl << flush;
                  }
              } else {
              cerr << "Sorry, the command you entered was not recognized." << endl << flush;
              }
          }
      }
      else if (boost::starts_with(input, "compare12")) {
          if (textset.at(0) && textset.at(1)) {
              compareLatin(text[0], text[1]);
          } else {
              cerr << "Text 1 or 2 is not set." << endl << flush;
          }
      }
      else if (input.length() != 0) {
          cerr << "Sorry, the command you entered was not recognized." << endl << flush;
      }

      // readline malloc's a new buffer every time.
      free(buf);
    }
}
