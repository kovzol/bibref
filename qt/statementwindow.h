#ifndef STATEMENTWINDOW_H
#define STATEMENTWINDOW_H

#include "highlighter.h"

#include <QMainWindow>

QT_BEGIN_NAMESPACE
class QTextEdit;
QT_END_NAMESPACE

class StatementWindow : public QMainWindow
{
    Q_OBJECT

public:
    StatementWindow(QWidget *parent = nullptr);

public slots:
    void newFile();
    void openFile(const QString &path = QString());

private:
    void setupEditor();
    void setupFileMenu();
    void setupHelpMenu();

    QTextEdit *editor;
    Highlighter *highlighter;
};

#endif
