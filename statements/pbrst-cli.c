#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include "pbrst.tab.h"

extern char *stmt_identifier;
extern int yydebug;
extern char *parseinfo;

// Taken from https://stackoverflow.com/a/779960/1044586
// You must free the result if result is non-NULL.
char *str_replace(char *orig, char *rep, char *with) {
    char *result; // the return string
    char *ins;    // the next insert point
    char *tmp;    // varies
    int len_rep;  // length of rep (the string to remove)
    int len_with; // length of with (the string to replace rep with)
    int len_front; // distance between rep and end of last rep
    int count;    // number of replacements

    // sanity checks and initialization
    if (!orig || !rep)
        return NULL;
    len_rep = strlen(rep);
    if (len_rep == 0)
        return NULL; // empty rep causes infinite loop during count
    if (!with)
        with = "";
    len_with = strlen(with);

    // count the number of replacements needed
    ins = orig;
    for (count = 0; (tmp = strstr(ins, rep)); ++count) {
        ins = tmp + len_rep;
    }

    tmp = result = malloc(strlen(orig) + (len_with - len_rep) * count + 1);

    if (!result)
        return NULL;

    // first time through the loop, all the variable are set correctly
    // from here on,
    //    tmp points to the end of the result string
    //    ins points to the next occurrence of rep in orig
    //    orig points to the remainder of orig after "end of rep"
    while (count--) {
        ins = strstr(orig, rep);
        len_front = ins - orig;
        tmp = strncpy(tmp, orig, len_front) + len_front;
        tmp = strcpy(tmp, with) + len_with;
        orig += len_front + len_rep; // move to next "end of rep"
    }
    strcpy(tmp, orig);
    return result;
}

int main(int ac, char **av)
{
  extern FILE *yyin;

  bool colorize = false;
  bool graphviz = false;

  while (ac>1 && (!strcmp(av[1], "-d") || !strcmp(av[1], "-c")
    || !strcmp(av[1], "-g") || !strcmp(av[1], "-h"))) {

    if(!strcmp(av[1], "-h")) {
      printf("pbrst-cli [options] [input.brst], a command line brst parser\n");
      printf("Options:\n");
      printf(" -h\tthis help\n");
      printf(" -d\tswitch debug mode on\n");
      printf(" -c\tcolorize output\n");
      printf(" -g\tshow only graphviz output\n");
      exit(0);
    }

    if(!strcmp(av[1], "-d")) {
      yydebug = 1; ac--; av++;
    }

    if(!strcmp(av[1], "-c")) {
      colorize = true; ac--; av++;
    }

    if(!strcmp(av[1], "-g")) {
      graphviz = true; ac--; av++;
    }

  }

  if(ac > 1 && (yyin = fopen(av[1], "r")) == NULL) {
    perror(av[1]);
    exit(2);
  }

  parseinfo = malloc(1);
  strcpy(parseinfo, "");

  if(!yyparse()) {
    if (strstr(parseinfo, ": error: ") == NULL) {
      create_diagram();
    }
    if (graphviz) {
      char *g_start = strstr(parseinfo, "diagram: graphviz: start\n");
      g_start = strstr(g_start, "\n");
      g_start++;
      char *g_end = strstr(parseinfo, "diagram: graphviz: end");
      g_end[0] = '\0';
      // Now g_start points to the beginning of the first line after "diagram: graphviz: start"
      // and the C string ends before the line "diagram: graphviz: end"
      printf("%s", g_start);
      exit(0);
    }
    if (colorize) {
#define HRED "\e[0;91m"
#define HYEL "\e[0;93m"
#define CYN "\e[0;36m"
#define COLOR_RESET "\e[0m"
      char *pi2 = str_replace(parseinfo, ": error:", ": " HRED "error" COLOR_RESET ":");
      char *pi3 = str_replace(pi2, ": warning:", ": " HYEL "warning" COLOR_RESET ":");
      char *pi4 = str_replace(pi3, ": debug:", ": " CYN "debug" COLOR_RESET ":");
      printf("%s", pi4);
      free(pi2);
      free(pi3);
      free(pi4);
    } else printf("%s", parseinfo);
    printf("brst parse worked\n");
    printf("statement identifier: %s\n", stmt_identifier);
    }
  else {
    printf("brst parse failed\n");
    return 1;
    }
  return 0;
}
