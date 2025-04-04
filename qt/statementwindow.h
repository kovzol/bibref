#ifndef STATEMENTWINDOW_H
#define STATEMENTWINDOW_H

#include "highlighter.h"
#include "editor.h"

#include <QMainWindow>
#include <QtWidgets>

#include <string>

using namespace std;

QT_BEGIN_NAMESPACE
class Editor;
QT_END_NAMESPACE

class StatementWindow : public QMainWindow
{
    Q_OBJECT

public:
    StatementWindow(QWidget *parent = nullptr);
    ~StatementWindow();

public slots:
    void newFile();
    void openFile(const QString &path = QString());
    void saveFileAs(const QString &path = QString());
    void parse();
    void analyze();
    void showSvg();
    void setMessage();
    void setPosition();

private:
    void setupEditor();
    void setupFileMenu();
    void setupProveMenu();
    void setupHelpMenu();

    Editor *editor;
    QTableWidget *t;
    Highlighter *highlighter;

    string graphviz_input;
    QString directory;

};

#endif
