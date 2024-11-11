#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <stdio.h>
#include "pbrst.tab.h"

extern char *stmt_identifier;

int main(int ac, char **av)
{
  extern FILE *yyin;

  if(ac > 1 && !strcmp(av[1], "-d")) {
    yydebug = 1; ac--; av++;
  }

  if(ac > 1 && (yyin = fopen(av[1], "r")) == NULL) {
    perror(av[1]);
    exit(1);
  }

  if(!yyparse()) {
    printf("brst parse worked\n");
    printf("statement identifier: %s\n", stmt_identifier);
    }
  else
    printf("brst parse failed\n");
}
