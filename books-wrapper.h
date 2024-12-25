#ifndef BOOKS_WRAPPER_H
#define BOOKS_WRAPPER_H

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

EXTERNC const char* lookupVerse1(const char* book, const char* info, const char* verse);
EXTERNC const char* greekToLatin1(const char* greek);
EXTERNC int addBibles1();
EXTERNC int find1(const char* text, const char* moduleName, int maxFound);

#endif // BOOKS_WRAPPER_H
