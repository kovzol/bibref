%option noyywrap nodefault yylineno case-insensitive
%{
#include "pbrst.tab.h"
#include <stdarg.h>
#include <string.h>

void yyerror(char *s, ...);
double myatof(char *arr);

int yycolumn = 1;
#define YY_USER_ACTION \
    yylloc.first_line = yylloc.last_line = yylineno; \
    yylloc.first_column = yylloc.last_column; \
    yylloc.last_column = yycolumn + yyleng - 1; \
    yycolumn += yyleng;
#define DUPTEXT strdup(yytext)
%}

WS      [ \t]*
DIGIT   [0-9]
NUM     {DIGIT}+
ID      [A-Za-z][A-Za-z0-9_,\-\+]*

%%

  /* keywords */
STATEMENT { return STATEMENT; }
CONNECTS { return CONNECTS; }
WITH { return WITH; }
BASED { return BASED; }
ON { return ON; }
INTRODUCTION { return INTRODUCTION; }
A-Z { return A_Z; }
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
UNIQUE { return UNIQUE; }
IN { return IN; }
OLD { return OLD; }
TESTAMENT { return TESTAMENT; }

SBLGNT { yylval.strval = DUPTEXT; return SBLGNT; }
STATRESGNT { yylval.strval = DUPTEXT; return STATRESGNT; }
LXX { yylval.strval = DUPTEXT; return LXX; }

GENESIS { yylval.strval = DUPTEXT; return GENESIS; }
EXODUS { yylval.strval = DUPTEXT; return EXODUS; }
LEVITICUS { yylval.strval = DUPTEXT; return LEVITICUS; }
NUMBERS { yylval.strval = DUPTEXT; return NUMBERS; }
DEUTERONOMY { yylval.strval = DUPTEXT; return DEUTERONOMY; }
JOSHUA { yylval.strval = DUPTEXT; return JOSHUA; }
JUDGES { yylval.strval = DUPTEXT; return JUDGES; }
RUTH { yylval.strval = DUPTEXT; return RUTH; }
I_SAMUEL { yylval.strval = DUPTEXT; return I_SAMUEL; }
II_SAMUEL { yylval.strval = DUPTEXT; return II_SAMUEL; }
I_KINGS { yylval.strval = DUPTEXT; return I_KINGS; }
II_KINGS { yylval.strval = DUPTEXT; return II_KINGS; }
I_CHRONICLES { yylval.strval = DUPTEXT; return I_CHRONICLES; }
II_CHRONICLES { yylval.strval = DUPTEXT; return II_CHRONICLES; }
EZRA { yylval.strval = DUPTEXT; return EZRA; }
NEHEMIAH { yylval.strval = DUPTEXT; return NEHEMIAH; }
ESTHER { yylval.strval = DUPTEXT; return ESTHER; }
JOB { yylval.strval = DUPTEXT; return JOB; }
PSALMS { yylval.strval = DUPTEXT; return PSALMS; }
PROVERBS { yylval.strval = DUPTEXT; return PROVERBS; }
ECCLESIASTES { yylval.strval = DUPTEXT; return ECCLESIASTES; }
SONG_OF_SOLOMON { yylval.strval = DUPTEXT; return SONG_OF_SOLOMON; }
ISAIAH { yylval.strval = DUPTEXT; return ISAIAH; }
JEREMIAH { yylval.strval = DUPTEXT; return JEREMIAH; }
LAMENTATIONS { yylval.strval = DUPTEXT; return LAMENTATIONS; }
EZEKIEL { yylval.strval = DUPTEXT; return EZEKIEL; }
DANIEL { yylval.strval = DUPTEXT; return DANIEL; }
HOSEA { yylval.strval = DUPTEXT; return HOSEA; }
JOEL { yylval.strval = DUPTEXT; return JOEL; }
AMOS { yylval.strval = DUPTEXT; return AMOS; }
OBADIAH { yylval.strval = DUPTEXT; return OBADIAH; }
JONAH { yylval.strval = DUPTEXT; return JONAH; }
MICAH { yylval.strval = DUPTEXT; return MICAH; }
NAHUM { yylval.strval = DUPTEXT; return NAHUM; }
HABAKKUK { yylval.strval = DUPTEXT; return HABAKKUK; }
ZEPHANIAH { yylval.strval = DUPTEXT; return ZEPHANIAH; }
HAGGAI { yylval.strval = DUPTEXT; return HAGGAI; }
ZECHARIAH { yylval.strval = DUPTEXT; return ZECHARIAH; }
MALACHI { yylval.strval = DUPTEXT; return MALACHI; }
MATTHEW { yylval.strval = DUPTEXT; return MATTHEW; }
MARK { yylval.strval = DUPTEXT; return MARK; }
LUKE { yylval.strval = DUPTEXT; return LUKE; }
JOHN { yylval.strval = DUPTEXT; return JOHN; }
ACTS { yylval.strval = DUPTEXT; return ACTS; }
ROMANS { yylval.strval = DUPTEXT; return ROMANS; }
I_CORINTHIANS { yylval.strval = DUPTEXT; return I_CORINTHIANS; }
II_CORINTHIANS { yylval.strval = DUPTEXT; return II_CORINTHIANS; }
GALATIANS { yylval.strval = DUPTEXT; return GALATIANS; }
EPHESIANS { yylval.strval = DUPTEXT; return EPHESIANS; }
PHILIPPIANS { yylval.strval = DUPTEXT; return PHILIPPIANS; }
COLOSSIANS { yylval.strval = DUPTEXT; return COLOSSIANS; }
I_THESSALONIANS { yylval.strval = DUPTEXT; return I_THESSALONIANS; }
II_THESSALONIANS { yylval.strval = DUPTEXT; return II_THESSALONIANS; }
I_TIMOTHY { yylval.strval = DUPTEXT; return I_TIMOTHY; }
II_TIMOTHY { yylval.strval = DUPTEXT; return II_TIMOTHY; }
TITUS { yylval.strval = DUPTEXT; return TITUS; }
PHILEMON { yylval.strval = DUPTEXT; return PHILEMON; }
HEBREWS { yylval.strval = DUPTEXT; return HEBREWS; }
JAMES { yylval.strval = DUPTEXT; return JAMES; }
I_PETER { yylval.strval = DUPTEXT; return I_PETER; }
II_PETER { yylval.strval = DUPTEXT; return II_PETER; }
I_JOHN { yylval.strval = DUPTEXT; return I_JOHN; }
II_JOHN { yylval.strval = DUPTEXT; return II_JOHN; }
III_JOHN { yylval.strval = DUPTEXT; return III_JOHN; }
JUDE { yylval.strval = DUPTEXT; return JUDE; }
REVELATION_OF_JOHN { yylval.strval = DUPTEXT; return REVELATION_OF_JOHN; }

"." { return PERIOD; }

  /* numbers */
{NUM}	{ yylval.intval = atoi(yytext);
                  return INTNUM; }

{NUM}"."{DIGIT}*"%" |
"."{NUM}"%"	{ yylval.strval = DUPTEXT;
                  yylval.strval[yyleng-1] = 0;
                  yylval.floatval = myatof(yylval.strval);
                  return APPROXNUM; }

  /* strings */
'(\\.|''|[^'\n])*'	|
\"(\\.|\"\"|[^"\n])*\"  { yylval.strval = DUPTEXT; return STRING; }

'(\\.|[^'\n])*$	        { yyerror("Unterminated string %s E21", yytext); }
\"(\\.|[^"\n])*$	{ yyerror("Unterminated string %s E21", yytext); }

  /* a-z literals, change q to z */
[a-z]+	{ yylval.strval = replace_char(DUPTEXT, 'q', 'z'); return AZLITERAL;}

  /* name */
{ID}	{ yylval.strval = DUPTEXT;
                          return NAME; }

  /* comments */
#.*		;

  /* verses */
{NUM}:{NUM} { yylval.strval = DUPTEXT; return VERSE; }
{NUM}:{NUM}[+]{NUM} { yylval.strval = DUPTEXT; return VERSESTART; }
{NUM}:{NUM}[-]{NUM} { yylval.strval = DUPTEXT; return VERSEEND; }

  /* raw positions */
\({WS}{NUM}-{NUM}({WS},{WS}length{WS}{NUM})?{WS}\) { yylval.strval = DUPTEXT; return RAWPOSITION; }

  /* everything else */
[ \t]         /* white space */ { }
[\n]            { yycolumn = 1; }
[\x80-\xFF]+    { yyerror("non-identifiable UTF-8 character sequence E20"); }
.               { yyerror("non-identifiable character '%c' E20", *yytext); }

%%
 