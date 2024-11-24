%{
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>

#ifdef IN_BIBREF
#include "books-wrapper.h"
#include "fingerprint-wrapper.h"
extern const char* lookupVerse1(const char* book, const char* info, const char* verse);
#endif // IN_BIBREF

char *stmt_identifier;
char *nt_book;
char *nt_info;
char *ot_book;
char *ot_info;
char *ot_verse;
float difference = -1; // undefined

/* shortcut to concatenate a, " " and b, and put the result in c */
#define _CONCAT(a,b,c) \
          char* s=malloc(sizeof(char)*(strlen(a)+strlen(b)+2)); \
          strcpy(s,a); \
          strcat(s," "); \
          strcat(s,b); \
          c=s;
%}

%locations

%union {
	int intval;
	double floatval;
	char *strval;
}

%token <strval> NAME
%token <strval> STRING
%token <intval> INTNUM
%token <floatval> APPROXNUM
%token <strval> AYLITERAL
%token <strval> VERSE
%token <strval> VERSESTART
%token <strval> VERSEEND
%token RAWPOSITION
%token <strval> PERIOD

%type <strval> RAWPOSITION

%token STATEMENT;
%token CONNECTS;
%token WITH;
%token BASED;
%token ON;
%token INTRODUCTION;
%token A_Y;
%token FORM;
%token THAT;
%token DECLARES;
%token A;
%token QUOTATION;
%token AND;
%token ALSO;
%token IDENTIFIES;
%token THE;
%token SOURCE;
%token MOREOVER;
%token FRAGMENT;
%token LENGTH;
%token MATCHES;
%token DIFFERING;
%token BY;
%token VERBATIM;
%token PROVIDING;
%token AN;
%token OVERALL;
%token COVER;
%token OF;
%token NO;
%token EVIDENCE;

%token SBLGNT;
%token STATRESGNT;
%token LXX;

%token GENESIS;
%token EXODUS;
%token LEVITICUS;
%token NUMBERS;
%token DEUTERONOMY;
%token JOSHUA;
%token JUDGES;
%token RUTH;
%token I_SAMUEL;
%token II_SAMUEL;
%token I_KINGS;
%token II_KINGS;
%token I_CHRONICLES;
%token II_CHRONICLES;
%token EZRA;
%token NEHEMIAH;
%token ESTHER;
%token JOB;
%token PSALMS;
%token PROVERBS;
%token ECCLESIASTES;
%token SONG_OF_SOLOMON;
%token ISAIAH;
%token JEREMIAH;
%token LAMENTATIONS;
%token EZEKIEL;
%token DANIEL;
%token HOSEA;
%token JOEL;
%token AMOS;
%token OBADIAH;
%token JONAH;
%token MICAH;
%token NAHUM;
%token HABAKKUK;
%token ZEPHANIAH;
%token HAGGAI;
%token ZECHARIAH;
%token MALACHI;
%token MATTHEW;
%token MARK;
%token LUKE;
%token JOHN;
%token ACTS;
%token ROMANS;
%token I_CORINTHIANS;
%token II_CORINTHIANS;
%token GALATIANS;
%token EPHESIANS;
%token PHILIPPIANS;
%token COLOSSIANS;
%token I_THESSALONIANS;
%token II_THESSALONIANS;
%token I_TIMOTHY;
%token II_TIMOTHY;
%token TITUS;
%token PHILEMON;
%token HEBREWS;
%token JAMES;
%token I_PETER;
%token II_PETER;
%token I_JOHN;
%token II_JOHN;
%token III_JOHN;
%token JUDE;
%token REVELATION_OF_JOHN;

%start brst_stmt

%%

brst_stmt
    : STATEMENT opt_identifier CONNECTS nt_passage WITH ot_passages BASED ON stmt_basis opt_period {
      stmt_identifier = strdup($<strval>2);
      };

stmt_basis
    : introductions | introductions MOREOVER fragments | fragments | NO EVIDENCE;

opt_identifier
    : | NAME | AYLITERAL /* ugly workaround, https://stackoverflow.com/a/71275846/1044586 */;

nt_passage
    : nt_edition nt_book passage {
      check_nt_passage($<strval>1, $<strval>2, $<strval>3); };

nt_edition
    : SBLGNT | STATRESGNT ;

nt_book
    : MATTHEW | MARK | LUKE | JOHN | ACTS | ROMANS | I_CORINTHIANS | II_CORINTHIANS |
        GALATIANS | EPHESIANS | PHILIPPIANS | COLOSSIANS | I_THESSALONIANS | II_THESSALONIANS |
        I_TIMOTHY | II_TIMOTHY | TITUS | PHILEMON | HEBREWS | JAMES | I_PETER | II_PETER |
        I_JOHN | II_JOHN | III_JOHN | JUDE | REVELATION_OF_JOHN ;

ot_passages
    : ot_passage | ot_passage AND ot_passages;

ot_passage
    : ot_edition ot_book passage {
      check_ot_passage($<strval>1, $<strval>2, $<strval>3); };

ot_edition
    : LXX;

ot_book
    : GENESIS | EXODUS | LEVITICUS | NUMBERS | DEUTERONOMY | JOSHUA | JUDGES | RUTH |
        I_SAMUEL | II_SAMUEL | I_KINGS | II_KINGS | I_CHRONICLES | II_CHRONICLES |
        EZRA | NEHEMIAH | ESTHER | JOB | PSALMS | PROVERBS | ECCLESIASTES |
        SONG_OF_SOLOMON | ISAIAH | JEREMIAH | LAMENTATIONS | EZEKIEL | DANIEL | HOSEA |
        JOEL | AMOS | OBADIAH | JONAH | MICAH | NAHUM | HABAKKUK | ZEPHANIAH |
        HAGGAI | ZECHARIAH | MALACHI;

passage
    : verse opt_raw_position;

verse
    : VERSE
        | VERSE VERSE { _CONCAT($1,$2,$<strval>$) }
        | VERSESTART VERSE { _CONCAT($1,$2,$<strval>$) }
        | VERSESTART VERSEEND { _CONCAT($1,$2,$<strval>$) }
        | VERSE VERSEEND { _CONCAT($1,$2,$<strval>$) }
        ;

opt_raw_position
    : | RAWPOSITION { check_rawposition_length($1); };

introductions
    : introduction | introduction AND introductions;

introduction
    : INTRODUCTION passage A_Y FORM AYLITERAL opt_introduction_explanations {
          check_introduction_passage($<strval>2, $<strval>5); };

opt_introduction_explanations
    : | opt_that introduction_explanations;

opt_that
    : | THAT;

introduction_explanations
    : introduction_explanation | introduction_explanation ALSO introduction_explanations;

introduction_explanation
    : DECLARES A QUOTATION WITH STRING
        | IDENTIFIES THE SOURCE WITH STRING;

fragments
    : fragments_description
        PROVIDING AN OVERALL COVER OF APPROXNUM;

fragments_description
    : fragment | fragment AND fragments_description;

fragment
    : FRAGMENT passage A_Y FORM AYLITERAL
        MATCHES ot_passage A_Y FORM AYLITERAL
        difference_description {
        check_fragment($<strval>2, $<strval>5, $<strval>7, $<strval>10);
        };

difference_description
    : VERBATIM { difference = 0.0; } | DIFFERING BY APPROXNUM { difference = ($<floatval>3) / 100.0; } ;

opt_period
    : | PERIOD;

%%

void
check_rawposition_length(char *s, ...)
{
  extern yylineno;
  extern yycolumn;
  if (strstr(s, "length") == NULL) {
    fprintf(stdout, "%d,%d: warning: no length is given, consider adding it\n", yylineno, yycolumn);
    return;
  }
  int from, to, length;
  sscanf(s, "(%d-%d, length %d)", &from, &to, &length);
  if (to-from+1 != length) {
    fprintf(stdout, "%d,%d: error: inconsistent length: %d-%d+1!=%d\n", yylineno, yycolumn, to, from, length);
  } else {
    fprintf(stdout, "%d,%d: info: consistent length: %d-%d+1==%d\n", yylineno, yycolumn, to, from, length);
  }
}

void
check_nt_passage(char *book, char *info, char *verse)
{
  extern yylineno;
  extern yycolumn;
#ifdef IN_BIBREF
  addBibles1();
  char *l;
  l = lookupVerse1(info, book, verse);
  if (strstr(l, "error: ") != NULL) {
    fprintf(stdout, "%d,%d: %s\n", yylineno, yycolumn, l);
  } else {
    fprintf(stdout, "%d,%d: info: lookup1 %s %s %s = ", yylineno, yycolumn, book, info, verse);
    fprintf(stdout, "%s\n", l);
  }
  nt_info = strdup(info);
  nt_book = strdup(book);
  free(l);
#endif // IN_BIBREF
}

void
check_ot_passage(char *book, char *info, char *verse)
{
  extern yylineno;
  extern yycolumn;
#ifdef IN_BIBREF
  addBibles1();
  char *l;
  l = lookupVerse1(info, book, verse);
  if (strstr(l, "error: ") != NULL) {
    fprintf(stdout, "%d,%d: %s\n", yylineno, yycolumn, l);
  } else {
    fprintf(stdout, "%d,%d: info: lookup1 %s %s %s = ", yylineno, yycolumn, book, info, verse);
    fprintf(stdout, "%s\n", l);
  }
  ot_info = strdup(info);
  ot_book = strdup(book);
  ot_verse = strdup(verse);
  free(l);
#endif // IN_BIBREF
}

void
check_introduction_passage(char *passage, char *ay)
{
  extern yylineno;
  extern yycolumn;
#ifdef IN_BIBREF
  char *l;
  l = lookupVerse1(nt_info, nt_book, passage);
  if (strcmp(l, ay) == 0)
    fprintf(stdout, "%d,%d: info: introduction %s matches to a-y form\n", yylineno, yycolumn, passage);
  else
    fprintf(stdout, "%d,%d: error: introduction %s does not match to a-y form %s, it should be %s\n", yylineno, yycolumn, passage, ay, l);
#endif // IN_BIBREF
}

void
check_fragment(char *passage, char *ay_nt, char *ot_passage, char *ay_ot) {
  extern yylineno;
  extern yycolumn;
#ifdef IN_BIBREF
  char *l;
  l = lookupVerse1(nt_info, nt_book, passage);
  if (strcmp(l, ay_nt) == 0)
    fprintf(stdout, "%d,%d: info: NT fragment %s matches to a-y form\n", yylineno, yycolumn, passage);
  else
    fprintf(stdout, "%d,%d: error: NT fragment %s does not match to a-y form %s, it should be %s\n", yylineno, yycolumn, passage, ay_nt, l);
  l = lookupVerse1(ot_info, ot_book, ot_verse);
  if (strcmp(l, ay_ot) == 0)
    fprintf(stdout, "%d,%d: info: OT fragment %s matches to a-y form\n", yylineno, yycolumn, ot_passage);
  else
    fprintf(stdout, "%d,%d: error: OT fragment %s does not match to a-y form %s, it should be %s\n", yylineno, yycolumn, ot_passage, ay_ot, l);
  // fprintf(stdout, "%d,%d: debug: parsed ot_passage=%s ot_info=%s ot_book=%s ot_verse=%s ay_ot=%s diff=%f\n", yylineno, yycolumn, ot_passage, ot_info, ot_book, ot_verse, ay_ot, difference);
  double jd = jaccard_dist1(ay_nt, ay_ot);
#define EPS 0.0001
  if (fabs(jd-difference) <= EPS)
    fprintf(stdout, "%d,%d: info: fragments differ by %4.2f%%\n", yylineno, yycolumn, difference * 100.0);
  else
    fprintf(stdout, "%d,%d: error: fragments in reality differ by %4.2f%%\n", yylineno, yycolumn, jd * 100.0);
#endif // IN_BIBREF
}

void
yyerror(char *s, ...)
{
  extern yylineno;
  extern yycolumn;

  va_list ap;
  va_start(ap, s);

  fprintf(stdout, "%d,%d: error: ", yylineno, yycolumn);
  vfprintf(stdout, s, ap);
  fprintf(stdout, "\n");
}

typedef struct yy_buffer_state * YY_BUFFER_STATE;
extern int yyparse();
extern YY_BUFFER_STATE yy_scan_string(char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

int brst_scan_string(char *string) {
    YY_BUFFER_STATE buffer = yy_scan_string(string);
    yyparse();
    yy_delete_buffer(buffer);
    return 0;
}
