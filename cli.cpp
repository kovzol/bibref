#define BIBREF_VERSION "2024Feb13"

#include <iostream>
#include <sstream>
#include <string.h>
#include <string>
#include <algorithm>
#include <vector>

using namespace std;

#ifndef __EMSCRIPTEN__
#include <readline/readline.h>
#include <readline/history.h>
#endif
#include <boost/algorithm/string/trim.hpp>
#include <boost/algorithm/string/predicate.hpp>
#include <boost/algorithm/string/split.hpp>

#include <unistd.h>
#include <sys/types.h>
#ifndef __MINGW32__
#include <pwd.h>
#endif

#include "books.h"
#include "cli.h"
#include "swmgr.h"

#ifndef __EMSCRIPTEN__
#define OT_COLOR "\033[1;33m"
#define NT_COLOR "\033[1;36m"
#define RESET_COLOR "\033[0m"
#define ERROR_COLOR "\033[1;31m"
#else
#define OT_COLOR "<span style=\"color: #626600\">"
#define NT_COLOR "<span style=\"color: #006662\">"
#define RESET_COLOR "</span>"
#define ERROR_COLOR "<span style=\"color: red\">"
#endif

using namespace sword;

bool booksAdded = false;
string text[2];
vector<bool> textset = {false, false};

string addbooksCmd = "addbooks";
string compareCmd = "compare";
string jaccardCmd = "jaccard";
string textCmd = "text";
string latintextCmd = "latintext";
string lookupCmd = "lookup";
string findCmd = "find";
string lengthCmd = "length";
string printCmd = "print";
string minuniqueCmd = "minunique";
string extendCmd = "extend";
string getrefsCmd = "getrefs";
string maxresultsCmd = "maxresults";
string sqlCmd = "sql";
string psalminfoCmd = "psalminfo";
string rawCmd = "raw";
string colorsCmd = "colors";
string tokensCmd = "tokens";
string searchCmd = "search";
string quitCmd = "quit";
string helpCmd = "help";

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
string errorPrintIncomplete = "Either " + printCmd + "1 or " + printCmd + "2 must be used.";
string errorMinuniqueParameters = minuniqueCmd + " requires one parameter";
string errorExtendParameters = extendCmd + " requires 4 or 5 parameters.";
string errorGetrefsParameters = getrefsCmd + " requires 3, 4 or 5 parameters.";
string errorMaxresultsParameters = maxresultsCmd + " requires one parameter.";
string errorSqlParameters = sqlCmd + " requires one parameter.";
string errorPsalminfoParameters = psalminfoCmd + " requires 2 parameters.";
string errorRawParameters = rawCmd + " requires 4 parameters.";
string errorRawIncomplete = "Either " + rawCmd + "1 or " + rawCmd + "2 must be used.";
string errorColorsParameters = colorsCmd + " requires one parameter.";
string errorTokensParameters = tokensCmd + " requires 3 or 4 parameters.";
string errorSearchParameters = searchCmd + " requires at least one parameter.";
string errorMisc = "Sorry, there were some problems with the command you entered.";

vector<string> commands {addbooksCmd, compareCmd + "12", jaccardCmd + "12",
      textCmd + "1", textCmd + "2", lookupCmd + "1", lookupCmd + "2", quitCmd,
      helpCmd, findCmd + "1", findCmd + "2", lengthCmd + "1", lengthCmd + "2",
      minuniqueCmd + "1", latintextCmd + "1", latintextCmd + "2",
      extendCmd, getrefsCmd, lookupCmd, maxresultsCmd, sqlCmd, psalminfoCmd,
      rawCmd, rawCmd + "1", rawCmd + "2",
      printCmd + "1", printCmd + "2", colorsCmd, tokensCmd, searchCmd
                          };
vector<string> vocabulary = commands;

void add_vocabulary_item(string item) {
  replace(item.begin(), item.end(), ' ', '_');
  vocabulary.push_back(item);
}

string collect_info = "";

void info(const string& message) {
#ifndef __EMSCRIPTEN__
  cerr << output_prepend_set << message << endl << flush;
#else
  cout << message << endl << flush;
#endif
  collect_info = collect_info + message + "\n";
}

#ifndef __EMSCRIPTEN__
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
#endif

int maxresults;
bool sql;
char* output_prepend_set;
string ot_color, nt_color, reset_color, error_color;

void set_colors(bool colored) {
  ot_color = "";
  nt_color = "";
  reset_color = "";
  error_color = "";

  if (colored) {
    ot_color = OT_COLOR;
    nt_color = NT_COLOR;
    reset_color = RESET_COLOR;
    error_color = ERROR_COLOR;
  }
}

void processAddbooksCmd() {
  if (booksAdded) {
    error("Books already added.");
  } else {
    if (addBibles() == 0) {
      booksAdded = true;
    }
  }
}

void processQuitCmd() {
  info("Goodbye.");
  exit(0);
}

void processHelpCmd(string input) {
    int commandLength = helpCmd.length();
    if (input.length() != commandLength) {
        string rest = input.substr(input.find(" ") + 1);
        if ((boost::ends_with(rest, "1") || boost::ends_with(rest, "2")) && !boost::ends_with(rest, "12"))
        rest = rest.substr(0, rest.length()-1) + "N";
        vector<string> helpStr = {"* `addbooks`: Load the books of LXX, SBLGNT and StatResGNT (if any of these are available). Most commands require that these books are already loaded. After using this command for the first time (it takes a couple of seconds), a folder named `bibref-addbooks-cache` will be created in the current working directory to speed up the next startup of this command.",
            "* `textN` *text*: Define a Greek *text* and put its Latin transcription in clipboard N.",
            "* `latintextN` *text*: Put the Latin transcription *text* in clipboard N.",
            "* `findN` *Bible*: Search for the text of clipboard N in the given *Bible*.",
            "* `lengthN`: Compute the length of the text in clipboard N.",
            "* `printN`: Show the Greek text in clipboard N (without punctuation and spaces).",
            "* `lookup` *Bible* *book* *verse*: Search for the given *verse* in the given *book* in the given *Bible*. Here *Bible* can be any translation that is already [installed as a module](https://www.crosswire.org/sword/modules/ModDisp.jsp?modType=Bibles) on the computer.",
            "* `lookupN` *Bible* *book* *passage*: Search for the given *passage* in the given *book* in the given *Bible* and put its Latin transcription in clipboard N.",
            "* `search` *Bible* *token1* *token2* ... *tokenN* *maxlength*: Search for the given set of tokens on a maximal length of *maxlength* in the given *Bible*.",
            "* `raw` *Bible* *book* *start* *length*: Show the raw Latin transcription of a passage in the given *book* in the given *Bible*, beginning with the *start* position on *length* characters.",
            "* `rawN` *Bible* *book* *start* *length*: Put a passage in the given *book* in the given *Bible*, beginning with the *start* position on *length* characters, in clipboard N.",
            "* `minunique1` *Bible*: Search for minimal unique passages in clipboard 1 in the given *Bible*.",
            "* `extend` *Bible1* *Bible2* *book2* *passage2*: Extend the given passage in *Bible2* according to the longest possible citation from *Bible1*, based on the text of *book2* in *passage2*. In most cases `LXX` is used for *Bible1* and `SBLGNT` for *Bible2*.",
            "* `psalminfo` *Bible* *number*: Show the number of verses in Psalm *number* in the given *Bible*.",
            "* `getrefs` *Bible2* *Bible1* *book1* *passage1*: Search for references in *Bible2* on the passage in *Bible1* in book *book1* in *passage1*. Usually `SBLGNT` stands for *Bible2* and `LXX` for *Bible1*. If *book1* is `Psalms`, the passage can also be its number only.",
            "* `maxresults` *number*: Set the maximal amount of results to be shown to *number*.",
            "* `compare12`: Compare the two clipboards with a 2-long substring-fingerprint (2-shingles) check, best match is reached at 1/(length1+length2).",
            "* `jaccard12`: Compare the two clipboards the same way how `compare12` does but use the \"Jaccard similarity for bags\" algorithm, best match is reached at 0.",
            "* `sql` *switch*: Set some outputs to be shown also as an SQL query if *switch* is `on`.",
            "* `colors` *switch*: Show some outputs colored if *switch* is `on`.",
            "* `tokens` *Bible* *book* *verse*: Search for the given *verse* in the given *book* in the given *Bible* (see command `lookup`), but the output is shown in a tokenized form. Tokenization is done via Strong's numbers.",
            "* `help` *command*: Show some hints on usage of *command*, or get general help if no parameter is given.",
            "* `quit`: Exit program."};
        bool found = false;
        for (int i = 0; i < helpStr.size(); i++) {
            string helpText = helpStr[i];
            if (helpText.length() >= 4 + commandLength && helpText.substr(3, rest.length()) == rest) {
                info(helpText.substr(2)); // remove trailing "* "
                found = true;
                }
            }
        if (!found) {
            error("Command `" + rest + "` is not supported.");
            string commands_flattened = commands[0];
            for (int i = 1; i < commands.size(); i++) {
                commands_flattened += ", " + commands[i];
                }
            error("Available commands are: " + commands_flattened + ".");
            }
        return;
        }
#ifdef __EMSCRIPTEN__
    showAvailableBibles();
#endif
    info("Please visit https://github.com/kovzol/bibref#bibref to get online help.");
}

void processTextCmd(string input) {
  int index; // clipboard number (0 or 1), if used
  int commandLength = textCmd.length();
  if (input.length() == commandLength) {
    error(errorTextIncomplete);
    return;
  }
  if (input.at(commandLength) == '1') {
    index = 0; // using clipboard 1
  }
  else if (input.at(commandLength) ==  '2') {
    index = 1; // using clipboard 2
  } else {
    error(errorTextIncomplete);
    return;
  }
  if (input.length() < textCmd.length() + 2) {
    error(errorTextParameters);
    return;
  }
  if (input.at(commandLength + 1) != ' ') {
    error("Either " + textCmd + "1 or " + textCmd + "2 must be used.");
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  // Remove accidental Greek accents first:
  SWMgr manager;
  manager.setGlobalOption("Greek Accents", "Off"); // disable accents
  SWBuf to_convert = rest.data();
  manager.filterText("Greek Accents", to_convert);
  // Convert Greek to Latin:
  string processed = processVerse(to_convert.c_str());
  if (processed.length() == 0) {
    error("Text does not contain Greek letters, ignored.");
    return; // Success, but nothing happened.
  }
  text[index] = processed; // Store result.
  textset[index] = true; // activate clipboard
  info("Stored internally as " + processed + "."); // Success!
}

void processSearchCmd(string input) {
  int index;
  if (input.length() < searchCmd.length() + 1) {
    error(errorSearchParameters);
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  index = rest.find(" ");
  string moduleName = rest.substr(0, index); // Search in the given Bible edition...
  rest = rest.substr(index + 1);

  vector<int> pattern; // the token pattern to be searched
  std::stringstream ss(rest);

  int s = 0;
  int t;
  while (ss >> t) {
    pattern.push_back(t);
    s += 1; // count the tokens in the pattern
  }
  if (s==0) { // no pattern was defined
    error(errorSearchParameters);
    return;
  }

  s--;
  int length = pattern.at(s); // the last parameter
  pattern.pop_back(); // remove it from the token pattern
  info("Read " + to_string(s) + " tokens, searching for an extension of max. " + to_string(length) + " tokens.");
  if (length < s) { // the length must be at least the length of the pattern
    error("Surely, this will not be working.");
  } else {
    searchTokenset(moduleName, pattern, length, true); // Start search...
  }
}

void processLatintextCmd(string input) {
  int index; // clipboard number (0 or 1), if used
  int commandLength = latintextCmd.length();
  if (input.length() == commandLength) {
    error(errorLatintextIncomplete);
    return;
  }
  if (input.at(commandLength) == '1') {
    index = 0; // using clipboard 1
  }
  else if (input.at(commandLength) ==  '2') {
    index = 1; // using clipboard 2
  } else {
    error(errorLatintextIncomplete);
    return;
  }
  if (input.length() < latintextCmd.length() + 2) {
    error(errorLatintextParameters);
    return;
  }
  if (input.at(commandLength + 1) != ' ') {
    error("Either " + latintextCmd + "1 or " + latintextCmd + "2 must be used.");
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  text[index] = rest; // The remaining part of the input is stored as is.
  textset[index] = true; // activate clipboard
  info("Stored."); // Success!
}

void processLookupCmd(string input) {
  int index; // clipboard number (0 or 1), if used
  int commandLength = lookupCmd.length();
  if (input.length() == commandLength) {
    error(errorLookupIncomplete);
    return;
  }
  if (input.at(commandLength) == ' ') { // no clipboard is requested
    string rest = input.substr(input.find(" ") + 1);
    vector<string> tokens;
    boost::split(tokens, rest, boost::is_any_of(" "));
    int restSize = tokens.size();
    if (restSize == 3) { // e.g. lookup LXX Genesis 1:1
      lookupTranslation(tokens[0], tokens[1], tokens[2]); // simple lookup via Sword
    } else {
      error(errorLookupParameters);
    }
    return; // Success!
  }
  if (input.at(commandLength) == '1') {
    index = 0; // using clipboard 1
  }
  else if (input.at(commandLength) ==  '2') {
    index = 1; // using clipboard 2
  } else {
    error(errorLookupIncomplete);
    return;
  }
  if (input.length() < lookupCmd.length() + 2) {
    error(errorLookupParameters);
    return;
  }
  if (input.at(commandLength + 1) != ' ') {
    error(errorLookupIncomplete);
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  vector<string> tokens;
  boost::split(tokens, rest, boost::is_any_of(" "));
  int restSize = tokens.size();
  if (restSize == 3) {
    string verse = "";
    try { // e.g. lookup1 LXX Genesis 1:1
      verse = lookupVerse(tokens[1], tokens[0], tokens[2]); // lookup in the a-y database
      text[index] = verse; // Store result.
      textset[index] = true; // activate clipboard
      info("Stored internally as " + verse + ".");
    } catch (exception &e) {
      error(errorMisc);
    }
    return; // Success!
  }
  if (restSize == 4) { // e.g. lookup1 LXX Genesis 1:1+3 1:2-4
    string verse = "";
    try {
      vector<string> tokens2, tokens3;
      int start = 0, end = 0;
      boost::split(tokens2, tokens[2], boost::is_any_of("+"));
      if (tokens2.size() > 1) {
        start = stoi(tokens2[1]); // read off the plus shift
      }
      boost::split(tokens3, tokens[3], boost::is_any_of("-"));
      if (tokens3.size() > 1) {
        end = stoi(tokens3[1]); // read off the minus shift
      }
      // Shift-allowed lookup in the a-y database...
      verse = getText(tokens[1], tokens[0], tokens2.at(0), tokens3.at(0), start, end);
      text[index] = verse; // Store result.
      textset[index] = true; // activate clipboard
      info("Stored internally as " + verse + ".");
    } catch (exception &e) {
      error(errorMisc);
    }
    return; // Success!
  }
  error(errorLookupParameters); // another amount of parameters are given
}

void processTokensCmd(string input) {
  string rest = input.substr(input.find(" ") + 1);
  vector<string> tokens;
  boost::split(tokens, rest, boost::is_any_of(" "));
  int restSize = tokens.size();
  if (restSize == 3) {
    try {
      getTokens(tokens[0], tokens[1], tokens[2]);
    } catch (exception &e) {
      error(errorMisc);
    }
  } else {
    error(errorTokensParameters);
  }
}

void processFindCmd(string input) {
  int index;
  int commandLength = findCmd.length();
  if (input.length() == commandLength) {
    error(errorFindIncomplete);
    return;
  }
  if (input.at(commandLength) == '1') {
    index = 0;
  }
  else if (input.at(commandLength) ==  '2') {
    index = 1;
  } else {
    error(errorFindIncomplete);
    return;
  }
  if (input.length() < findCmd.length() + 1) {
    error(errorFindParameters);
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  if (text[index].length() == 0) {
    error(errorFindEmpty);
    return;
  }
  find(text[index], rest, maxresults, true);
}

void processLengthCmd(string input) {
  int index;
  int commandLength = lengthCmd.length();
  if (input.length() == commandLength) {
    error(errorLengthIncomplete);
    return;
  }
  if (input.at(commandLength) == '1') {
    index = 0;
  }
  else if (input.at(commandLength) ==  '2') {
    index = 1;
  } else {
    error(errorLengthIncomplete);
    return;
  }
  info("Length of text " + to_string(index + 1) + " is "
       + to_string(text[index].length()) + ".");
  return;
}

void processPrintCmd(string input) {
  int index;
  int commandLength = printCmd.length();
  if (input.length() == commandLength) {
    error(errorPrintIncomplete);
    return;
  }
  if (input.at(commandLength) == '1') {
    index = 0;
  }
  else if (input.at(commandLength) ==  '2') {
    index = 1;
  } else {
    error(errorPrintIncomplete);
    return;
  }
  info(latinToGreek(text[index]));
}

void processMaxresultsCmd(string input) {
  int index;
  int commandLength = maxresultsCmd.length();
  if (input.length() == commandLength) {
    error(errorMaxresultsParameters);
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  maxresults = stoi(rest);
  info("Set to " + to_string(maxresults) + ".");
}

void processSqlCmd(string input) {
  int index;
  int commandLength = sqlCmd.length();
  if (input.length() == commandLength) {
    error(errorSqlParameters);
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  if (rest.compare("on")==0 || rest.compare("1")==0 || rest.compare("true")==0) {
    sql = true;
    info("SQL output enabled.");
  } else
  {
    sql = false;
    info("SQL output disabled.");
  }
}

void processColorsCmd(string input) {
  int index;
  int commandLength = colorsCmd.length();
  if (input.length() == commandLength) {
    error(errorColorsParameters);
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  if (rest.compare("on")==0 || rest.compare("1")==0 || rest.compare("true")==0) {
    set_colors(true);
    info("Colors enabled.");
  } else
  {
    set_colors(false);
    info("Colors disabled.");
  }
}

void processCompareCmd() {
  if (textset.at(0) && textset.at(1)) {
    compareLatin(text[0], text[1]);
  } else {
    error("Text 1 or 2 is not set.");
  }
}

void processJaccardCmd() {
  if (textset.at(0) && textset.at(1)) {
    double jd = jaccard_dist(text[0], text[1]);
    info("Jaccard distance is " + to_string(jd) + ".");
  } else {
    error("Text 1 or 2 is not set.");
  }
}

void processPsalminfoCmd(string input) {
  vector<string> tokens;
  boost::split(tokens, input, boost::is_any_of(" "));
  int size = tokens.size();
  if (size == 3) {
    try {
      int psalmInfo = getPsalmLastVerse(tokens[1], stoi(tokens[2]));
      info(tokens[1] + " Psalm " + tokens[2] + " contains " + to_string(psalmInfo) + " verses.");
    } catch (exception &e) {
      error(errorMisc);
    }
  } else {
    error(errorPsalminfoParameters);
  }
}

void processMinuniqueCmd(string input) {
  int commandLength = minuniqueCmd.length();
  if (input.length() == commandLength) {
    error(errorMinuniqueParameters);
    return;
  }
  if (input.length() < minuniqueCmd.length() + 2) {
    error(errorMinuniqueParameters);
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  find_min_unique(text[0], rest, true);
}

void processRawCmd(string input) {
  int index; // clipboard number (0 or 1), if used
  int commandLength = rawCmd.length();
  if (input.length() == commandLength) {
    error(errorRawIncomplete);
    return;
  }
  if (input.at(commandLength) == ' ') { // no clipboard is requested
    string rest = input.substr(input.find(" ") + 1);
    vector<string> tokens;
    boost::split(tokens, rest, boost::is_any_of(" "));
    int restSize = tokens.size();
    if (restSize == 4) { // e.g. raw LXX Genesis 1 10
      try {
        string module = tokens[0]; // LXX
        string book = tokens[1]; // Genesis
        int startPos = stoi(tokens[2]); // 1
        int length = stoi(tokens[3]); // 10
        string text = getRaw(module, book, startPos - 1, length); // Obtain the raw text...
        info(text); // Report the result.
        return; // Success!
      } catch (exception &e) {
        error(errorMisc);
        return;
      }
    } else {
      error(errorRawParameters);
      return;
    }
  }
  if (input.at(commandLength) == '1') {
    index = 0; // using clipboard 1
  }
  else if (input.at(commandLength) == '2') {
    index = 1; // using clipboard 1
  } else {
    error(errorRawIncomplete);
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  vector<string> tokens;
  boost::split(tokens, rest, boost::is_any_of(" "));
  int restSize = tokens.size();
  if (restSize == 4) { // e.g. raw1 LXX Genesis 1 10
    // TODO: This part is same as above. Unify.
    try {
      string module = tokens[0]; // LXX
      string book = tokens[1]; // Genesis
      int startPos = stoi(tokens[2]); // 1
      int length = stoi(tokens[3]); // 10
      text[index] = getRaw(module, book, startPos - 1, length); // Obtain the raw text...
      textset[index] = true; // Report the result.
      info("Stored.");
      return; // Success!
    } catch (exception &e) {
      error(errorMisc);
      return;
    }
  } else {
    error(errorRawParameters);
    return;
  }
}

void processExtendCmd(string input) {
  int commandLength = extendCmd.length();
  if (input.length() == commandLength) {
    error(errorExtendParameters);
    return;
  }
  if (input.at(commandLength) != ' ') {
    error(errorExtendParameters);
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  vector<string> tokens;
  boost::split(tokens, rest, boost::is_any_of(" "));
  int restSize = tokens.size();
  string moduleName1 = tokens[0]; // Old Testament
  string moduleName2 = tokens[1]; // New Testament
  string book2 = tokens[2]; // a book from the New Testament
  string verse2S, verse2E;
  if (restSize == 4) { // e.g. extend LXX StatResGNT Romans 3:13
    verse2S = tokens[3] + "+0"; // add zero plus shift implicitly
    verse2E = tokens[3] + "-0"; // add zero minus shift implicitly
  } else if (restSize == 5) { // e.g. extend LXX StatResGNT Romans 15:11+38 15:11-22
    verse2S = tokens[3];
    verse2E = tokens[4];
  } else {
    error(errorExtendParameters);
    return;
  }
  vector<string> verse2ST, verse2ET;
  int start = 0, end = 0;
  boost::split(verse2ST, verse2S, boost::is_any_of("+"));
  if (verse2ST.size() > 1) {
    start = stoi(verse2ST[1]); // read off plus shift
  }
  boost::split(verse2ET, verse2E, boost::is_any_of("-"));
  if (verse2ET.size() > 1) {
    end = stoi(verse2ET[1]); // read off minus shift
  }
  try {
    // Compute...
    extend(moduleName1, moduleName2, book2, verse2ST[0], start, verse2ET[0], end);
  } catch (exception &e) {
    error(errorMisc);
  }
  // Success!
}

void processGetrefsCmd(string input) {
  int commandLength = getrefsCmd.length();
  if (input.length() == commandLength) {
    error(errorGetrefsParameters);
    return;
  }
  if (input.at(commandLength) != ' ') {
    error(errorGetrefsParameters);
    return;
  }
  string rest = input.substr(input.find(" ") + 1);
  vector<string> tokens;
  boost::split(tokens, rest, boost::is_any_of(" "));
  int restSize = tokens.size();
  if (restSize < 3) {
    error(errorGetrefsParameters);
    return;
  }
  string moduleName2 = tokens[0]; // New Testament
  string moduleName1 = tokens[1]; // Old Testament
  string book1 = tokens[2]; // a book from the Old Testament
  string verse1S, verse1E;
  if (restSize == 3) { // TODO: implement this
    error("Getting references from full books is not yet implemented, sorry.");
    return;
  }
  if (restSize == 4) { // e.g. getrefs StatResGNT LXX Isaiah 9:2
    if (book1 == "Psalms") {
      vector<string> r;
      boost::split(r, tokens[3], boost::is_any_of(":"));
      if (r.size() == 1) { // only the psalm number is given, e.g. getrefs StatResGNT LXX Psalms 51
        verse1S = r[0] + ":1+0";
        try {
          verse1E = r[0] + ":" + to_string(getPsalmLastVerse(moduleName1, stoi(r[0]))) + "-0";
        } catch (exception &e) {
          error(errorMisc);
        }
      } else { // one verse is given in the psalm, e.g. getrefs StatResGNT LXX Psalms 51:4
        verse1S = tokens[3] + "+0"; // add zero plus shift implicitly
        verse1E = tokens[3] + "-0"; // add zero minus shift implicitly
      }
    } else { // this is not a psalm and one verse is given
      verse1S = tokens[3] + "+0"; // add zero plus shift implicitly
      verse1E = tokens[3] + "-0"; // add zero negative shift implicitly
    }
  } else if (restSize == 5) { // e.g. getrefs StatResGNT LXX Psalms 51:4 51:5
    verse1S = tokens[3];
    verse1E = tokens[4];
  } else {
    error(errorExtendParameters);
    return;
  }
  vector<string> verse1ST, verse1ET;
  int start = 0, end = 0;
  boost::split(verse1ST, verse1S, boost::is_any_of("+"));
  if (verse1ST.size() > 1) {
    start = stoi(verse1ST[1]); // read off plus shift
  }
  boost::split(verse1ET, verse1E, boost::is_any_of("-"));
  if (verse1ET.size() > 1) {
    end = stoi(verse1ET[1]); // read off minus shift
  }
  try {
    // Compute...
    getrefs(moduleName2, moduleName1, book1, verse1ST[0], start, verse1ET[0], end);
  } catch (exception &e) {
    error(errorMisc);
  }
  info("Finished"); // Success!
}

string cli_process(char *buf) {
  string rawinput(buf); // Convert the input to string.
  boost::algorithm::trim(rawinput); // Trim the input.
  vector<string> commentTokens;
  boost::split(commentTokens, rawinput, boost::is_any_of("#"));
  string input = commentTokens[0]; // Do not use any characters before "#".
  boost::algorithm::trim(input); // Trim the remaining parts of the input.

  // Check if the input command is one of the available commands.

  // Commands with no parameters...
  if (input.compare(addbooksCmd) == 0)
    processAddbooksCmd();
  else if (input.compare(quitCmd) == 0)
    processQuitCmd();
  // Commands with some parameters...
  // TODO: This list is not ordered, it should be listed alphabetically,
  // or even better, an array could be defined to combine strings and functions.
  else if (boost::starts_with(input, helpCmd))
    processHelpCmd(input);
  else if (boost::starts_with(input, textCmd))
    processTextCmd(input);
  else if (boost::starts_with(input, searchCmd))
    processSearchCmd(input);
  else if (boost::starts_with(input, latintextCmd))
    processLatintextCmd(input);
  else if (boost::starts_with(input, lookupCmd))
    processLookupCmd(input);
  else if (boost::starts_with(input, tokensCmd))
    processTokensCmd(input);
  else if (boost::starts_with(input, findCmd))
    processFindCmd(input);
  else if (boost::starts_with(input, lengthCmd))
    processLengthCmd(input);
  else if (boost::starts_with(input, printCmd))
    processPrintCmd(input);
  else if (boost::starts_with(input, maxresultsCmd))
    processMaxresultsCmd(input);
  else if (boost::starts_with(input, sqlCmd))
    processSqlCmd(input);
  else if (boost::starts_with(input, colorsCmd))
    processColorsCmd(input);
  // Commands that require an appendix...
  else if (boost::starts_with(input, compareCmd + "12"))
    processCompareCmd();
  else if (boost::starts_with(input, jaccardCmd + "12"))
    processJaccardCmd();
  else if (boost::starts_with(input, minuniqueCmd + "1"))
    processMinuniqueCmd(input);
  // TODO: Consider using this trick for the other commands:
  else if (boost::starts_with(input, psalminfoCmd + " "))
    processPsalminfoCmd(input);
  else if (boost::starts_with(input, rawCmd))
    processRawCmd(input);
  else if (boost::starts_with(input, extendCmd))
    processExtendCmd(input);
  else if (boost::starts_with(input, getrefsCmd))
    processGetrefsCmd(input);
  // If the input is not recognized, we show an error...
  else if (input.length() != 0) // unless there was no input at all
    error(errorNotRecognized);

  // Finally, we return with the previously collected info and clear that variable...
  string ret = collect_info;
  collect_info = "";
  return ret;
}

void cli(const char *input_prepend, const char *output_prepend, bool addbooks, bool colored) {
  output_prepend_set = new char[4]; // FIXME: this is hardcoded.
  strcpy(output_prepend_set, output_prepend);
#ifndef __EMSCRIPTEN__
  rl_attempted_completion_function = completer; // Initialize readline.
#endif
  info("This is bibref " BIBREF_VERSION ", nice to meet you.");
  showAvailableBibles();
  if (addbooks) {
    if (addBibles() == 0) {
      booksAdded = true;
    }
  }

  maxresults = 100; // Query results are maximized in 100 results by default.
  sql = false; // SQL output is disabled by default.

  set_colors(colored); // Set default coloring.

#ifndef __EMSCRIPTEN__
#ifndef __MINGW32__
  // Load the readline history...
  char* buf;
  struct passwd *pw = getpwuid(getuid());
  char *histfile = pw->pw_dir;
  strcat(histfile, "/.bibref_history");
  read_history(histfile);
#endif
#endif

#if defined(__EMSCRIPTEN__) || defined(__MINGW32__)
#define MAX_LINE_LENGTH 1024
  char buf[MAX_LINE_LENGTH + 1];
  string line;
#endif

  // The main input/output loop...
  while (
       #if !defined(__EMSCRIPTEN__) && !defined(__MINGW32__)
         (buf = readline(input_prepend)) != nullptr
       #else
         (getline(cin, line) && (strcpy(buf, line.c_str())))
       #endif
         ) {
#if !defined(__EMSCRIPTEN__) && !defined(__MINGW32__)
    if (strlen(buf) > 0) {
      add_history(buf);
      write_history(histfile);
    }
#endif
    cli_process(buf); // Process the input.
    // readline malloc's a new buffer every time.
    free(buf);
  }
}

#ifdef __EMSCRIPTEN__
#include <emscripten.h>
// Taken from https://github.com/emscripten-core/emscripten/issues/6433
extern "C" {
inline const char* cstr(const std::string& message) {
  auto buffer = (char*) malloc(message.length() + 1);
  buffer[message.length()] = '\0';
  memcpy(buffer, message.data(), message.length());
  return buffer;
}
EMSCRIPTEN_KEEPALIVE const char* bibref_wasm(char *input) {
  string output = cli_process(input);
  return cstr(output);
}
EMSCRIPTEN_KEEPALIVE const char* bibref_wasm_vocabulary() {
  string output = "";
  for (auto word : vocabulary) {
    output += word + ",";
  }
  return cstr(output);
}
}
#endif

void error(const string& message) {
#ifndef __EMSCRIPTEN__
  cerr << error_color;
#endif
  cerr << message;
#ifndef __EMSCRIPTEN__
  cerr << reset_color;
#endif
  cerr << endl << flush;
  collect_info = collect_info + error_color + message + reset_color + "\n";
}
