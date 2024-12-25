#include "highlighter.h"

//! [0]
Highlighter::Highlighter(QTextDocument *parent)
    : QSyntaxHighlighter(parent)
{
    HighlightingRule rule;

/*
Statement Acts-2,25+21 connects
 SBLGNT Acts 2:25+21 2:28 (4835-5120) with
 LXX Psalms 16:8 16:11-31 (12493-12778) based on
  introduction 2:25 2:25-68 (4814-4834) a-y form dayidgarlegeieisayton that
   declares a quotation with 'λεγει' also
   identifies the source with 'Δαυιδ' moreover
  fragment 2:25+21 2:28 (4835-5120, length 286) a-y form proorvmhntonkyrionenvpionmoydiapantosotiekdejivnmoyestininamhsaleyuvdiatoytohyfranuhhkardiamoykaihgalliasatohglvssamoyetidekaihsarjmoykataskhnvseiepelpidiotioykegkataleiceisthncyxhnmoyeisadhnoydedvseistonosionsoyideindiafuoranegnvrisasmoiodoysqvhsplhrvseismeeyfrosynhsmetatoyprosvpoysoy
   matches LXX Psalms 16:8 16:11-31 (12493-12778, length 286) a-y form provrvmhntonkyrionenvpionmoydiapantosotiekdejivnmoyestininamhsaleyuvdiatoytohyfranuhhkardiamoykaihgalliasatohglvssamoyetidekaihsarjmoykataskhnvseiepelpidiotioykegkataleiceisthncyxhnmoyeisadhnoydedvseistonosionsoyideindiafuoranegnvrisasmoiodoysqvhsplhrvseismeeyfrosynhsmetatoyprosvpoysoy
    unique in Old Testament
    differing by 0.70%
  providing an overall cover of 100.00%.
*/

    keywordFormat.setForeground(QColorConstants::Svg::orange);
    keywordFormat.setFontWeight(QFont::Bold);
    // TODO: Allow newline. For some strange reason, Qt's regex flavor ignores newlines.
    const QString keywordPatterns[] = {
        QStringLiteral("\\b[Ss]tatement\\b"), QStringLiteral("\\bintroduction\\b"),
        QStringLiteral("\\ba-y[\\s]+form\\b"),
        QStringLiteral("\\bdeclares[\\s]+a[\\s]+quotation\\b"),
        QStringLiteral("\\bidentifies[\\s]+the[\\s]+source[\\s]with\\b"),
        QStringLiteral("\\bfragment\\b"),
        QStringLiteral("\\bverbatim\\b"), QStringLiteral("\\bdiffering\\b"), QStringLiteral("\\bmatches\\b"),
        QStringLiteral("\\bno[\\s]+evidence\\b"), QStringLiteral("\\bno[\\s]+evidence\\b"),
        QStringLiteral("\\bunique[\\s]+in[\\s]+[Oo]ld[\\s]+[Tt]estament\\b"),
        QStringLiteral("\\bdiffering[\\s]by\\b"), QStringLiteral("\\bproviding[\\s]+an[\\s]+overall[\\s]+cover[\\s]+of\\b")};
    for (const QString &pattern : keywordPatterns) {
        rule.pattern = QRegularExpression(pattern);
        rule.format = keywordFormat;
        highlightingRules.append(rule);
    }

    conjunctiveFormat.setForeground(QColorConstants::Svg::orange);
    const QString conjunctivePatterns[] = {
        QStringLiteral("\\bconnects\\b"), QStringLiteral("\\with\\b"), QStringLiteral("\\bbased[\\s]+on\\b"),
        QStringLiteral("\\bthat\\b"), QStringLiteral("\\balso\\b"), QStringLiteral("\\band\\b"),
        QStringLiteral("\\bmoreover\\b")};
    for (const QString &pattern : conjunctivePatterns) {
        rule.pattern = QRegularExpression(pattern);
        rule.format = conjunctiveFormat;
        highlightingRules.append(rule);
    }

    otEditionFormat.setForeground(Qt::darkYellow);
    otEditionFormat.setFontWeight(QFont::Bold);
    const QString otEditions[] = {"LXX"};
    for (const QString &pattern : otEditions) {
        rule.pattern = QRegularExpression("\\b" + pattern + "\\b");
        rule.format = otEditionFormat;
        highlightingRules.append(rule);
    }

    otFormat.setForeground(Qt::darkYellow);
    const QString otBooks[] = {"Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy",
        "Joshua", "Judges", "Ruth", "I_Samuel", "II_Samuel", "I_Kings", "II_Kings",
        "I_Chronicles", "II_Chronicles", "Ezra", "Nehemiah", "Esther", "Job",
        "Psalms", "Proverbs", "Ecclesiastes", "Song_of_Solomon",
        "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel",
        "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah",
        "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi"};
    for (const QString &pattern : otBooks) {
        rule.pattern = QRegularExpression("\\b" + pattern + "\\s[0-9:\\-\\+ ]+\\s");
        rule.format = otFormat;
        highlightingRules.append(rule);
    }

    ntEditionFormat.setForeground(Qt::darkCyan);
    ntEditionFormat.setFontWeight(QFont::Bold);
    const QString ntEditions[] = {"SBLGNT", "StatResGNT"};
    for (const QString &pattern : ntEditions) {
        rule.pattern = QRegularExpression("\\b" + pattern + "\\b");
        rule.format = ntEditionFormat;
        highlightingRules.append(rule);
    }

    ntFormat.setForeground(Qt::darkCyan);
    const QString ntBooks[] = {"Matthew", "Mark", "Luke", "John",
        "Acts", "Romans", "I_Corinthians", "II_Corinthians", "Galatians", "Ephesians", "Philippians",
        "Colossians", "I_Thessalonians", "II_Thessalonians", "I_Timothy", "II_Timothy", "Titus", "Philemon",
        "Hebrews", "James", "I_Peter", "II_Peter", "I_John", "II_John", "III_John", "Jude", "Revelation_of_John"};
    for (const QString &pattern : ntBooks) {
        rule.pattern = QRegularExpression("\\b" + pattern + "\\s[0-9:\\-\\+ ]+\\s");
        rule.format = ntFormat;
        highlightingRules.append(rule);
    }

    singleLineCommentFormat.setForeground(Qt::gray);
    rule.pattern = QRegularExpression(QStringLiteral("#[^\n]*"));
    rule.format = singleLineCommentFormat;
    highlightingRules.append(rule);

    greekFormat.setForeground(Qt::green);
    rule.pattern = QRegularExpression(QStringLiteral("'.*'"));
    rule.format = greekFormat;
    highlightingRules.append(rule);

    positionFormat.setForeground(Qt::magenta);
    rule.pattern = QRegularExpression(QStringLiteral("\\([\\d]+\\-[\\d]+\\)"));
    rule.format = positionFormat;
    highlightingRules.append(rule);
    rule.pattern = QRegularExpression(QStringLiteral("\\([\\d]+\\-[\\d]+,[\\s]+length[\\s]+[\\d]+\\)"));
    rule.format = positionFormat;
    highlightingRules.append(rule);

}
//! [6]

//! [7]
void Highlighter::highlightBlock(const QString &text)
{
    for (const HighlightingRule &rule : std::as_const(highlightingRules)) {
        QRegularExpressionMatchIterator matchIterator = rule.pattern.globalMatch(text);
        while (matchIterator.hasNext()) {
            QRegularExpressionMatch match = matchIterator.next();
            setFormat(match.capturedStart(), match.capturedLength(), rule.format);
        }
    }
    setCurrentBlockState(0);
}

/*
-- Keywords that are on line start...
  { Id=1,
    List={"Statement", "statement", "introduction", "fragment",
      "verbatim", "differing", "matches", "and", "that", "also", "moreover", "no", "evidence",
      "unique", "in", "old", "testament"}
  },

-- Keywords that are on line end...
  { Id=1,
    List={"connects", "with", "based", "on", "."}
  },

-- Old Testament related...
  { Id=2,
    List={"LXX", "Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy",
      "Joshua", "Judges", "Ruth", "I_Samuel", "II_Samuel", "I_Kings", "II_Kings",
      "I_Chronicles", "II_Chronicles", "Ezra", "Nehemiah", "Esther", "Job",
      "Psalms", "Proverbs", "Ecclesiastes", "Song_of_Solomon",
      "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel",
      "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah",
      "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi"}
  },

-- New Testament related...
  { Id=2,
    List={"SBLGNT", "StatResGNT", "Matthew", "Mark", "Luke", "John",
      "Acts", "Romans", "I_Corinthians", "II_Corinthians", "Galatians", "Ephesians", "Philippians",
      "Colossians", "I_Thessalonians", "II_Thessalonians", "I_Timothy", "II_Timothy", "Titus", "Philemon",
      "Hebrews", "James", "I_Peter", "II_Peter", "I_John", "II_John", "III_John", "Jude", "Revelation_of_John"},
  },

-- Forms in a-y notation...
  { Id=3,
    Regex=[[a\-y\s*form\s*['a-y']+]]
  },
-- ...or in Greek...
  { Id=3,
    Regex=[[with\s*\'\.+\']]
  },


-- Lengths and positions...
  { Id=4,
    Regex=[[length\s*['0-9']+]]
  },
  { Id=4,
    Regex=[[(['0-9']+\-['0-9']+)]]
  },

-- Traditional Bible verse definitions...
  { Id=5,
    Regex=[[(['0-9']+:['0-9']+)]]
  },

-- Percentual reports...
  { Id=6,
    Regex=[[differing\s*by\s*['0-9']+.['0-9']+%]]
  },
  { Id=6,
    Regex=[[providing\s*an\s*overall\s*cover\s*of\s*['0-9']+.['0-9']+%]]
  },

-- Introductory comments...
  { Id=6,
    Regex=[[declares\s*a\s*quotation]]
  },
  { Id=6,
    Regex=[[identifies\s*the\s*source]]
  },

}

IgnoreCase=false

Comments={
  { Block=false,
    Delimiter= { [[#]] }
  }
}
*/
