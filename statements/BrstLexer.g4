lexer grammar BrstLexer;

SCOL      : ';';
COL       : ':';
DOT       : '.';
OPEN_PAR  : '(';
CLOSE_PAR : ')';
COMMA     : ',';
PLUS      : '+';
MINUS     : '-';
PERCENT   : '%';

STATEMENT_ : 'Statement';
CONNECTS_ : 'connects';
WITH_ : 'with';
BASED_ : 'based';
ON_ : 'on';
INTRODUCTION_ : 'introduction';
A_Y_ : 'a-y';
FORM_: 'form';
THAT_: 'that';
DECLARES_ : 'declares';
A_: 'a';
QUOTATION_: 'quotation';
AND_ : 'and';
IDENTIFIES_ : 'identifies';
THE_ : 'the';
SOURCE_ : 'source';
MOREOVER_ : 'moreover';
FRAGMENT_ : 'fragment';
LENGTH_ : 'length';
MATCHES_ : 'matches';
DIFFERING_ : 'differing';
BY_ : 'by';
VERBATIM_ : 'verbatim';
PROVIDING_ : 'providing';
AN_ : 'an';
OVERALL_ : 'overall';
COVER_ : 'cover';
OF_ : 'of';
NO_ : 'no';
EVIDENCE_ : 'evidence';


SBLGNT_ : 'SBLGNT';
STATRESGNT_ : 'StatResGNT';

LXX_ : 'LXX';

GENESIS_ : 'Genesis';
EXODUS_ : 'Exodus';
LEVITICUS_ : 'Leviticus';
NUMBERS_ : 'Numbers';
DEUTERONOMY_ : 'Deuteronomy';
JOSHUA_ : 'Joshua';
JUDGES_ : 'Judges';
RUTH_ : 'Ruth';
I_SAMUEL_ : 'I_Samuel';
II_SAMUEL_ : 'II_Samuel';
I_KINGS_ : 'I_Kings';
II_KINGS_ : 'II_Kings';
I_CHRONICLES_ : 'I_Chronicles';
II_CHRONICLES_ : 'II_Chronicles';
EZRA_ : 'Ezra';
NEHEMIAH_ : 'Nehemiah';
ESTHER_ : 'Esther';
JOB_ : 'Job';
PSALMS_ : 'Psalms';
PROVERBS_ : 'Proverbs';
ECCLESIASTES_ : 'Ecclesiastes';
SONG_OF_SOLOMON_ : 'Song_of_Solomon';
ISAIAH_ : 'Isaiah';
JEREMIAH_ : 'Jeremiah';
LAMENTATIONS_ : 'Lamentations';
EZEKIEL_ : 'Ezekiel';
DANIEL_ : 'Daniel';
HOSEA_ : 'Hosea';
JOEL_ : 'Joel';
AMOS_ : 'Amos';
OBADIAH_ : 'Obadiah';
JONAH_ : 'Jonah';
MICAH_ : 'Micah';
NAHUM_ : 'Nahum';
HABAKKUK_ : 'Habakkuk';
ZEPHANIAH_ : 'Zephaniah';
HAGGAI_ : 'Haggai';
ZECHARIAH_ : 'Zechariah';
MALACHI_ : 'Malachi';
MATTHEW_ : 'Matthew';
MARK_ : 'Mark';
LUKE_ : 'Luke';
JOHN_ : 'John';
ACTS_ : 'Acts';
ROMANS_ : 'Romans';
I_CORINTHIANS_ : 'I_Corinthians';
II_CORINTHIANS_ : 'II_Corinthians';
GALATIANS_ : 'Galatians';
EPHESIANS_ : 'Ephesians';
PHILIPPIANS_ : 'Philippians';
COLOSSIANS_ : 'Colossians';
I_THESSALONIANS_ : 'I_Thessalonians';
II_THESSALONIANS_ : 'II_Thessalonians';
I_TIMOTHY_ : 'I_Timothy';
II_TIMOTHY_ : 'II_Timothy';
TITUS_ : 'Titus';
PHILEMON_ : 'Philemon';
HEBREWS_: 'Hebrews';
JAMES_ : 'James';
I_PETER_ : 'I_Peter';
II_PETER_ : 'II_Peter';
I_JOHN_ : 'I_John';
II_JOHN_ : 'II_John';
III_JOHN_ : 'III_John';
JUDE_ : 'Jude';
REVELATION_OF_JOHN_ : 'Revelation_of_John';

IDENTIFIER:
    '"' (~'"' | '""')* '"'
    | [A-Z_\u007F-\uFFFF] [A-Z_0-9\u007F-\uFFFF]*
;

STRING_LITERAL: '\'' ( ~'\'' | '\'\'')* '\'';

A_Y_LITERAL: [a-y]+;

SINGLE_LINE_COMMENT: '//' ~[\r\n]* (('\r'? '\n') | EOF) -> channel(HIDDEN);

MULTILINE_COMMENT: '/*' .*? '*/' -> channel(HIDDEN);

SPACES: [ \u000B\t\r\n] -> channel(HIDDEN);

fragment DIGIT: [0-9];
fragment DIGITS: DIGIT+;
NATURAL_NUMBER: DIGITS;
NUMERIC_LITERAL: ((DIGITS ('.' DIGIT*)?) | ('.' DIGITS));

