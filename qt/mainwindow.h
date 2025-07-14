#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtWidgets>

QT_BEGIN_NAMESPACE
class QAction;
class QActionGroup;
class QLabel;
class QMenu;
class QDialogButtonBox;
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow();
    QAction *addBiblesAct;
    QAction *lookup1Act;
    QAction *lookup2Act;
    QAction *rawAct;
    QAction *raw1Act;
    QAction *raw2Act;
    QAction *find1Act;
    QAction *find2Act;
    QAction *minunique1Act;
    QAction *extendAct;
    QAction *getrefsAct;
    QAction *statementAct;
    QAction *tokensAct;
    QAction *searchAct;
    QAction *preferencesAct;
    QTextEdit *passageInfos;
    void moveCursorEnd(QTextEdit *b);
    void preferences();

protected:
private slots:
    void addBibles();
    void greekText1();
    void greekText2();
    void latinText1();
    void latinText2();
    void nearest12();
    void lookup();
    void tokens();
    void search();
    void lookup1();
    void lookup2();
    void raw();
    void raw1();
    void raw2();
    void find1();
    void find2();
    void minunique1();
    void extend();
    void getrefs();
    void statement();
    void about();
    void aboutSword();
    void aboutQt();
    void tutorial();
    void wiki();
    void showSwordBibles();
    void webTerminal();

private:
    void createActions();
    void createMenus();
    void greekTextN(int n);
    void latinTextN(int n);
    void lookupN(int n);
    void findN(int n);
    void rawN(int n);

    void setToolTipHelp(QInputDialog *dialog, std::string command);

    QMenu *fileMenu;
    QMenu *editMenu;
    QMenu *passageMenu;
    QMenu *quotationMenu;
    QMenu *rawMenu;
    QMenu *helpMenu;
    QAction *exitAct;
    QAction *greekText1Act;
    QAction *greekText2Act;
    QAction *latinText1Act;
    QAction *latinText2Act;
    QAction *nearest12Act;
    QAction *lookupAct;
    QAction *aboutAct;
    QAction *aboutSwordAct;
    QAction *aboutQtAct;
    QAction *tutorialAct;
    QAction *wikiAct;
    QAction *showAvailableBiblesAct;
    QAction *webTerminalAct;
    QLabel *clipboardInfos;
    QDialogButtonBox *buttonBox;
};

#endif
