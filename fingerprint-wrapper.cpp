#include "fingerprint.h"
#include <cstring>
#include <iostream>

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

EXTERNC double jaccard_dist1(const char *text1, const char *text2)
{
    string text11 = string(text1);
    string text21 = string(text2);
    return jaccard_dist(text11, text21);
}
