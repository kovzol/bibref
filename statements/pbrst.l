%option noyywrap nodefault yylineno case-insensitive
%{
#include "pbrst.tab.h"
#include <stdarg.h>
#include <string.h>

void yyerror(char *s, ...);

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

SBLGNT { return SBLGNT; }
STATRESGNT { return STATRESGNT; }
LXX { return LXX; }
GENESIS { return GENESIS; }
EXODUS { return EXODUS; }
LEVITICUS { return LEVITICUS; }
NUMBERS { return NUMBERS; }
DEUTERONOMY { return DEUTERONOMY; }
JOSHUA { return JOSHUA; }
JUDGES { return JUDGES; }
RUTH { return RUTH; }
I_SAMUEL { return I_SAMUEL; }
II_SAMUEL { return II_SAMUEL; }
I_KINGS { return I_KINGS; }
II_KINGS { return II_KINGS; }
I_CHRONICLES { return I_CHRONICLES; }
II_CHRONICLES { return II_CHRONICLES; }
EZRA { return EZRA; }
NEHEMIAH { return NEHEMIAH; }
ESTHER { return ESTHER; }
JOB { return JOB; }
PSALMS { return PSALMS; }
PROVERBS { return PROVERBS; }
ECCLESIASTES { return ECCLESIASTES; }
SONG_OF_SOLOMON { return SONG_OF_SOLOMON; }
ISAIAH { return ISAIAH; }
JEREMIAH { return JEREMIAH; }
LAMENTATIONS { return LAMENTATIONS; }
EZEKIEL { return EZEKIEL; }
DANIEL { return DANIEL; }
HOSEA { return HOSEA; }
JOEL { return JOEL; }
AMOS { return AMOS; }
OBADIAH { return OBADIAH; }
JONAH { return JONAH; }
MICAH { return MICAH; }
NAHUM { return NAHUM; }
HABAKKUK { return HABAKKUK; }
ZEPHANIAH { return ZEPHANIAH; }
HAGGAI { return HAGGAI; }
ZECHARIAH { return ZECHARIAH; }
MALACHI { return MALACHI; }
MATTHEW { return MATTHEW; }
MARK { return MARK; }
LUKE { return LUKE; }
JOHN { return JOHN; }
ACTS { return ACTS; }
ROMANS { return ROMANS; }
I_CORINTHIANS { return I_CORINTHIANS; }
II_CORINTHIANS { return II_CORINTHIANS; }
GALATIANS { return GALATIANS; }
EPHESIANS { return EPHESIANS; }
PHILIPPIANS { return PHILIPPIANS; }
COLOSSIANS { return COLOSSIANS; }
I_THESSALONIANS { return I_THESSALONIANS; }
II_THESSALONIANS { return II_THESSALONIANS; }
I_TIMOTHY { return I_TIMOTHY; }
II_TIMOTHY { return II_TIMOTHY; }
TITUS { return TITUS; }
PHILEMON { return PHILEMON; }
HEBREWS { return HEBREWS; }
JAMES { return JAMES; }
I_PETER { return I_PETER; }
II_PETER { return II_PETER; }
I_JOHN { return I_JOHN; }
II_JOHN { return II_JOHN; }
III_JOHN { return III_JOHN; }
JUDE { return JUDE; }
REVELATION_OF_JOHN { return REVELATION_OF_JOHN; }

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
[a-z]*	{ yylval.strval = strdup(yytext); return AYLITERAL;}

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
[ \t\n]         /* white space */
.               { yyerror("mystery character '%c'", *yytext); }

%%
