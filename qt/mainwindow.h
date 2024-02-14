#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

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

protected:

private slots:
    void addBibles();
    void greekText1();
    void greekText2();
    void about();
    void aboutQt();

private:
    void createActions();
    void createMenus();
    void greekText(int n);

    QMenu *fileMenu;
    QMenu *editMenu;
    QMenu *helpMenu;
    QAction *addBiblesAct;
    QAction *exitAct;
    QAction *greekText1Act;
    QAction *greekText2Act;
    QAction *aboutAct;
    QAction *aboutQtAct;
    QLabel *infoLabel;
};

#endif
