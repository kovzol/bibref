%option noyywrap nodefault yylineno case-insensitive
%{
#include "pbrst.tab.h"
#include <stdarg.h>
#include <string.h>

void yyerror(char *s, ...);

int yycolumn = 1;
#define YY_USER_ACTION \
    yylloc.first_line = yylloc.last_line = yylineno; \
    yylloc.first_column = yylloc.last_column; \
    yylloc.last_column = yycolumn + yyleng - 1; \
    yycolumn += yyleng;
%}

%x COMMENT


%%

  /* keywords */
STATEMENT { return STATEMENT; }
CONNECTS { return CONNECTS; }
WITH { return WITH; }
BASED { return BASED; }
ON { return ON; }
INTRODUCTION { return INTRODUCTION; }
A-Y { return A_Y; }
FORM { return FORM; }
THAT { return THAT; }
DECLARES { return DECLARES; }
A { return A; }
QUOTATION { return QUOTATION; }
AND { return AND; }
ALSO { return ALSO; }
IDENTIFIES { return IDENTIFIES; }
THE { return THE; }
SOURCE { return SOURCE; }
MOREOVER { return MOREOVER; }
FRAGMENT { return FRAGMENT; }
LENGTH { return LENGTH; }
MATCHES { return MATCHES; }
DIFFERING { return DIFFERING; }
BY { return BY; }
VERBATIM { return VERBATIM; }
PROVIDING { return PROVIDING; }
AN { return AN; }
OVERALL { return OVERALL; }
COVER { return COVER; }
OF { return OF; }
NO { return NO; }
EVIDENCE { return EVIDENCE; }

SBLGNT { yylval.strval = strdup(yytext); return SBLGNT; }
STATRESGNT { yylval.strval = strdup(yytext); return STATRESGNT; }
LXX { yylval.strval = strdup(yytext); return LXX; }

GENESIS { yylval.strval = strdup(yytext); return GENESIS; }
EXODUS { yylval.strval = strdup(yytext); return EXODUS; }
LEVITICUS { yylval.strval = strdup(yytext); return LEVITICUS; }
NUMBERS { yylval.strval = strdup(yytext); return NUMBERS; }
DEUTERONOMY { yylval.strval = strdup(yytext); return DEUTERONOMY; }
JOSHUA { yylval.strval = strdup(yytext); return JOSHUA; }
JUDGES { yylval.strval = strdup(yytext); return JUDGES; }
RUTH { yylval.strval = strdup(yytext); return RUTH; }
I_SAMUEL { yylval.strval = strdup(yytext); return I_SAMUEL; }
II_SAMUEL { yylval.strval = strdup(yytext); return II_SAMUEL; }
I_KINGS { yylval.strval = strdup(yytext); return I_KINGS; }
II_KINGS { yylval.strval = strdup(yytext); return II_KINGS; }
I_CHRONICLES { yylval.strval = strdup(yytext); return I_CHRONICLES; }
II_CHRONICLES { yylval.strval = strdup(yytext); return II_CHRONICLES; }
EZRA { yylval.strval = strdup(yytext); return EZRA; }
NEHEMIAH { yylval.strval = strdup(yytext); return NEHEMIAH; }
ESTHER { yylval.strval = strdup(yytext); return ESTHER; }
JOB { yylval.strval = strdup(yytext); return JOB; }
PSALMS { yylval.strval = strdup(yytext); return PSALMS; }
PROVERBS { yylval.strval = strdup(yytext); return PROVERBS; }
ECCLESIASTES { yylval.strval = strdup(yytext); return ECCLESIASTES; }
SONG_OF_SOLOMON { yylval.strval = strdup(yytext); return SONG_OF_SOLOMON; }
ISAIAH { yylval.strval = strdup(yytext); return ISAIAH; }
JEREMIAH { yylval.strval = strdup(yytext); return JEREMIAH; }
LAMENTATIONS { yylval.strval = strdup(yytext); return LAMENTATIONS; }
EZEKIEL { yylval.strval = strdup(yytext); return EZEKIEL; }
DANIEL { yylval.strval = strdup(yytext); return DANIEL; }
HOSEA { yylval.strval = strdup(yytext); return HOSEA; }
JOEL { yylval.strval = strdup(yytext); return JOEL; }
AMOS { yylval.strval = strdup(yytext); return AMOS; }
OBADIAH { yylval.strval = strdup(yytext); return OBADIAH; }
JONAH { yylval.strval = strdup(yytext); return JONAH; }
MICAH { yylval.strval = strdup(yytext); return MICAH; }
NAHUM { yylval.strval = strdup(yytext); return NAHUM; }
HABAKKUK { yylval.strval = strdup(yytext); return HABAKKUK; }
ZEPHANIAH { yylval.strval = strdup(yytext); return ZEPHANIAH; }
HAGGAI { yylval.strval = strdup(yytext); return HAGGAI; }
ZECHARIAH { yylval.strval = strdup(yytext); return ZECHARIAH; }
MALACHI { yylval.strval = strdup(yytext); return MALACHI; }
MATTHEW { yylval.strval = strdup(yytext); return MATTHEW; }
MARK { yylval.strval = strdup(yytext); return MARK; }
LUKE { yylval.strval = strdup(yytext); return LUKE; }
JOHN { yylval.strval = strdup(yytext); return JOHN; }
ACTS { yylval.strval = strdup(yytext); return ACTS; }
ROMANS { yylval.strval = strdup(yytext); return ROMANS; }
I_CORINTHIANS { yylval.strval = strdup(yytext); return I_CORINTHIANS; }
II_CORINTHIANS { yylval.strval = strdup(yytext); return II_CORINTHIANS; }
GALATIANS { yylval.strval = strdup(yytext); return GALATIANS; }
EPHESIANS { yylval.strval = strdup(yytext); return EPHESIANS; }
PHILIPPIANS { yylval.strval = strdup(yytext); return PHILIPPIANS; }
COLOSSIANS { yylval.strval = strdup(yytext); return COLOSSIANS; }
I_THESSALONIANS { yylval.strval = strdup(yytext); return I_THESSALONIANS; }
II_THESSALONIANS { yylval.strval = strdup(yytext); return II_THESSALONIANS; }
I_TIMOTHY { yylval.strval = strdup(yytext); return I_TIMOTHY; }
II_TIMOTHY { yylval.strval = strdup(yytext); return II_TIMOTHY; }
TITUS { yylval.strval = strdup(yytext); return TITUS; }
PHILEMON { yylval.strval = strdup(yytext); return PHILEMON; }
HEBREWS { yylval.strval = strdup(yytext); return HEBREWS; }
JAMES { yylval.strval = strdup(yytext); return JAMES; }
I_PETER { yylval.strval = strdup(yytext); return I_PETER; }
II_PETER { yylval.strval = strdup(yytext); return II_PETER; }
I_JOHN { yylval.strval = strdup(yytext); return I_JOHN; }
II_JOHN { yylval.strval = strdup(yytext); return II_JOHN; }
III_JOHN { yylval.strval = strdup(yytext); return III_JOHN; }
JUDE { yylval.strval = strdup(yytext); return JUDE; }
REVELATION_OF_JOHN { yylval.strval = strdup(yytext); return REVELATION_OF_JOHN; }

"." { return PERIOD; }

  /* numbers */
[0-9]+	{ yylval.intval = atoi(yytext); 
                  return INTNUM; } 

[0-9]+"."[0-9]*"%" |
"."[0-9]+"%"	{ yylval.strval = strdup(yytext);
                  yylval.strval[yyleng-1] = 0;
                  yylval.floatval = atof(yylval.strval) ;
                  return APPROXNUM; }

  /* strings */
'(\\.|''|[^'\n])*'	|
\"(\\.|\"\"|[^"\n])*\"  { yylval.strval = strdup(yytext); return STRING; }

'(\\.|[^'\n])*$	        { yyerror("Unterminated string %s", yytext); }
\"(\\.|[^"\n])*$	{ yyerror("Unterminated string %s", yytext); }

  /* a-y literals */
[a-y]+	{ yylval.strval = strdup(yytext); return AYLITERAL;}

  /* name */
[A-Za-z][A-Za-z0-9_]*	{ yylval.strval = strdup(yytext);
                          return NAME; }

  /* comments */
#.*		;

  /* verses */
[0-9]+":"[0-9]+ { yylval.strval = strdup(yytext); return VERSE; }
[0-9]+":"[0-9]+[+][0-9]+ { yylval.strval = strdup(yytext); return VERSESTART; }
[0-9]+":"[0-9]+[-][0-9]+ { yylval.strval = strdup(yytext); return VERSEEND; }

  /* raw positions */
"("[0-9]+"-"[0-9]+")" |
"("[0-9]+"-"[0-9]+","[ ]length[ ][0-9]+")"  { yylval.strval = strdup(yytext); return RAWPOSITION; }

  /* everything else */
[ \t\n]         /* white space */ { /* yycolumn = 1; */ }
.               { yyerror("mystery character '%c'", *yytext); }

%%
 