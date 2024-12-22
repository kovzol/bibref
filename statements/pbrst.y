%{
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>
#include <limits.h>
#include <stdbool.h>

#ifdef IN_BIBREF
#include "books-wrapper.h"
#include "fingerprint-wrapper.h"
#define YY_USER_INIT (addBibles1();)
#endif // IN_BIBREF

char *stmt_identifier;
char *nt_book;
char *nt_info;
char *ot_book;
char *ot_info;
char *ot_verse;
#define EPS 0.0001
#define MAX_SUBSTR_LENGTH 500
#define MAX_SUBSTRINGS 10
#define MAX_INTERVALS 20
#define MAX_BOOKNAME_LENGTH 30
#define MAX_INFONAME_LENGTH 30
#define MAX_INFOS 5
char introduction_substrings[MAX_SUBSTRINGS][MAX_SUBSTR_LENGTH + 1];
int intervals[MAX_INTERVALS][3]; // start, end, type
// where type is 0: NT headline, 1: NT fragment, 2: OT fragment, 3: NT introduction
int substrings = 0;
int iv_counter = 0;
int fragments_start = -1; // undefined
int nt_intros_start = -1;
float difference = -1; // undefined
char books_s[MAX_INTERVALS][MAX_BOOKNAME_LENGTH]; // Bible editions
char infos_s[MAX_INTERVALS][MAX_INFONAME_LENGTH]; // Bible books (in order of intervals)

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
    : DECLARES A QUOTATION WITH STRING { save_string_in_introduction($<strval>5); }
        | IDENTIFIES THE SOURCE WITH STRING { save_string_in_introduction($<strval>5); };

fragments
    : fragments_description
        PROVIDING AN OVERALL COVER OF APPROXNUM { check_cover($<floatval>7); };

fragments_description
    : fragment | fragment AND fragments_description;

fragment
    : FRAGMENT passage A_Y FORM AYLITERAL
        MATCHES ot_passage A_Y FORM AYLITERAL
        difference_description {
        check_fragment($<strval>2, $<strval>5, $<strval>10);
        };

difference_description
    : VERBATIM { difference = 0.0; } | DIFFERING BY APPROXNUM { difference = ($<floatval>3) / 100.0; } ;

opt_period
    : | PERIOD;

%%

void
check_rawposition_length(char *s)
{
  extern yylineno;
  extern yycolumn;
#ifdef IN_BIBREF
  int from, to, length=-1;
  if (strstr(s, "length") == NULL) {
    fprintf(stdout, "%d,%d: warning: no length is given, consider adding it\n", yylineno, yycolumn);
    sscanf(s, "(%d-%d)", &from, &to);
  } else {
    sscanf(s, "(%d-%d, length %d)", &from, &to, &length);
    if (to-from+1 != length) {
      fprintf(stdout, "%d,%d: error: inconsistent length: %d-%d+1!=%d\n", yylineno, yycolumn, to, from, length);
    } else {
      fprintf(stdout, "%d,%d: info: consistent length: %d-%d+1==%d\n", yylineno, yycolumn, to, from, length);
    }
  }
  intervals[iv_counter][0] = from;
  intervals[iv_counter][1] = to;
  intervals[iv_counter][2] = 0; // unclassified
  fprintf(stdout, "%d,%d: info: interval %d [%d,%d] stored\n", yylineno, yycolumn, iv_counter, from, to);
  iv_counter++;
#endif // IN_BIBREF
}

void
save_string_in_introduction(char *s)
{
  extern yylineno;
  extern yycolumn;
#ifdef IN_BIBREF
  char *l;
  l = greekToLatin1(s);
  strcpy(introduction_substrings[substrings++], l);
  fprintf(stdout, "%d,%d: info: found %s in input\n", yylineno, yycolumn, l);
  free(l);
#endif // IN_BIBREF
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
  intervals[iv_counter-1][2]=0; // NT (headline)
  fprintf(stdout, "%d,%d: info: interval %d is a headline NT passage\n", yylineno, yycolumn, iv_counter-1);
#endif // IN_BIBREF
}

void
check_ot_passage(char *book, char *info, char *verse)
{
  extern yylineno;
  extern yycolumn;
#ifdef IN_BIBREF
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
  intervals[iv_counter-1][2]=2; // OT
  fprintf(stdout, "%d,%d: info: interval %d is an OT passage\n", yylineno, yycolumn, iv_counter-1);
  strcpy(infos_s[iv_counter-1], ot_info);
  strcpy(books_s[iv_counter-1], ot_book);
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
    fprintf(stdout, "%d,%d: info: introduction %s matches to a-y form %s\n", yylineno, yycolumn, passage, ay);
  else
    fprintf(stdout, "%d,%d: error: introduction %s does not match to a-y form %s, it should be %s\n", yylineno, yycolumn, passage, ay, l);
  for (int i=0; i<substrings; i++) {
    char *s = introduction_substrings[i]; // first word of substring
    char *next;
    do {
      next = strchr(s, ',');
      if (next != NULL) {
        next[0] = '\0'; // split the comma separated string into C strings
        }
      if (strstr(ay, s) != NULL) {
        fprintf(stdout, "%d,%d: info: substring %s found\n", yylineno, yycolumn, s);
        }
      else {
       fprintf(stdout, "%d,%d: error: substring %s not found\n", yylineno, yycolumn, s);
       }
      s = next+1;
    } while (next != NULL);
  }
  substrings = 0; // reset, maybe there is another introduction
  intervals[iv_counter-1][2]=3; // NT (introduction)
  fprintf(stdout, "%d,%d: info: interval %d is an introductory NT passage\n", yylineno, yycolumn, iv_counter-1);
  if (nt_intros_start == -1) nt_intros_start = iv_counter-1;
#endif // IN_BIBREF
}

void
check_fragment(char *passage, char *ay_nt, char *ay_ot) {
  extern yylineno;
  extern yycolumn;
#ifdef IN_BIBREF
  char *ot_passage = malloc(strlen(ot_book) + 1 + strlen(ot_info) + 1 + strlen(ot_verse) + 1);
  strcpy(ot_passage, ot_book);
  strcat(ot_passage, " ");
  strcat(ot_passage, ot_info);
  strcat(ot_passage, " ");
  strcat(ot_passage, ot_verse);
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
  if (fabs(jd-difference) <= EPS)
    fprintf(stdout, "%d,%d: info: fragments differ by %4.2f%%\n", yylineno, yycolumn, difference * 100.0);
  else
    fprintf(stdout, "%d,%d: error: fragments in reality differ by %4.2f%%\n", yylineno, yycolumn, jd * 100.0);
  // Check uniqueness in OT if the quotation is verbatim:
  if (fabs(difference) <= EPS) {
    fprintf(stdout, "%d,%d: info: checking if verbatim quotation is unique in OT: ", yylineno, yycolumn);
#define MAX_FOUND 10
    int count = find1(l, ot_book, MAX_FOUND);
    fprintf(stdout, "(at least) %d occurrences\n", count);
    if (count>1) {
      fprintf(stdout, "%d,%d: warning: OT book reference is not unique\n", yylineno, yycolumn);
    }
  }

  free(ot_passage);
  intervals[iv_counter-2][2] = 1; // this is an NT fragment
  intervals[iv_counter-1][2] = 2; // this is an OT fragment
  if (fragments_start == -1) fragments_start = iv_counter-2;
#endif // IN_BIBREF
}

void check_cover(double cover) {
  extern yylineno;
  extern yycolumn;
#ifdef IN_BIBREF
  // Detecting intervals and the union of them:
  fprintf(stdout, "%d,%d: info: fragment intervals:", yylineno, yycolumn);
  int imin = INT_MAX, imax = 0; // union interval of fragments intervals
  for (int i=0; i<iv_counter; i++) {
    int ftype = intervals[i][2];
    if (ftype == 1) {
      int istart = intervals[i][0];
      int iend = intervals[i][1];
      fprintf(stdout, " [%d,%d]", istart, iend);
      if (imin > istart) imin = istart;
      if (imax < iend) imax = iend;
    }
  }
  fprintf(stdout, ", union: [%d,%d]\n", imin, imax);
  int union_length = imax-imin+1;
  char covering[union_length];
  for (int i=0; i<union_length; i++) covering[i] = 0; // resetting union
  // Cover check:
  for (int i=0; i<iv_counter; i++) {
    int ftype = intervals[i][2];
    if (ftype == 1) {
      int istart = intervals[i][0];
      int iend = intervals[i][1];
      for (int j=istart; j<=iend; j++) covering[j-imin]++;
    }
  }
  int covered = 0;
  for (int j=0; j<union_length; j++)
    if (covering[j]>0) covered++;
  double real_cover = (double)covered/union_length * 100.0;
  if (fabs(real_cover-cover) <= 100*EPS) {
    fprintf(stdout, "%d,%d: info: cover %4.2f%% is correct\n", yylineno, yycolumn, cover);
  } else {
    fprintf(stdout, "%d,%d: error: cover %4.2f%% is incorrect (union length: %d, covered: %d), in reality %4.2f%%\n",
      yylineno, yycolumn, cover, union_length, covered, real_cover);
  }
  // Check if any NT introductions overlap any fragments:
  bool overlap_error = false;
  for (int i=0; i<fragments_start; i++) {
    int itype = intervals[i][2];
    if (itype == 3) { // NT introduction
       for (int j=fragments_start; j<iv_counter; j++) {
         int ftype = intervals[j][2];
         if (ftype == 1) {
           int nt_intro_start = intervals[i][0];
           int nt_intro_end = intervals[i][1];
           int fstart = intervals[j][0];
           int fend = intervals[j][1];
           // Do they overlap?
           if (!(nt_intro_start > fend || nt_intro_end < fstart)) {
             fprintf(stdout, "%d,%d: error: NT introduction interval %d overlaps fragment interval %d\n",
               yylineno, yycolumn, i, j);
           overlap_error = true;
           }
         }
       }
    }
  }
  if (!overlap_error) {
    fprintf(stdout, "%d,%d: info: overlap check done\n", yylineno, yycolumn);
  }
  // Check if NT headline matches union:
  int nt_headline_start = intervals[0][0];
  int nt_headline_end = intervals[0][1];
  if (!(nt_headline_start == imin && nt_headline_end == imax)) {
    if (nt_headline_start <= imin || nt_headline_end >= imax) {
    fprintf(stdout, "%d,%d: warning: NT headline interval [%d,%d] contains NT fragments union [%d,%d] but they do not match\n",
      yylineno, yycolumn, nt_headline_start, nt_headline_end, imin, imax);
    }
    else {
      fprintf(stdout, "%d,%d: error: NT headline interval [%d,%d] does not contain NT fragments union [%d,%d]\n",
        yylineno, yycolumn, nt_headline_start, nt_headline_end, imin, imax);
    }
  } else {
    fprintf(stdout, "%d,%d: info: NT headline interval check done\n", yylineno, yycolumn);
  }
  // Check if OT headlines match OT unions:
  for (int i=1; i<nt_intros_start; i++) {
    fprintf(stdout, "%d,%d: info: OT headline %d %s %s interval check:",
      yylineno, yycolumn, i, books_s[i], infos_s[i]);
    int oimin=INT_MAX, oimax=0;
    // Create union for this OT headline:
    for (int j=fragments_start + 1; j<iv_counter; j++) {
      int ftype = intervals[j][2];
      if (ftype == 2) { // OT interval
        if (strcmp(books_s[i], books_s[j])==0 && strcmp(infos_s[i], infos_s[j])==0) {
          int oistart = intervals[j][0];
          int oiend = intervals[j][1];
          fprintf(stdout, " [%d,%d]", oistart, oiend);
          if (oimin > oistart) oimin = oistart;
          if (oimax < oiend) oimax = oiend;
        }
      }
    }
    fprintf(stdout, ", union: [%d,%d]\n", oimin, oimax);
    // Compare headline interval with the union:
    int ot_headline_start = intervals[i][0];
    int ot_headline_end = intervals[i][1];
    if (!(ot_headline_start == oimin && ot_headline_end == oimax)) {
      if (ot_headline_start <= oimin || ot_headline_end >= oimax) {
      fprintf(stdout, "%d,%d: warning: OT headline interval %d [%d,%d] contains OT fragments union [%d,%d] but they do not match\n",
        yylineno, yycolumn, i, ot_headline_start, ot_headline_end, oimin, oimax);
      }
      else {
        fprintf(stdout, "%d,%d: error: OT headline interval %d [%d,%d] does not contain OT fragments union [%d,%d]\n",
          yylineno, yycolumn, i, ot_headline_start, ot_headline_end, oimin, oimax);
      }
    } else {
      fprintf(stdout, "%d,%d: info: OT headline interval %d check done\n", yylineno, yycolumn, i);
    }
  } // end of for checking OT headlines
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
    // Reset data:
    yylex_destroy();
    substrings = 0;
    iv_counter = 0;
    fragments_start = -1;
    nt_intros_start = -1;
    difference = -1;
    // yydebug = 1;

    YY_BUFFER_STATE buffer = yy_scan_string(string);
    yyparse();
    yy_delete_buffer(buffer);
    return 0;
}
