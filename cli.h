#ifndef CLI_H
#define CLI_H

#define BIBREF_VERSION "2025Mar10"

#include <string>

using namespace std;

void cli(const char *input_prepend, const char *output_prepend, bool addbooks, bool colored);
void add_vocabulary_item(string item);
void error(const string &message);
void info(const string &message);
string getHelp(const string &key);
extern int maxresults;
extern bool sql;
extern char *output_prepend_set;
extern string ot_color;
extern string nt_color;
extern string reset_color;

#endif // CLI_H
