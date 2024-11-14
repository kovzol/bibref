#ifndef BOOKS_WRAPPER_H
#define BOOKS_WRAPPER_H

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

EXTERNC const char* lookupVerse1(const char* book, const char* info, const char* verse);
EXTERNC int hello(int a);

#endif // BOOKS_WRAPPER_H
