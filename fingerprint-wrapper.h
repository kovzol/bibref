#ifndef FINGERPRINT_WRAPPER_H
#define FINGERPRINT_WRAPPER_H

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

double jaccard_dist1(const char *text1, const char *text2);

#endif // FINGERPRINT_WRAPPER_H
