#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtWidgets>

QT_BEGIN_NAMESPACE
class QAction;
class QActionGroup;
class QLabel;
class QMenu;
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow();
    QAction *addBiblesAct;
    QAction *lookup1Act;
    QAction *lookup2Act;
    QAction *find1Act;
    QAction *find2Act;

protected:

private slots:
    void addBibles();
    void greekText1();
    void greekText2();
    void latinText1();
    void latinText2();
    void lookup();
    void lookup1();
    void lookup2();
    void find1();
    void find2();
    void about();
    void aboutQt();

private:
    void createActions();
    void createMenus();
    void greekTextN(int n);
    void latinTextN(int n);
    void lookupN(int n);
    void findN(int n);

    QMenu *fileMenu;
    QMenu *editMenu;
    QMenu *passageMenu;
    QMenu *helpMenu;
    QAction *exitAct;
    QAction *greekText1Act;
    QAction *greekText2Act;
    QAction *latinText1Act;
    QAction *latinText2Act;
    QAction *lookupAct;
    QAction *aboutAct;
    QAction *aboutQtAct;
    QLabel *clipboardInfos;
    QTextEdit *passageInfos;
};

#endif
