#ifndef HIGHLIGHTER_H
#define HIGHLIGHTER_H

#include <QSyntaxHighlighter>
#include <QTextCharFormat>
#include <QRegularExpression>

QT_BEGIN_NAMESPACE
class QTextDocument;
QT_END_NAMESPACE

//! [0]
class Highlighter : public QSyntaxHighlighter
{
    Q_OBJECT

public:
    Highlighter(QTextDocument *parent = nullptr);

protected:
    void highlightBlock(const QString &text) override;

private:
    struct HighlightingRule
    {
        QRegularExpression pattern;
        QTextCharFormat format;
    };
    QList<HighlightingRule> highlightingRules;

    QTextCharFormat keywordFormat;
    QTextCharFormat conjunctiveFormat;
    QTextCharFormat otFormat;
    QTextCharFormat otEditionFormat;
    QTextCharFormat ntFormat;
    QTextCharFormat ntEditionFormat;
    QTextCharFormat greekFormat;
    QTextCharFormat positionFormat;
    QTextCharFormat singleLineCommentFormat;
};

#endif // HIGHLIGHTER_H
