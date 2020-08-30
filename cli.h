#ifndef CLI_H
#define CLI_H

using namespace std;
#include <string>

char** completer(const char* text, int start, int end);
void cli(const char *input_prepend, const char* output_prepend);
void add_vocabulary_item(string item);
void error(string message);
void info(string message);
static int maxresults;
static char *output_prepend_set;

#endif // CLI_H
