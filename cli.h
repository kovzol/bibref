#ifndef CLI_H
#define CLI_H

using namespace std;
#include <string>

char** completer(const char* text, int start, int end);
void cli();
void add_vocabulary_item(string item);

#endif // CLI_H
