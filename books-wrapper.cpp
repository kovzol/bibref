#include "books.h"
#include <iostream>
#include <cstring>

#include <boost/algorithm/string/find.hpp>
#include <boost/algorithm/string/replace.hpp>
#include <boost/algorithm/string/split.hpp>
#include <boost/algorithm/string/trim.hpp>

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

EXTERNC const char* lookupVerse1(const char* book0, const char* info0, const char* verse0) {
  string book1 = string(book0);
  string info1 = string(info0);
  string verse1 = string(verse0);
  string lv = "error: " + book1 + " " + info1 + " " + verse1;

  // Mostly taken from cli:
  vector<string> tokens;
  boost::split(tokens, verse1, boost::is_any_of(" "));
  int restSize = tokens.size();
  if (restSize == 1) {
    try { // e.g. lookup1 LXX Genesis 1:1
      lv = lookupVerse(book1, info1, verse1); // lookup in the a-y database
    } catch (exception &e) {
      lv += " - " + string(e.what());
    }
  }
  if (restSize == 2) { // e.g. lookup1 LXX Genesis 1:1+3 1:2-4
    try {
      vector<string> tokens2, tokens3;
      int start = 0, end = 0;
      boost::split(tokens2, tokens[0], boost::is_any_of("+"));
      if (tokens2.size() > 1) {
        start = stoi(tokens2[1]); // read off the plus shift
      }
      boost::split(tokens3, tokens[1], boost::is_any_of("-"));
      if (tokens3.size() > 1) {
        end = stoi(tokens3[1]); // read off the minus shift
      }
      // Shift-allowed lookup in the a-y database...
      lv = getText(book1, info1, tokens2.at(0), tokens3.at(0), start, end);
    } catch (exception &e) {
      lv += " - " + string(e.what());
      }
    }
  // TODO: eventually handle other restSize values (as errors)

  char *ret = (char*) malloc(lv.length()+1);
  strcpy(ret, lv.c_str()); // https://groups.google.com/g/jna-users/c/DTHzhKd8qqY
  return ret;
}

EXTERNC int addBibles1() {
  return addBibles();
}
