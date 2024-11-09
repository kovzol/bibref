%{
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>

void yyerror(char *s, ...);
void emit(char *s, ...);
void check_rawposition_length(char *s, ...);
%}

%union {
	int intval;
	double floatval;
	char *strval;
}

/* names and literal values */

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
    : STATEMENT opt_identifier CONNECTS nt_passage WITH ot_passages BASED ON stmt_basis opt_period;

stmt_basis
    : introductions | introductions MOREOVER fragments | fragments | NO EVIDENCE;

opt_identifier
    : | NAME;

nt_passage
    : nt_edition nt_book passage;

nt_edition
    : SBLGNT | STATRESGNT;

nt_book
    : MATTHEW | MARK | LUKE | JOHN | ACTS | ROMANS | I_CORINTHIANS | II_CORINTHIANS |
        GALATIANS | EPHESIANS | PHILIPPIANS | COLOSSIANS | I_THESSALONIANS | II_THESSALONIANS |
        I_TIMOTHY | II_TIMOTHY | TITUS | PHILEMON | HEBREWS | JAMES | I_PETER | II_PETER |
        I_JOHN | II_JOHN | III_JOHN | JUDE | REVELATION_OF_JOHN;

ot_passages
    : ot_passage | ot_passage AND ot_passages;

ot_passage
    : ot_edition ot_book passage;

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
        | VERSE VERSE
        | VERSESTART VERSE
        | VERSESTART VERSEEND
        | VERSE VERSEEND

opt_raw_position
    : | RAWPOSITION { check_rawposition_length($1); };

introductions
    : introduction | introduction AND introductions;

introduction
    : INTRODUCTION passage A_Y FORM AYLITERAL opt_introduction_explanations;

opt_introduction_explanations
    : | opt_that introduction_explanations;

opt_that
    : | THAT;

introduction_explanations
    : introduction_explanation | introduction_explanation AND introduction_explanations;

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
        difference_description;

difference_description
    : VERBATIM | DIFFERING BY APPROXNUM;

opt_period
    : | PERIOD;

%%

void
check_rawposition_length(char *s, ...)
{
  extern yylineno;
  if (strstr(s, "length") == NULL) {
    fprintf(stdout, "%d: warning: no length is given, consider adding it\n", yylineno);
    return;
  }
  int from, to, length;
  sscanf(s, "(%d-%d, length %d)", &from, &to, &length);
  if (to-from+1 != length) {
    fprintf(stderr, "%d: error: inconsistent length: %d-%d+1!=%d\n", yylineno, to, from, length);
  } else {
    fprintf(stdout, "%d: info: consistent length: %d-%d+1==%d\n", yylineno, to, from, length);
 }
}

void
emit(char *s, ...)
{
  extern yylineno;

  va_list ap;
  va_start(ap, s);

  printf("rpn: ");
  vfprintf(stdout, s, ap);
  printf("\n");
}

void
yyerror(char *s, ...)
{
  extern yylineno;

  va_list ap;
  va_start(ap, s);

  fprintf(stderr, "%d: error: ", yylineno);
  vfprintf(stderr, s, ap);
  fprintf(stderr, "\n");
}

main(int ac, char **av)
{
  extern FILE *yyin;

  if(ac > 1 && !strcmp(av[1], "-d")) {
    yydebug = 1; ac--; av++;
  }

  if(ac > 1 && (yyin = fopen(av[1], "r")) == NULL) {
    perror(av[1]);
    exit(1);
  }

  if(!yyparse())
    printf("brst parse worked\n");
  else
    printf("brst parse failed\n");
} /* main */

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
