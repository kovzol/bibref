parser grammar BrstParser;

options {
    tokenVocab = BrstLexer;
}

parse
    : (brst_stmt_list)* EOF
;

brst_stmt_list
    : brst_stmt (DOT+ brst_stmt)* DOT*
;

brst_stmt
    : STATEMENT_ (IDENTIFIER)? CONNECTS_ nt_passage WITH_ ot_passages BASED_ ON_
        ( introductions |
          introductions MOREOVER_ fragments |
          fragments |
          NO_ EVIDENCE_
        )
;

nt_passage
    : nt_edition nt_book passage;

nt_edition
    : SBLGNT_ | STATRESGNT_;

nt_book
    : MATTHEW_ | MARK_ | LUKE_ | JOHN_ | ACTS_ | ROMANS_ | I_CORINTHIANS_ | II_CORINTHIANS_ |
        GALATIANS_ | EPHESIANS_ | PHILIPPIANS_ | COLOSSIANS_ | I_THESSALONIANS_ | II_THESSALONIANS_ |
        I_TIMOTHY_ | II_TIMOTHY_ | TITUS_ | PHILEMON_ | HEBREWS_ | JAMES_ | I_PETER_ | II_PETER_ |
        I_JOHN_ | II_JOHN_ | III_JOHN_ | JUDE_ | REVELATION_OF_JOHN_;

ot_passages
    : ( ot_passage | ot_passage AND_ ot_passages );

ot_passage
    : ot_edition ot_book passage;

ot_edition
    : LXX_;

ot_book
    : GENESIS_ | EXODUS_ | LEVITICUS_ | NUMBERS_ | DEUTERONOMY_ | JOSHUA_ | JUDGES_ | RUTH_ |
        I_SAMUEL_ | II_SAMUEL_ | I_KINGS_ | II_KINGS_ | I_CHRONICLES_ | II_CHRONICLES_ |
        EZRA_ | NEHEMIAH_ | ESTHER_ | JOB_ | PSALMS_ | PROVERBS_ | ECCLESIASTES_ |
        SONG_OF_SOLOMON_ | ISAIAH_ | JEREMIAH_ | LAMENTATIONS_ | EZEKIEL_ | DANIEL_ | HOSEA_ |
        JOEL_ | AMOS_ | OBADIAH_ | JONAH_ | MICAH_ | NAHUM_ | HABAKKUK_ | ZEPHANIAH_ |
        HAGGAI_ | ZECHARIAH_ | MALACHI_;

passage
    : ( verse
        | verse verse
        | verse_start_position verse
        | verse_start_position verse_end_position
        | verse verse_end_position
      ) raw_position?;

verse
    : NATURAL_NUMBER COL NATURAL_NUMBER;

verse_start_position
    : verse PLUS NATURAL_NUMBER;

verse_end_position
    : verse MINUS NATURAL_NUMBER;

raw_position
    : OPEN_PAR NATURAL_NUMBER MINUS NATURAL_NUMBER ( COMMA LENGTH_ NATURAL_NUMBER )? CLOSE_PAR;


introductions
    : ( introduction | introduction AND_ introductions );

introduction
    : INTRODUCTION_ passage A_Y_ FORM_ A_Y_LITERAL
        ( THAT_ ( introduction_explanations ) );

introduction_explanations
    : ( introduction_explanation | introduction_explanation AND_ introduction_explanations );

introduction_explanation
    : ( DECLARES_ A_ QUOTATION_ WITH_ STRING_LITERAL
        | IDENTIFIES_ THE_ SOURCE_ WITH_ STRING_LITERAL
      );

fragments
    : ( myfragment | myfragment AND_ fragments )
        PROVIDING_ AN_ OVERALL_ COVER_ OF_ NUMERIC_LITERAL PERCENT;

myfragment
    : FRAGMENT_ passage A_Y_ FORM_ A_Y_LITERAL
        MATCHES_ ot_passage A_Y_ FORM_ A_Y_LITERAL
        ( VERBATIM_ | DIFFERING_ BY_ NUMERIC_LITERAL PERCENT );

