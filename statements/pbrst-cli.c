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
  extern int correct_raw;
  extern int show_dump;

  bool colorize = false;
  bool graphviz = false;
  correct_raw = 0;
  show_dump = 0;
  bool show_only_dump = false;

  while (ac>1 && (!strcmp(av[1], "-d") || !strcmp(av[1], "-c")
    || !strcmp(av[1], "-g") || !strcmp(av[1], "-r") || !strcmp(av[1], "-h")
    || !strcmp(av[1], "-u") || !strcmp(av[1], "-U"))) {

    if(!strcmp(av[1], "-h")) {
      printf("pbrst-cli [options] [input.brst], a command line brst parser\n");
      printf("Options:\n");
      printf(" -h\tthis help\n");
      printf(" -d\tswitch debug mode on\n");
      printf(" -c\tcolorize output\n");
      printf(" -g\tshow only graphviz output\n");
      printf(" -r\tcorrect raw positions\n");
      printf(" -u\tshow BRST dump\n");
      printf(" -U\tshow only BRST dump\n");
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

    if(!strcmp(av[1], "-r")) {
      correct_raw = 1; ac--; av++;
    }

    if(!strcmp(av[1], "-u")) {
      show_dump = 1; ac--; av++;
    }

    if(!strcmp(av[1], "-U")) {
      show_dump = 1; show_only_dump = true; ac--; av++;
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
    if (show_dump == 1) {
      create_dump();
      }
    if (show_only_dump) {
      char *d_start = strstr(parseinfo, "dump: brst: start\n");
      if (d_start == NULL) exit(0); // empty output
      d_start = strstr(d_start, "\n");
      d_start++;
      char *d_end = strstr(parseinfo, "dump: brst: end");
      d_end[0] = '\0';
      // Now d_start points to the beginning of the first line after "dump: brst: start"
      // and the C string ends before the line "dump: brst: end"
      printf("%s", d_start);
      exit(0);
      }
    if (graphviz) {
      char *g_start = strstr(parseinfo, "diagram: graphviz: start\n");
      if (g_start == NULL) exit(0); // empty output
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
#define HMAG "\e[0;95m"
#define HYEL "\e[0;93m"
#define CYN "\e[0;36m"
#define COLOR_RESET "\e[0m"
      char *pi2 = str_replace(parseinfo, ": error:", ": " HRED "error" COLOR_RESET ":");
      char *pi3 = str_replace(pi2, ": warning:", ": " HYEL "warning" COLOR_RESET ":");
      char *pi4 = str_replace(pi3, ": debug:", ": " CYN "debug" COLOR_RESET ":");
      char *pi5 = str_replace(pi4, ": corrected:", ": " HMAG "corrected" COLOR_RESET ":");
      printf("%s", pi5);
      free(pi2);
      free(pi3);
      free(pi4);
      free(pi5);
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
