%{
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>
#include <limits.h>
#include <stdbool.h>
#include <stdio.h>

#ifdef IN_BIBREF
#include "books-wrapper.h"
#include "fingerprint-wrapper.h"
#define YY_USER_INIT ( init_addbooks(); )
#endif // IN_BIBREF

char *stmt_identifier;
double stored_cover = 0.0;
char *nt_book;
char *nt_info;
char *nt_verse;
char *ot_book;
char *ot_info;
char *ot_verse;
#define EPS 0.0001
#define MAX_SUBSTR_LENGTH 500
#define MAX_SUBSTRINGS 10
#define MAX_INTERVALS 20
#define MAX_BOOKNAME_LENGTH 30
#define MAX_INFONAME_LENGTH 30
#define MAX_OT_BOOKS 5
#define MAX_BOOK_LENGTH 175000
char introduction_substrings[MAX_SUBSTRINGS][MAX_SUBSTR_LENGTH + 1];
int intervals[MAX_INTERVALS][3]; // start, end, type
double intervals_data[MAX_INTERVALS]; // stored info (e.g., difference of fragments, number of substrings)
#define NT_HEADLINE 0
#define NT_FRAGMENT 1
#define OT_PASSAGE 2
#define NT_INTRODUCTION 3
#define UNCLASSIFIED -1
// where type is 0: NT headline, 1: NT fragment, 2: OT fragment, 3: NT introduction, -1: unclassified
int substrings = 0;
int iv_counter = 0;
int fragments_start = -1; // undefined
int nt_intros_start = -1;
float difference = -1; // undefined

// TODO: Psalms could be considered as different books in the diagrams.
int covering[MAX_INTERVALS][MAX_BOOK_LENGTH];
int ot_books_n = 0;
int ot_coverings[MAX_OT_BOOKS][MAX_BOOK_LENGTH];
int oimins[MAX_OT_BOOKS];
int oimaxs[MAX_OT_BOOKS];
char ot_books[MAX_OT_BOOKS][MAX_BOOKNAME_LENGTH];
char ot_infos[MAX_OT_BOOKS][MAX_BOOKNAME_LENGTH];
char ot_verses[MAX_OT_BOOKS][MAX_BOOKNAME_LENGTH];
#define MAX_FRAGMENT_LENGTH 5000
char fragments[MAX_INTERVALS][MAX_FRAGMENT_LENGTH];

// TODO: Store the index only instead of the whole string:
char books_s[MAX_INTERVALS][MAX_BOOKNAME_LENGTH]; // Bible editions
char infos_s[MAX_INTERVALS][MAX_INFONAME_LENGTH]; // Bible books (in order of intervals)

// These must be stored fully (for the dump):
#define MAX_VERSE_LENGTH 30
char verses_s[MAX_INTERVALS][MAX_VERSE_LENGTH];
char declares[MAX_INTERVALS][MAX_SUBSTR_LENGTH];
char identifies[MAX_INTERVALS][MAX_SUBSTR_LENGTH];

bool unique_prep = false; // don't check unique occurrence (only if asked)
bool addbooks_done = false;
char *parseinfo = "";

int union_length, union_length_i;
int imin_i = INT_MAX, imax_i = 0; // union interval of fragments intervals, including introductions

bool no_evidence = false;
bool fatal = false;

// corrector options

int correct_raw = 0; // fix raw positions if possible
int correct_differ = 0; // fix differing percents if possible
int correct_cover = 0; // fix covering percents if possible
int correct_versification = 0; // fix versification related issues if possible
int show_dump = 0; // if requested, print internal dump in BRST format

#ifdef IN_BIBREF
void init_addbooks() {
  if (!addbooks_done) {
    addBibles1(); addbooks_done = true;
  }
}
#endif

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
%token UNIQUE;
%token IN;
%token OLD;
%token TESTAMENT;

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

%code provides {
char *mystrcat(char *a, char *b);
void add_parseinfo(char *s, ...);
int yylex (void);
int yylex_destroy();
void yyerror (char *s, ...);
void check_rawposition_length(char *s);
void save_string_in_introduction(char *s, int t);
void check_nt_passage(char *book, char *info, char *verse);
void check_ot_passage(char *book, char *info, char *verse);
void check_introduction_passage(char *passage, char *ay);
void check_cover(double cover);
void check_unique_prepare();
void check_fragment(char *passage, char *ay_nt, char *ay_ot);
double myatof(char *arr);
void create_diagram();
void create_dump();
void reset_data(int cr, int cd, int cc, int cv, int sd);
}

%%

brst_stmt
    : STATEMENT opt_identifier CONNECTS nt_passage WITH ot_passages BASED ON stmt_basis opt_period {
      stmt_identifier = strdup($<strval>2);
      };

stmt_basis
    : introductions | introductions MOREOVER fragments | fragments | NO EVIDENCE { no_evidence = true; };

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
    : DECLARES A QUOTATION WITH STRING { save_string_in_introduction($<strval>5, 0); }
        | IDENTIFIES THE SOURCE WITH STRING { save_string_in_introduction($<strval>5, 1); };

fragments
    : fragments_description
        PROVIDING AN OVERALL COVER OF APPROXNUM { check_cover($<floatval>7); };

fragments_description
    : fragment | fragment AND fragments_description;

fragment
    : FRAGMENT passage A_Y FORM AYLITERAL
        MATCHES ot_passage A_Y FORM AYLITERAL opt_unique
        difference_description {
        check_fragment($<strval>2, $<strval>5, $<strval>10);
        };

difference_description
    : VERBATIM { difference = 0.0; } | DIFFERING BY APPROXNUM { difference = ($<floatval>3) / 100.0; } ;

opt_unique
    : | UNIQUE IN OLD TESTAMENT { check_unique_prepare(); };

opt_period
    : | PERIOD;

%%

// https://stackoverflow.com/a/40188247/1044586
char *mystrcat(char *a, char *b) {
  char *p, *q, *rtn;
  rtn = q = malloc(strlen(a) + strlen(b) + 1);
  for (p = a; (*q = *p) != '\0'; ++p, ++q) {}
  for (p = b; (*q = *p) != '\0'; ++p, ++q) {}
  return rtn;
}

void add_parseinfo(char *s, ...) {
  va_list ap;
  va_start(ap, s);
#define MAX_PARSEINFO_LINE_LENGTH 16384
  char *line = malloc(MAX_PARSEINFO_LINE_LENGTH);
  vsprintf(line, s, ap); // create line
  if (yydebug == 1)
    printf("%s", line); // print line
  char *p1 = mystrcat(parseinfo, line); // store line
  free(parseinfo);
  parseinfo = p1;
  free(line);
  va_end(ap);
}

void
check_rawposition_length(char *s)
{
  extern int yylineno;
  extern int yycolumn;
#ifdef IN_BIBREF
  int from, to, length=-1;
  if (strstr(s, "length") == NULL) {
    add_parseinfo("%d,%d: warning: no length is given, consider adding it\n", yylineno, yycolumn);
    sscanf(s, "(%d-%d)", &from, &to);
  } else {
    sscanf(s, "(%d-%d, length %d)", &from, &to, &length);
    if (to-from+1 != length) {
      if (correct_raw == 1) {
        add_parseinfo("%d,%d: corrected: inconsistent length: %d-%d+1!=%d\n", yylineno, yycolumn, to, from, length);
      } else {
        add_parseinfo("%d,%d: error: correctable, inconsistent length: %d-%d+1!=%d\n", yylineno, yycolumn, to, from, length);
      }
    } else {
      add_parseinfo("%d,%d: info: consistent length: %d-%d+1==%d\n", yylineno, yycolumn, to, from, length);
    }
  }
  intervals[iv_counter][0] = from;
  intervals[iv_counter][1] = to;
  intervals[iv_counter][2] = UNCLASSIFIED; // unclassified
  add_parseinfo("%d,%d: debug: interval %d [%d,%d] stored\n", yylineno, yycolumn, iv_counter, from, to);
  iv_counter++;
#endif // IN_BIBREF
}

void
save_string_in_introduction(char *s, int t) // t == 0: declares, t == 1: identifies
{
  extern int yylineno;
  extern int yycolumn;
#ifdef IN_BIBREF
  char *l;
  l = greekToLatin1(s);
  strcpy(introduction_substrings[substrings++], l);
  if (t==0) strcpy(declares[iv_counter-1], s);
  if (t==1) strcpy(identifies[iv_counter-1], s);
  add_parseinfo("%d,%d: debug: found %s in input\n", yylineno, yycolumn, l);
  free(l);
#endif // IN_BIBREF
}


void
check_nt_passage(char *book, char *info, char *verse)
{
  extern int yylineno;
  extern int yycolumn;
#ifdef IN_BIBREF
  init_addbooks();
  char *l;
  bool err = false; // be optimistic
  // Get passage by lookup:
  l = lookupVerse1(info, book, verse);
  nt_info = strdup(info);
  nt_book = strdup(book);
  nt_verse = strdup(verse);
  if (strstr(l, "error: ") != NULL) {
    add_parseinfo("%d,%d: %s\n", yylineno, yycolumn, l);
    err = true;
    free(l);
    fatal = true;
    return; // this is fatal, because the other pieces of information won't override the badly formed passage
  } else {
    add_parseinfo("%d,%d: info: `lookup1 %s %s %s` = %s\n", yylineno, yycolumn, book, info, verse, l);
  }
  // Get passage as raw text:
  char *r;
  int length = intervals[iv_counter-1][1] - intervals[iv_counter-1][0] +1;
  r = getRaw1(info, book, intervals[iv_counter-1][0] - 1, length);
  if (strstr(r, "error: ") != NULL) {
    add_parseinfo("%d,%d: %s\n", yylineno, yycolumn, r);
    err = true;
  } else {
    add_parseinfo("%d,%d: info: `getraw %s %s %d %d` = %s\n", yylineno, yycolumn, book, info,
      intervals[iv_counter-1][0], length, r);
  }

  // Check if raw text matches with lookup's result:
  if (!err && strcmp(l, r)==0) {
    add_parseinfo("%d,%d: info: results of lookup and getraw match\n", yylineno, yycolumn);
    } else {
    // TODO: This is fixable, the position should be corrected by getting the passage position:
    if (correct_raw == 1) {
      int start = lookupVerseStart1(info, book, verse) + 1;
      intervals[iv_counter-1][0] = start;
      intervals[iv_counter-1][1] = start + strlen(l) - 1;
      add_parseinfo("%d,%d: corrected: results of lookup and getraw did not match\n", yylineno, yycolumn);
    } else {
        if (!err)
          add_parseinfo("%d,%d: error: correctable, results of lookup and getraw do not match\n", yylineno, yycolumn);
        else
          add_parseinfo("%d,%d: error: results of lookup and getraw do not match\n", yylineno, yycolumn);
      }
    }
  strcpy(fragments[iv_counter-1],l); // saved for the diagram (tooltip)
  free(l);
  free(r);
  intervals[iv_counter-1][2] = NT_HEADLINE; // NT (headline)
  // strcpy(infos_s[iv_counter-1], nt_info);
  // strcpy(books_s[iv_counter-1], nt_book);
  add_parseinfo("%d,%d: debug: interval %d %s %s is the headline NT passage\n", yylineno, yycolumn, iv_counter-1, nt_book, nt_info);
#endif // IN_BIBREF
}

int detect_ot_book(char *book, char *info) {
  for (int i=0; i<ot_books_n; i++) {
    if (strcmp(ot_books[i],ot_book)==0 && strcmp(ot_infos[i],ot_info)==0) { // This is not a new OT book.
      return i;
    }
  }
  return -1; // not found
}

// This is incomplete. Mostly those verses will be fixes that are present in the statement database. FIXME.
void fix_verse(char *info, int *c, int *v) {
  if (strcmp(info, "Psalms") == 0) {
    // Shifting the verse number by 1 (or 2):
    if ((*c)>2 && (*c)<150 && (*c)!=14 && (*c)!=16 && (*c)!=24 && (*c)!=32
      && (*c)!=78 && (*c)!=82 && (*c)!=91 && (*c)!=94 && (*c)!=95 && (*c)!=104
      && (*c)!=109 && (*c)!=110 && (*c)!=112 && (*c)!=114 && (*c)!=116 && (*c)!=117 && (*c)!=118 && (*c)!=132) {
      (*v)++;
      if ((*c)==51) (*v)++;
      }
    // Shifting the chapter number by 1 (or 2):
    if ((*c)>10) {
      if ((*c)!=115 && !((*c)==116 && (*v)<10)) (*c)--;
      else (*c)-=2;
      }
    // Now (*c) contains the new chapter.
    // Some verse numbers need to have further adjustments:
    if ((*c)==115) (*v)-=9;
    if ((*c)==113) (*v)+=8;
    } // Psalms

  if (strcmp(info, "Exodus") == 0) {
    if ((*c)==20) {
      if ((*v)==13) (*v)=15;
      else if ((*v)==14) (*v)=13;
      else if ((*v)==15) (*v)=14;
      }
    if ((*c)==21) {
      if ((*v)==38) {
        (*c)++;
        (*v)=1;
        }
      else if ((*v)==16) (*v)=17;
      else if ((*v)==17) (*v)=16;
      }
    if ((*c)==22) (*v)--;
    } // Exodus
  if (strcmp(info, "Jeremiah") == 0) {
    if ((*c)==31) (*c)=38;
    } // Jeremiah
  if (strcmp(info, "Isaiah") == 0) {
    if ((*c)==9 && (*v)==1) {
      (*c)--;
      (*v)=23;
      }
    if ((*c)==9 && (*v)>=2) (*v)--;
    } // Isaiah
  if (strcmp(info, "Hosea") == 0) {
    if ((*c)==1 && (*v)==10) {
      (*c)++;
      (*v)=1;
      }
    } // Hosea
  if (strcmp(info, "Jonah") == 0) {
    if ((*c)==1 && (*v)==17) {
      (*c)++;
      (*v)=1;
      }
    } // Jonah
  if (strcmp(info, "Joel") == 0) {
    if ((*c)==2 && (*v)>=28) {
      (*c)++;
      (*v)-=27;
      }
    } // Joel
  if (strcmp(info, "Micah") == 0) {
    if ((*c)==5 && (*v)>=2) {
      (*v)--;
      }
    } // Micah
  if (strcmp(info, "Deuteronomy") == 0) {
    if ((*c)==29) (*v)-=1;
    } // Deuteronomy
  }

char *versification_to_lxx(char *book, char *info, char *verse) {
  if (strcmp(book, "LXX") != 0) return NULL;
  int c, c2, v1, v2, o1, o2, n, f;
  f = 1;
  n = sscanf(verse, "%d:%d+%d %d:%d-%d", &c, &v1, &o1, &c2, &v2, &o2);
  if (n<6) {
    f = 2;
    n = sscanf(verse, "%d:%d %d:%d-%d", &c, &v1, &c2, &v2, &o2);
    if (n<5) {
      f = 3;
      n = sscanf(verse, "%d:%d+%d %d:%d", &c, &v1, &o1, &c2, &v2);
      if (n<5) {
        f = 4;
        n = sscanf(verse, "%d:%d %d:%d", &c, &v1, &c2, &v2);
        if (n<4) {
          f = 5;
          v2 = -1; // unused
          n = sscanf(verse, "%d:%d", &c, &v1);
          if (n<2) {
            f = 0; // unsuccessful
            }
          }
        }
      }
    }
  if (f==0) return NULL;

  fix_verse(info, &c, &v1);
  if (v2>=1) fix_verse(info, &c2, &v2);

  char *ret = malloc(MAX_VERSE_LENGTH + 1);
  if (f==1) sprintf(ret, "%d:%d+%d %d:%d-%d", c, v1, o1, c2, v2, o2);
  if (f==2) sprintf(ret, "%d:%d %d:%d-%d", c, v1, c2, v2, o2);
  if (f==3) sprintf(ret, "%d:%d+%d %d:%d", c, v1, o1, c2, v2);
  if (f==4) sprintf(ret, "%d:%d %d:%d", c, v1, c2, v2);
  if (f==5) sprintf(ret, "%d:%d", c, v1);
  return ret;
}

void
check_ot_passage(char *book, char *info, char *verse)
{
  extern int yylineno;
  extern int yycolumn;
#ifdef IN_BIBREF
  char *l;
  bool err = false; // be optimistic
  char *verse_fixed = NULL;
  if (correct_versification == 1) {
    add_parseinfo("%d,%d: debug: attempt to correct verse in %s %s %s\n", yylineno, yycolumn, book, info, verse);
    verse_fixed = versification_to_lxx(book, info, verse);
  }
  if (verse_fixed == NULL) {
    ot_verse = strdup(verse);
    }
  else {
    ot_verse = strdup(verse_fixed);
    add_parseinfo("%d,%d: corrected: verse in %s %s %s changed to %s\n", yylineno, yycolumn, book, info, verse, verse_fixed);
    }
  l = lookupVerse1(info, book, ot_verse);
  if (strstr(l, "error: ") != NULL) {
    add_parseinfo("%d,%d: %s\n", yylineno, yycolumn, l);
    free(l);
    fatal = true;
    return; // this is fatal
  } else {
    add_parseinfo("%d,%d: info: `lookup1 %s %s %s` = %s\n", yylineno, yycolumn, book, info, ot_verse, l);
  }
  ot_info = strdup(info);
  ot_book = strdup(book);
  // Get passage as raw text:
  char *r;
  int length = intervals[iv_counter-1][1] - intervals[iv_counter-1][0] +1;
  r = getRaw1(ot_info, ot_book, intervals[iv_counter-1][0] - 1, length);
  if (strstr(r, "error: ") != NULL) {
    add_parseinfo("%d,%d: %s\n", yylineno, yycolumn, r);
    err = true;
  } else {
    add_parseinfo("%d,%d: info: `getraw %s %s %d %d` = %s\n", yylineno, yycolumn, ot_book, ot_info,
      intervals[iv_counter-1][0], length, r);
  }

  // Check if raw text matches with lookup's result:
  if (!err && strcmp(l, r)==0) {
    add_parseinfo("%d,%d: info: results of lookup and getraw match\n", yylineno, yycolumn);
    } else {
    if (correct_raw == 1) {
      int start = lookupVerseStart1(ot_info, ot_book, ot_verse) + 1;
      intervals[iv_counter-1][0] = start;
      intervals[iv_counter-1][1] = start + strlen(l) - 1;
      add_parseinfo("%d,%d: corrected: results of lookup and getraw did not match\n", yylineno, yycolumn);
      } else {
        if (!err)
          add_parseinfo("%d,%d: error: correctable, results of lookup and getraw do not match\n", yylineno, yycolumn);
        else
          add_parseinfo("%d,%d: error: results of lookup and getraw do not match\n", yylineno, yycolumn);
        }
    }
  strcpy(fragments[iv_counter-1],l); // saved for the diagram (tooltip)
  free(l);
  free(r);

  intervals[iv_counter-1][2] = OT_PASSAGE;
  add_parseinfo("%d,%d: debug: interval %d is an OT passage\n", yylineno, yycolumn, iv_counter-1);

  if (detect_ot_book(ot_book, ot_info) == -1) { // Register this OT book as another entry.
    if (fragments_start>0) // this should be fixable, TODO
      add_parseinfo("%d,%d: error: OT book %s %s is not defined as a headline\n", yylineno, yycolumn, ot_book, ot_info);
    strcpy(ot_books[ot_books_n], ot_book);
    strcpy(ot_infos[ot_books_n], ot_info);
    strcpy(ot_verses[ot_books_n], ot_verse); // FIXME: For long books like Isaiah, this may be inconvenient.
    ot_books_n++;
    add_parseinfo("%d,%d: debug: OT book %s %s is registered as #%d\n", yylineno, yycolumn, ot_book, ot_info, ot_books_n-1);
  }

  strcpy(infos_s[iv_counter-1], ot_info);
  strcpy(books_s[iv_counter-1], ot_book);
  strcpy(verses_s[iv_counter-1], ot_verse); // for the dump
#endif // IN_BIBREF
}

void
check_introduction_passage(char *passage, char *ay)
{
  extern int yylineno;
  extern int yycolumn;
#ifdef IN_BIBREF
  char *l;
  bool err = false; // be optimistic
  l = lookupVerse1(nt_info, nt_book, passage);
  if (strstr(l, "error: ") != NULL) {
    add_parseinfo("%d,%d: %s\n", yylineno, yycolumn, l);
    err = true;
    strcpy(l, ay); // workaround, maybe the ay information is correct
  } else {
    add_parseinfo("%d,%d: info: `lookup1 %s %s %s` = %s\n", yylineno, yycolumn, nt_book, nt_info, passage, l);
  }

  if (strcmp(l, ay) == 0)
    add_parseinfo("%d,%d: info: introduction %s matches to a-y form %s\n", yylineno, yycolumn, passage, ay);
  else {
    add_parseinfo("%d,%d: error: introduction %s does not match to a-y form %s, it should be %s\n", yylineno, yycolumn, passage, ay, l);
    }
  // Get passage as raw text:
  char *r;
  int length = intervals[iv_counter-1][1] - intervals[iv_counter-1][0] +1;
  r = getRaw1(nt_info, nt_book, intervals[iv_counter-1][0] - 1, length);
  if (strstr(r, "error: ") != NULL) {
    add_parseinfo("%d,%d: %s\n", yylineno, yycolumn, r);
    err = true;
  } else {
    add_parseinfo("%d,%d: info: `getraw %s %s %d %d` = %s\n", yylineno, yycolumn, nt_book, nt_info,
      intervals[iv_counter-1][0], length, r);
  }
  // strcpy(infos_s[iv_counter-1], nt_info);
  // strcpy(books_s[iv_counter-1], nt_book);
  strcpy(verses_s[iv_counter-1], passage); // for the dump

  // Check if raw text matches with lookup's result:
  if (!err && strcmp(l, r)==0) {
    add_parseinfo("%d,%d: info: results of lookup and getraw match\n", yylineno, yycolumn);
    } else { // try to fix the incorrect raw position:
    if (correct_raw == 1) {
      int start = lookupVerseStart1(nt_info, nt_book, passage) + 1;
      intervals[iv_counter-1][0] = start;
      intervals[iv_counter-1][1] = start + strlen(l) - 1;
      add_parseinfo("%d,%d: corrected: results of lookup and getraw did not match\n", yylineno, yycolumn);
    } else {
      if (!err)
        add_parseinfo("%d,%d: error: correctable, results of lookup and getraw do not match\n", yylineno, yycolumn);
      else
        add_parseinfo("%d,%d: error: results of lookup and getraw do not match\n", yylineno, yycolumn);
      }
    }
  strcpy(fragments[iv_counter-1],l); // saved for the diagram (tooltip)
  free(l);
  free(r);

  for (int i=0; i<substrings; i++) {
    char *s = introduction_substrings[i]; // first word of substring
    char *next;
    do {
      next = strchr(s, ',');
      if (next != NULL) {
        next[0] = '\0'; // split the comma separated string into C strings
        }
      if (strstr(ay, s) != NULL) {
        add_parseinfo("%d,%d: info: substring %s found in introduction\n", yylineno, yycolumn, s);
        }
      else {
       add_parseinfo("%d,%d: error: substring %s not found in introduction\n", yylineno, yycolumn, s);
       }
      s = next+1;
    } while (next != NULL);
  }
  intervals_data[iv_counter-1] = substrings; // save data for the diagram
  substrings = 0; // reset, maybe there is another introduction
  intervals[iv_counter-1][2] = NT_INTRODUCTION; // NT (introduction)
  add_parseinfo("%d,%d: debug: interval %d is an introductory NT passage\n", yylineno, yycolumn, iv_counter-1);
  if (nt_intros_start == -1) nt_intros_start = iv_counter-1;
#endif // IN_BIBREF
}

void
check_fragment(char *passage, char *ay_nt, char *ay_ot) {
  extern int yylineno;
  extern int yycolumn;
#ifdef IN_BIBREF
  // At this point, we have not yet checked if the raw position of the NT part matches the verse.
  // This is a technical issue, so we need to handle the situation here.
  if (ot_book == NULL || ot_info == NULL || ot_verse == NULL) {
    add_parseinfo("%d,%d: debug: cannot identify OT passage, skipping fragment check for %s\n", yylineno, yycolumn, passage);
    fatal = true;
    return;
    }
  char *ot_passage = malloc(strlen(ot_book) + 1 + strlen(ot_info) + 1 + strlen(ot_verse) + 1);
  strcpy(ot_passage, ot_book);
  strcat(ot_passage, " ");
  strcat(ot_passage, ot_info);
  strcat(ot_passage, " ");
  strcat(ot_passage, ot_verse);
  char *ln;
  bool err = false; // be optimistic
  ln = lookupVerse1(nt_info, nt_book, passage);
  if (strstr(ln, "error: ") != NULL) {
    add_parseinfo("%d,%d: %s\n", yylineno, yycolumn, ln);
    err = true;
    strcpy(ln, ay_nt); // workaround, maybe the ay information is correct
  } else {
    add_parseinfo("%d,%d: info: `lookup1 %s %s %s` = %s\n", yylineno, yycolumn, nt_book, nt_info, passage, ln);
  }
  if (strcmp(ln, ay_nt) == 0)
    add_parseinfo("%d,%d: info: NT fragment %s matches to a-y form\n", yylineno, yycolumn, passage);
  else
    add_parseinfo("%d,%d: error: NT fragment %s does not match to a-y form %s, it should be %s\n", yylineno, yycolumn, passage, ay_nt, ln);
  strcpy(fragments[iv_counter-2], ln); // for the diagram

  // Check the raw position.
  char *r;
  int length = intervals[iv_counter-2][1] - intervals[iv_counter-2][0] +1;
  r = getRaw1(nt_info, nt_book, intervals[iv_counter-2][0] - 1, length);
  if (strstr(r, "error: ") != NULL) {
    add_parseinfo("%d,%d: %s\n", yylineno, yycolumn, r);
    err = true;
  } else {
    add_parseinfo("%d,%d: info: `getraw %s %s %d %d` = %s\n", yylineno, yycolumn, nt_book, nt_info,
      intervals[iv_counter-2][0], length, r);
  }
  // Check if raw text matches with lookup's result:
  if (!err && strcmp(ln, r)==0) {
    add_parseinfo("%d,%d: info: results of lookup and getraw match\n", yylineno, yycolumn);
    } else { // try to fix the incorrect raw position:
    if (correct_raw == 1) {
      int start = lookupVerseStart1(nt_info, nt_book, passage) + 1;
      intervals[iv_counter-2][0] = start;
      intervals[iv_counter-2][1] = start + strlen(ln) - 1;
      add_parseinfo("%d,%d: corrected: results of lookup and getraw did not match\n", yylineno, yycolumn);
    } else {
      if (!err)
        add_parseinfo("%d,%d: error: correctable, results of lookup and getraw do not match\n", yylineno, yycolumn);
      else
        add_parseinfo("%d,%d: error: results of lookup and getraw do not match\n", yylineno, yycolumn);
    }
  }
  free(r);
  // End of checking/fixing raw position.

  char *lo;
  lo = lookupVerse1(ot_info, ot_book, ot_verse);
  if (strstr(lo, "error: ") != NULL) {
    add_parseinfo("%d,%d: %s\n", yylineno, yycolumn, lo);
    strcpy(lo, ay_ot); // workaround, maybe the ay information is correct
  } else {
    add_parseinfo("%d,%d: info: `lookup1 %s %s %s` = %s\n", yylineno, yycolumn, ot_book, ot_info, ot_verse, lo);
  }
  if (strcmp(lo, ay_ot) == 0)
    add_parseinfo("%d,%d: info: OT fragment %s matches to a-y form\n", yylineno, yycolumn, ot_passage);
  else
    add_parseinfo("%d,%d: error: OT fragment %s does not match to a-y form %s, it should be %s\n", yylineno, yycolumn, ot_passage, ay_ot, lo);
  // add_parseinfo("%d,%d: debug: parsed ot_passage=%s ot_info=%s ot_book=%s ot_verse=%s ay_ot=%s diff=%f\n", yylineno, yycolumn, ot_passage, ot_info, ot_book, ot_verse, ay_ot, difference);
  double jd = jaccard_dist1(ln, lo);
  if (fabs(jd-difference) <= EPS)
    add_parseinfo("%d,%d: info: fragments differ by %4.2f%%\n", yylineno, yycolumn, difference * 100.0);
  else {
    if (correct_differ == 1) {
      add_parseinfo("%d,%d: corrected: fragments in reality differed by %4.2f%%\n", yylineno, yycolumn, jd * 100.0);
      difference = jd; // correction
    } else
      add_parseinfo("%d,%d: error: correctable, fragments in reality differ by %4.2f%%\n", yylineno, yycolumn, jd * 100.0);
    }
  // Check uniqueness in OT:
  add_parseinfo("%d,%d: info: checking if OT passage is unique in OT: ", yylineno, yycolumn);
#define MAX_FOUND 10
  int count = find1(lo, ot_book, MAX_FOUND);
  if (count == MAX_FOUND)
    add_parseinfo("no, at least %d occurrences\n", count);
  else if (count>1)
    add_parseinfo("no, %d occurrences\n", count);
  else
    add_parseinfo("yes\n");
  if (count==1 && !unique_prep) {
    add_parseinfo("%d,%d: warning: OT passage is unique, consider mentioning it\n", yylineno, yycolumn);
  }
  if (count>1 && unique_prep) {
    add_parseinfo("%d,%d: error: OT passage is not unique\n", yylineno, yycolumn);
  }
  unique_prep = false;
  free(ln);
  free(lo);
  free(ot_passage);
  intervals[iv_counter-2][2] = NT_FRAGMENT; // this is an NT fragment
  intervals[iv_counter-1][2] = OT_PASSAGE; // this is an OT fragment
  strcpy(verses_s[iv_counter-2],passage); // for the dump

  intervals_data[iv_counter-2] = difference; // save data for the diagram
  intervals_data[iv_counter-1] = count; // save data for the diagram (TODO: consider showing this only if unique_prep)
  if (fragments_start == -1) fragments_start = iv_counter-2;
#endif // IN_BIBREF
}

void check_unique_prepare() {
  extern int yylineno;
  extern int yycolumn;
#ifdef IN_BIBREF
  unique_prep = true;
#endif // IN_BIBREF
}

void check_cover(double cover) {
  extern int yylineno;
  extern int yycolumn;
#ifdef IN_BIBREF
  if (ot_book == NULL || ot_info == NULL || ot_verse == NULL) {
    add_parseinfo("%d,%d: debug: cannot identify OT passage, skipping cover check %4.2f%%\n", yylineno, yycolumn, cover);
    fatal = true;
    return;
    }
  // Detecting intervals and the union of them:
  int imin = INT_MAX, imax = 0; // union interval of fragments intervals
  add_parseinfo("%d,%d: debug: NT fragment intervals:", yylineno, yycolumn);
  for (int i=0; i<iv_counter; i++) {
    int ftype = intervals[i][2];
    if (ftype == NT_FRAGMENT) {
      int istart = intervals[i][0];
      int iend = intervals[i][1];
      add_parseinfo(" [%d,%d]", istart, iend);
      if (imin > istart) imin = istart;
      if (imax < iend) imax = iend;
    }
  }
  union_length = imax-imin+1;
  add_parseinfo(", union: [%d,%d]\n", imin, imax);
  // Extend the union by considering the NT introductions as well (it's important for the diagram):
  imin_i = imin, imax_i = imax;
  add_parseinfo("%d,%d: debug: NT introduction intervals:", yylineno, yycolumn);
  for (int i=0; i<iv_counter; i++) {
    int ftype = intervals[i][2];
    if (ftype == NT_INTRODUCTION) {
      int istart = intervals[i][0];
      int iend = intervals[i][1];
      add_parseinfo(" [%d,%d]", istart, iend);
      if (imin_i > istart) imin_i = istart;
      if (imax_i < iend) imax_i = iend;
    }
  }
  union_length_i = imax_i-imin_i+1;
  add_parseinfo(", union: [%d,%d]\n", imin_i, imax_i);

  // Check covering, first prepare a big array:
  for (int i=0; i<union_length_i; i++)
    for (int j=0; j<iv_counter; j++)
      covering[j][i] = 0; // resetting union (for all OT books)
  // Cover check:
  for (int i=0; i<iv_counter; i++) {
    int ftype = intervals[i][2];
    if (ftype == NT_FRAGMENT || ftype == NT_INTRODUCTION) {
      int istart = intervals[i][0];
      int iend = intervals[i][1];
      int iv = i+1; // register the OT quotation part if it's a fragment
      if (ftype == NT_INTRODUCTION)
        iv = i; // otherwise, register the introduction entry
      for (int j=istart; j<=iend; j++) covering[iv][j-imin_i] = 1;
    }
  }
  int covered = 0;
  for (int i=imin-imin_i; i<union_length_i; i++) {
    bool letter_covered = false;
    for (int j=fragments_start+1; j<iv_counter && !letter_covered; j++) { // do not count NT introduction coverings
      if (covering[j][i]>0) {
        covered++;
        letter_covered = true;
      }
    }
  }
  double real_cover = (double)covered/union_length * 100.0;
  stored_cover = cover;
  if (fabs(real_cover-cover) <= 100*EPS) {
    add_parseinfo("%d,%d: info: cover %4.2f%% is correct\n", yylineno, yycolumn, cover);
  } else {
    if (correct_cover == 1) {
      add_parseinfo("%d,%d: corrected: cover %4.2f%% was incorrect (union length: %d, covered: %d), in reality %4.2f%%\n",
        yylineno, yycolumn, cover, union_length, covered, real_cover);
      stored_cover = real_cover;
    } else
      add_parseinfo("%d,%d: error: correctable, cover %4.2f%% is incorrect (union length: %d, covered: %d), in reality %4.2f%%\n",
        yylineno, yycolumn, cover, union_length, covered, real_cover);
  }
  // Check if any NT introductions overlap any other introductions or fragments:
  bool overlap_error = false;
  for (int i=0; i<fragments_start; i++) {
    int itype = intervals[i][2];
    if (itype == NT_INTRODUCTION) { // NT introduction
       for (int j=i+1; j<iv_counter; j++) {
         int ftype = intervals[j][2];
         if (ftype == NT_FRAGMENT || ftype == NT_INTRODUCTION) {
           int nt_intro_start = intervals[i][0];
           int nt_intro_end = intervals[i][1];
           int fstart = intervals[j][0];
           int fend = intervals[j][1];
           // Do they overlap?
           if (!(nt_intro_start > fend || nt_intro_end < fstart)) {
             if (ftype == NT_FRAGMENT)
               add_parseinfo("%d,%d: error: NT introduction interval %d overlaps fragment interval %d\n",
                 yylineno, yycolumn, i, j);
             if (ftype == NT_INTRODUCTION)
               add_parseinfo("%d,%d: error: NT introduction intervals %d and %d overlap each other\n",
                 yylineno, yycolumn, i, j);
           overlap_error = true;
           }
         }
       }
    }
  }
  if (!overlap_error) {
    add_parseinfo("%d,%d: info: NT overlap check done\n", yylineno, yycolumn);
  }
  // Check if NT headline matches union:
  int nt_headline_start = intervals[0][0];
  int nt_headline_end = intervals[0][1];
  if (!(nt_headline_start == imin && nt_headline_end == imax)) {
    if (nt_headline_start <= imin && nt_headline_end >= imax) {
    add_parseinfo("%d,%d: warning: NT headline interval [%d,%d] contains NT fragments union [%d,%d] but they do not match\n",
      yylineno, yycolumn, nt_headline_start, nt_headline_end, imin, imax);
    }
    else {
      add_parseinfo("%d,%d: error: NT headline interval [%d,%d] does not contain NT fragments union [%d,%d]\n",
        yylineno, yycolumn, nt_headline_start, nt_headline_end, imin, imax);
    }
  } else {
    add_parseinfo("%d,%d: info: NT headline interval check done\n", yylineno, yycolumn);
  }
  // Check if OT headlines match OT unions:
  for (int i=1; i<nt_intros_start; i++) {
    add_parseinfo("%d,%d: debug: OT headline %d %s %s interval check:",
      yylineno, yycolumn, i, books_s[i], infos_s[i]);
    int oimin=INT_MAX, oimax=0;
    // Create union for this OT headline:
    for (int j=fragments_start + 1; j<iv_counter; j++) {
      int ftype = intervals[j][2];
      if (ftype == OT_PASSAGE) { // OT interval
        if (strcmp(books_s[i], books_s[j])==0 && strcmp(infos_s[i], infos_s[j])==0) {
          int oistart = intervals[j][0];
          int oiend = intervals[j][1];
          add_parseinfo(" [%d,%d]", oistart, oiend);
          if (oimin > oistart) oimin = oistart;
          if (oimax < oiend) oimax = oiend;
        }
      }
    }
    if (oimin == INT_MAX) {
      add_parseinfo(" none\n");
      add_parseinfo("%d,%d: error: OT headline %d %s %s has no corresponding fragments\n", yylineno, yycolumn,
        i, books_s[i], infos_s[i]);
      return; // avoid segfault later
    }
    add_parseinfo(", union: [%d,%d]\n", oimin, oimax);
    add_parseinfo("%d,%d: info: OT headline %d %s %s has at least corresponding fragment\n", yylineno, yycolumn,
        i, books_s[i], infos_s[i]);
    // Compare headline interval with the union:
    int ot_headline_start = intervals[i][0];
    int ot_headline_end = intervals[i][1];
    if (!(ot_headline_start == oimin && ot_headline_end == oimax)) {
      if (ot_headline_start <= oimin || ot_headline_end >= oimax) {
      add_parseinfo("%d,%d: warning: OT headline interval %d [%d,%d] contains OT fragments union [%d,%d] but they do not match\n",
        yylineno, yycolumn, i, ot_headline_start, ot_headline_end, oimin, oimax);
      }
      else {
        add_parseinfo("%d,%d: error: OT headline interval %d [%d,%d] does not contain OT fragments union [%d,%d]\n",
          yylineno, yycolumn, i, ot_headline_start, ot_headline_end, oimin, oimax);
      }
    } else {
      add_parseinfo("%d,%d: info: OT headline interval %d check done\n", yylineno, yycolumn, i);
    }
    // Register fragments for the OT books:
    oimins[i-1] = oimin, oimaxs[i-1] = oimax;
    int ounion_length = oimax-oimin+1;
    for (int j=0; j<ounion_length; j++) {
      ot_coverings[i-1][j] = 0; // reset all letters
      }
    bool ot_overlaps = false;
    for (int j=fragments_start + 1; j<iv_counter; j++) { // register each fragment...
      int ftype = intervals[j][2];
      // If this is an OT interval and it belongs to the current OT headline...
      if (ftype == OT_PASSAGE && strcmp(books_s[i], books_s[j])==0 && strcmp(infos_s[i], infos_s[j])==0) {
        bool ot_overlap = false;
        int ot_overlap_i = 0;
        for (int k=intervals[j][0]; k<=intervals[j][1]; k++) {
          int pos = k-oimin;
          ot_overlap_i = ot_coverings[i-1][pos];
          // add_parseinfo("%d,%d: debug: check OT interval %d, pos=%d, k=%d, oimin=%d, ot_overlap_i=%d, j=%d\n",
          //   yylineno, yycolumn, i, pos, k, oimin, ot_overlap_i, j);
          if (ot_overlap_i != 0 && ot_overlap_i != j) {
            ot_overlap = true;
            ot_overlaps = true;
          } else
            ot_coverings[i-1][pos] = j;
          }
        if (ot_overlap) {
          add_parseinfo("%d,%d: error: OT intervals %d and %d overlap\n",
            yylineno, yycolumn, ot_overlap_i, j);
        }
      }
    }
    if (!ot_overlaps)
      add_parseinfo("%d,%d: info: OT interval check for OT headline %d done\n",
            yylineno, yycolumn, i);

  } // end of for checking OT headlines
#endif // IN_BIBREF
}

void
yyerror(char *s, ...)
{
  extern int yylineno;
  extern int yycolumn;

  va_list ap;
  va_start(ap, s);

  // create and store line
  char *line = malloc(MAX_PARSEINFO_LINE_LENGTH);
  sprintf(line, "%d,%d: error: ", yylineno, yycolumn);
  parseinfo = mystrcat(parseinfo, line);
  vsprintf(line, s, ap);
  parseinfo = mystrcat(parseinfo, line);
  sprintf(line, "\n");
  parseinfo = mystrcat(parseinfo, line);

  // print line
  // fprintf(stdout, "%d,%d: error: ", yylineno, yycolumn);
  // vfprintf(stdout, s, ap);
  // fprintf(stdout, "\n");

  va_end(ap);
}

// Taken from https://stackoverflow.com/a/67521458/1044586
double myatof(char *arr)
{
  double val = 0;
  int afterdot=0;
  double scale=1;
  int neg = 0; 

  if (*arr == '-') {
    arr++;
    neg = 1;
  }
  while (*arr) {
    if (afterdot) {
      scale = scale/10;
      val = val + (*arr-'0')*scale;
    } else {
      if (*arr == '.') 
    afterdot++;
      else
    val = val * 10.0 + (*arr - '0');
    }
    arr++;
  }
  if(neg) return -val;
  else    return  val;
}

#define MAX_CODE_SIZE 16384
char D[MAX_CODE_SIZE]; // diagram or dump as text
void create_diagram() {
  if (no_evidence) return;
  strcpy(D, "");
  strcat(D, "digraph {\n");
  strcat(D, " nodesep=0.1;\n"); // a lower number can shorten the edges
  strcat(D, " node [shape=box,color=\"#8080ff\",style=filled,height=0.4,width=0.4,fontsize=14];\n");
#define MAX_BLOCKS 100
  int nt_blocks[MAX_BLOCKS][2]; // copies from the coverings, positions and length are stored
  int nt_blocks_n = 0;
  int prev_pos = 0;
  // Detect blocks (identical vertical columns in covering[]):
  for (int i=1; i<union_length_i; i++) {
    bool col_identical = true;
    for (int j=0; j<iv_counter && col_identical; j++) {
      if (covering[j][i-1] != covering[j][i]) {
        col_identical = false;
        nt_blocks[nt_blocks_n][0] = prev_pos;
        nt_blocks[nt_blocks_n][1] = i-prev_pos;
        prev_pos = i;
        nt_blocks_n++;
      }
    }
  }
  nt_blocks[nt_blocks_n][0] = prev_pos;
  nt_blocks[nt_blocks_n][1] = union_length_i-prev_pos;
  nt_blocks_n++;
#define UNCOVERED 0
#define FRAGMENT 1
#define INTRODUCTION 2
#define MAX_INT_BUFSIZE 12
  char intbuffer[MAX_INT_BUFSIZE];

  // OT blocks:
  int ot_blocks[ot_books_n][MAX_BLOCKS][2]; // copies from the coverings, positions and length are stored
  int ot_blocks_ns[ot_books_n];
  for (int ob=0; ob<ot_books_n; ob++) {
    ot_blocks_ns[ob] = 0;
    int prev_pos = 0;
    // Detect blocks:
    int ounion_length = oimaxs[ob]-oimins[ob]+1;
    for (int i=1; i<ounion_length; i++) {
      bool identical = true;
      if (ot_coverings[ob][i-1] != ot_coverings[ob][i]) {
        identical = false;
        ot_blocks[ob][ot_blocks_ns[ob]][0] = prev_pos;
        ot_blocks[ob][ot_blocks_ns[ob]][1] = i-prev_pos;
        prev_pos = i;
        ot_blocks_ns[ob]++;
        }
      }
    ot_blocks[ob][ot_blocks_ns[ob]][0] = prev_pos;
    ot_blocks[ob][ot_blocks_ns[ob]][1] = ounion_length-prev_pos;
    ot_blocks_ns[ob]++;
  }
  // Collecting data from OT blocks:
  for (int ob=0; ob<ot_books_n; ob++) {
    strcat(D, " subgraph cluster_OT");
    sprintf(intbuffer, "%d", ob+1); // OT headline number
    strcat(D, intbuffer);
    strcat(D, " {\n");
    strcat(D, "  tooltip=\" \"; style=filled; color=transparent; fillcolor=\"#ffff80:white\";\n");
    strcat(D, "  edge [arrowhead=none,minlen=0,tooltip=\" \"];\n");
    strcat(D, "  otlabel");
    strcat(D, intbuffer); // re-use OT headline number to make this node unique
    strcat(D, " [label=\"");
    // strcat(D, ot_books[ob]);
    // strcat(D, " ");
    strcat(D, ot_infos[ob]);
    strcat(D, " ");
    // Remove verse after first space:
    char *v = strchr(ot_verses[ob], ' ');
    if (v != NULL)
      v[0] = '\0';
    strcat(D, ot_verses[ob]);
    if (v != NULL)
      v[0] = ' '; // ...then put back!
    strcat(D, "\",color=transparent,tooltip=\" \"];\n");
    int uid=0; // this is a dummy unique number for unused blocks
    for (int i=0; i<ot_blocks_ns[ob]; i++) {
      add_parseinfo("diagram: debug: OT headline %d block %d begins at %d (rawpos %d), length %d",
        ob+1, i, ot_blocks[ob][i][0], ot_blocks[ob][i][0] + oimins[ob], ot_blocks[ob][i][1]);

      int covering_col = ot_blocks[ob][i][0];
      int fragment = ot_coverings[ob][covering_col];
      // Create graphviz node:
      if (fragment == 0) {
        strcat(D, "  u");
        sprintf(intbuffer, "%d", ob+1);
        strcat(D, intbuffer);
        strcat(D, "_"); // separator
        sprintf(intbuffer, "%d", uid++);
        strcat(D, intbuffer);
      } else { // fragment != 0
        strcat(D, "  i");
        sprintf(intbuffer, "%d", fragment); // interval number
        strcat(D, intbuffer);
      }
      strcat(D, " [label=");
      sprintf(intbuffer, "%d", ot_blocks[ob][i][1]); // length
      strcat(D, intbuffer);
      strcat(D, ",fillcolor=");
      if (fragment != 0) { // this OT block is used in the NT passage somewhere
        add_parseinfo(" interval %d", fragment);
        strcat(D, "green,fontcolor=");
        if (fabs(intervals_data[fragment]-1)<EPS) // this is a unique OT fragment
          strcat(D, "gold");
        else
          strcat(D, "white");
        strcat(D, ",tooltip=\"");
        strcat(D, fragments[fragment]);
        strcat(D, "\"");
      } else {
        add_parseinfo(" unused");
        strcat(D, "white,color=\"#ccccff\",tooltip=\" \"");
      }
      strcat(D, "];\n"); // Finish graphviz node.
      add_parseinfo("\n");
    }
    // Connect the OT nodes in graphviz:
    strcat(D, "  ");
    uid = 0; // restart numbering
    for (int i=0; i<ot_blocks_ns[ob]; ++i) {
      int covering_col = ot_blocks[ob][i][0];
      int fragment = ot_coverings[ob][covering_col];
      if (i>0) strcat(D, "->");
      if (fragment == 0) {
        strcat(D, "u");
        sprintf(intbuffer, "%d", ob+1);
        strcat(D, intbuffer);
        strcat(D, "_"); // separator
        sprintf(intbuffer, "%d", uid++);
        strcat(D, intbuffer);
      } else { // fragment != 0
        strcat(D, "i");
        sprintf(intbuffer, "%d", fragment); // interval number
        strcat(D, intbuffer);
      }
    }
    strcat(D, ";\n");
    // Ensure that the otlabel precedes the first OT node:
    if (ot_blocks_ns[ob]>0) {
      int covering_col = ot_blocks[ob][0][0]; // TODO: not elegant, merge with previous section
      int fragment = ot_coverings[ob][covering_col];
      strcat(D, "  otlabel");
      sprintf(intbuffer, "%d", ob+1); // OT headline number
      strcat(D, intbuffer);
      strcat(D, "->");
      if (fragment == 0) {
        strcat(D, "u");
        sprintf(intbuffer, "%d", ob+1);
        strcat(D, intbuffer);
        strcat(D, "_0");
      } else { // fragment != 0
        strcat(D, "i");
        sprintf(intbuffer, "%d", fragment); // interval number
        strcat(D, intbuffer);
      }
      strcat(D, " [style=invis];\n");
    }
    strcat(D, " }\n"); // Finish subgraph.
  }

#define MAX_GRAPHVIZ_REFERENCES_SIZE 8192
  char refs[MAX_GRAPHVIZ_REFERENCES_SIZE]; // references
  bool pd_printed[MAX_INTERVALS-1]; // only entries over fragments_start will be used, TODO
  for (int i=1; i<iv_counter; i++) pd_printed[i-1] = false;
  strcpy(refs, "");
  strcat(D, " subgraph cluster_NT {\n");
  strcat(D, "  tooltip=\" \"; style=filled; color=transparent; fillcolor=\"#80ffff:white\";\n");
  strcat(D, "  edge [arrowhead=none,minlen=0,tooltip=\" \"];\n");
  strcat(D, "  ntlabel [label=\"");
  // strcat(D, nt_book);
  // strcat(D, " ");
  strcat(D, nt_info);
  strcat(D, " ");
  char *v = strchr(nt_verse, ' ');
  if (v != NULL)
    v[0] = '\0';
  strcat(D, nt_verse);
  if (v != NULL)
    v[0] = ' '; // ...then put back!
  strcat(D, "\",color=transparent,tooltip=\" \"];\n");
  // Collecting data from NT blocks:
  for (int i=0; i<nt_blocks_n; ++i) {
    add_parseinfo("diagram: debug: NT block %d begins at %d (rawpos %d), length %d, refers to",
      i, nt_blocks[i][0], nt_blocks[i][0] + imin_i, nt_blocks[i][1]);
    // Create graphviz node:
    strcat(D, "  nt");
    sprintf(intbuffer, "%d", i); // NT block number
    strcat(D, intbuffer);
    strcat(D, " [label=");

    int count_refs = 0;
    int covering_col = nt_blocks[i][0];
    int nodetype = 0;
    bool show_length = false;
    int intro_declarations = 0;
    char *intro_tooltip = NULL; // this will be defined later by pointing to an introductory text
    for (int j=0; j<iv_counter; j++) {
      int fragment = covering[j][covering_col];
      if (fragment != 0) { // this NT block refers to somewhere in OT (or it's an introduction)
        count_refs++;
        if (j>=fragments_start) { // it's a fragment
          add_parseinfo(" interval %d (%s %s)", j, books_s[j], infos_s[j]);
          if (count_refs==1) { // put this block only once, even if there are references to multiple fragments in it
            sprintf(intbuffer, "%d", nt_blocks[i][1]); // length
            strcat(D, intbuffer);
            strcat(D, ",tooltip=\"");
            strcat(D, fragments[j-1]);
            strcat(D, "\"");
            // Compute green lightness, based on difference 0..1 (127: darkest, 255: lightest)
            int lightness = 127 + ((int)(round(intervals_data[j-1]*128)));
            sprintf(intbuffer, "%2x", lightness); // "g" component from rgb
            strcat(D, ",fillcolor=\"#00");
            strcat(D, intbuffer);
            strcat(D, "00\",fontcolor=white];\n");
          }
          // Create graphviz edge between NT and OT blocks:
          strcat(refs, " nt");
          sprintf(intbuffer, "%d", i); // NT block number
          strcat(refs, intbuffer);
          strcat(refs, "->");
          strcat(refs, "i");
          sprintf(intbuffer, "%d", j); // OT interval number (fragment)
          strcat(refs, intbuffer);
          strcat(refs, " [arrowhead=vee,tooltip=\" \",");
          if (intervals_data[j-1]>EPS && !pd_printed[j-1]) { // non-verbatim match; percentual data is printed only once
            strcat(refs, "headlabel=\"");
            sprintf(intbuffer, "%d", ((int)(round(intervals_data[j-1]*100))));
            strcat(refs, intbuffer);
            strcat(refs, "%\",fontcolor=red,labeldistance=3,fontsize=12,headtooltip=\" \",");
            pd_printed[j-1]=true;
          }
          // constraint=false: do not count this edge when computing the positions of the edges:
          strcat(refs, "constraint=0,color=green];\n");
          nodetype = FRAGMENT;
        }
        else { // it's an introduction
          add_parseinfo(" interval %d (NT introduction)", j);
          nodetype = INTRODUCTION;
          int intro_start_raw = imin_i + nt_blocks[i][0]; // raw position of the beginning of this intro block
          int nt_headline_start_raw = intervals[0][0]; // raw position of the beginning of NT headline
          if (intro_start_raw >= nt_headline_start_raw) show_length = true;
          intro_declarations += intervals_data[j]; // compute the number of substrings given for this introduction
          intro_tooltip = fragments[j];
        }
      } else { // it's uncovered (similar situation to the introduction, consider unifying them, TODO)
        int start_raw = imin_i + nt_blocks[i][0]; // raw position of the beginning of this block
        int nt_headline_start_raw = intervals[0][0]; // raw position of the beginning of NT headline
        if (start_raw >= nt_headline_start_raw) show_length = true;
      }
    }
    if (nodetype == UNCOVERED) { // this NT block is surely an uncovered part by OT
      add_parseinfo(" uncovered");
      sprintf(intbuffer, "%d", nt_blocks[i][1]); // show block length
      strcat(D, intbuffer);
      if (!show_length) strcat(D, ",fontcolor=\"#dddddd\"");
      strcat(D, ",fillcolor=white,color=\"#ccccff\",tooltip=\" \"];\n");
    }
    if (nodetype == INTRODUCTION) {
      sprintf(intbuffer, "%d", nt_blocks[i][1]); // show block length
      strcat(D, intbuffer);
      if (!show_length) strcat(D, ",fontcolor=\"#dddddd\"");
      strcat(D, ",fillcolor=\"#");
      if (intro_declarations>EPS)
        strcat(D, "9999ff");
      else
        strcat(D, "ccccff");
      strcat(D, "\",tooltip=\"");
      if (intro_tooltip != NULL)
        strcat(D, intro_tooltip);
      else
        strcat(D, " "); // empty (this should not happen)
      strcat(D, "\"];\n");


    }
    add_parseinfo("\n");
  }
  // Connect the NT nodes in graphviz:
  strcat(D, "  ");
  for (int i=0; i<nt_blocks_n; ++i) {
    if (i>0) strcat(D, "->");
    strcat(D, "nt");
    sprintf(intbuffer, "%d", i); // NT block number
    strcat(D, intbuffer);
  }
  strcat(D, ";\n");
  // Ensure that the ntlabel precedes the first NT node:
  if (nt_blocks_n>0) {
    strcat(D, "  ntlabel->nt0 [style=invis];\n");
  }

  strcat(D, " }\n"); // Finish subgraph.
  strcat(D, refs); // Add references (outside the subgraphs).
  // Set up hierarchy between NT headline and OT headlines with invisible edges:
  for (int i=0; i<ot_books_n; i++) {
    strcat(D, " ntlabel->otlabel");
    sprintf(intbuffer, "%d", i+1);
    strcat(D, intbuffer);
    strcat(D, " [style=invis];\n");
    for (int j=i+1; j<ot_books_n; j++) {
    // Set up hierarchy between OT headlines, too:
      strcat(D, " otlabel");
      sprintf(intbuffer, "%d", j+1);
      strcat(D, intbuffer);
      strcat(D, "->otlabel");
      sprintf(intbuffer, "%d", i+1);
      strcat(D, intbuffer);
      strcat(D, " [style=invis];\n");
    }
  }

  strcat(D, "}"); // Finish digraph.
  add_parseinfo("diagram: graphviz: start\n%s\n"
    "diagram: graphviz: end\n", D);
}

void strcat_interval(char *str, int a, int b) {
#define MAX_INTERVAL_STRING 50
  char interval[MAX_INTERVAL_STRING];
  sprintf(interval, " (%d-%d, length %d)", a, b, b-a+1);
  strcat(str, interval);
}

void strcat_percent(char *str, double p) {
#define MAX_PERCENT_STRING 15
  char percent[MAX_PERCENT_STRING];
  sprintf(percent, " %4.2f%%", p*100.0);
  strcat(str, percent);
}

void strcat_passage(char *str, char *book, char *info, char *verse) {
  strcat(str, book);
  strcat(str, " ");
  strcat(str, info);
  strcat(str, " ");
  strcat(str, verse);
}

void create_dump() {
  if (fatal) return; // on a fatal error, we avoid dumping since the data structure may be inconsistent
  strcpy(D, "");
  strcat(D, "Statement ");
  if (stmt_identifier != NULL) {
    strcat(D, stmt_identifier);
    strcat(D, " ");
    }
  strcat(D, "connects\n ");
  strcat_passage(D, nt_book, nt_info, nt_verse);
  strcat_interval(D, intervals[0][0], intervals[0][1]);
  strcat(D, " with\n");
  int iv=1;
  if (no_evidence)
    nt_intros_start = iv_counter; // maybe put this to an earlier point
  for (; iv<nt_intros_start; iv++) {
    strcat(D, " ");
    strcat_passage(D, books_s[iv], infos_s[iv], verses_s[iv]);
    strcat_interval(D, intervals[iv][0], intervals[iv][1]);
    if (iv<nt_intros_start-1)
      strcat(D, " and");
    else
      strcat(D, " based on");
    strcat(D, "\n");
  }
  if (no_evidence) {
    strcat(D, "  no evidence.");
  } else {
  for (; iv<fragments_start; iv++) {
    strcat(D, "  introduction ");
    strcat(D, verses_s[iv]);
    strcat_interval(D, intervals[iv][0], intervals[iv][1]);
    strcat(D, " a-y form ");
    strcat(D, fragments[iv]);
    int infos = 0;
    if (strlen(declares[iv])>0) {
      strcat(D, " that\n   declares a quotation with ");
      strcat(D, declares[iv]);
      infos++;
      }
    if (strlen(identifies[iv])>0) {
      if (infos>0)
        strcat(D, " also\n");
      else
        strcat(D, " that\n");
      strcat(D, "   identifies the source with ");
      strcat(D, identifies[iv]);
      infos++;
      }
    if (iv<fragments_start-1)
      strcat(D, " and"); // there will be another introduction
    else
      strcat(D, " moreover"); // there will be no further introductions, fragments will come now
    strcat(D, "\n");
    }
  for (; iv<iv_counter; iv++) {
    strcat(D, "  fragment ");
    strcat(D, verses_s[iv]);
    strcat_interval(D, intervals[iv][0], intervals[iv][1]);
    strcat(D, " a-y form ");
    strcat(D, fragments[iv]);
    strcat(D, "\n");
    iv++;
    strcat(D, "   matches ");
    strcat_passage(D, books_s[iv], infos_s[iv], verses_s[iv]);
    strcat_interval(D, intervals[iv][0], intervals[iv][1]);
    strcat(D, " a-y form ");
    strcat(D, fragments[iv]);
    strcat(D, "\n");
    if (intervals_data[iv] == 1) // count
      strcat(D, "    unique in Old Testament\n");
    double difference = intervals_data[iv-1];
    if (fabs(difference) <= EPS)
      strcat(D, "    verbatim");
    else {
      strcat(D, "    differing by");
      strcat_percent(D, difference);
    }
    if (iv<iv_counter-1)
      strcat(D, " and"); // there will be another fragment
    strcat(D, "\n");
    }
  strcat(D, "  providing an overall cover of");
  strcat_percent(D, stored_cover/100);
  strcat(D, ".");
  } // else (there is evidence)
  add_parseinfo("dump: brst: start\n%s\n"
    "dump: brst: end\n", D);
}

void reset_data(int cr, int cd, int cc, int cv, int sd) { // important if a previous run was already performed
    extern int yycolumn;
    addbooks_done = true; // we assume it was already called
    yycolumn = 0;
    yylex_destroy();
    substrings = 0;
    iv_counter = 0;
    fragments_start = -1;
    nt_intros_start = -1;
    difference = -1;
    parseinfo = malloc(1);
    strcpy(parseinfo, "");
    ot_books_n = 0;
    union_length = 0;
    union_length_i = 0;
    imin_i = INT_MAX, imax_i = 0;
    unique_prep = false;
    no_evidence = false;
    fatal = false;
    correct_raw = cr;
    correct_differ = cd;
    correct_cover = cc;
    correct_versification = cv;
    show_dump = sd;
    // yydebug = 1;

    for (int i=0; i<MAX_INTERVALS; i++) {
      intervals[i][0] = 0;
      intervals[i][1] = 0;
      intervals[i][2] = 0;
      intervals_data[i] = 0;
    }
    for (int i=0; i<MAX_OT_BOOKS; i++) {
      for (int j=0; j<MAX_BOOK_LENGTH; j++) {
        ot_coverings[i][j] = 0;
      }
    }
}

typedef struct yy_buffer_state * YY_BUFFER_STATE;
extern int yyparse();
extern YY_BUFFER_STATE yy_scan_string(char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

char* brst_scan_string(char *string, int cr, int cd, int cc, int cv, int sd) {
    reset_data(cr, cd, cc, cv, sd);
    YY_BUFFER_STATE buffer = yy_scan_string(string);
    yyparse();
    yy_delete_buffer(buffer);
    if (strstr(parseinfo, ": error: ") == NULL)
      create_diagram();
    if (sd == 1)
      create_dump();
    return parseinfo;
}
