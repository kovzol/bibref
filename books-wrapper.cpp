#include "books.h"
#include <iostream>
#include <cstring>

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

EXTERNC const char* lookupVerse1(const char* book, const char* info, const char* verse) {
  string book1 = string(book);
  string info1 = string(info);
  string verse1 = string(verse);
  string lv = lookupVerse(book1, info1, verse1);
  char *ret = (char*) malloc(lv.length()+1);
  strcpy(ret, lv.c_str()); // https://groups.google.com/g/jna-users/c/DTHzhKd8qqY
  return ret;
}

EXTERNC int addBibles1() {
  return addBibles();
}
