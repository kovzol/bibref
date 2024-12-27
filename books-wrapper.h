#ifndef BOOKS_WRAPPER_H
#define BOOKS_WRAPPER_H

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

EXTERNC char* lookupVerse1(const char* book, const char* info, const char* verse);
EXTERNC char* greekToLatin1(const char* greek);
EXTERNC int addBibles1();
EXTERNC int find1(const char* text, const char* moduleName, int maxFound);
EXTERNC char* getRaw1(const char* moduleName, const char* bookName, int startPos, int length);

#endif // BOOKS_WRAPPER_H
