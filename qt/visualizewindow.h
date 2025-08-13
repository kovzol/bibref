#ifndef VISUALIZEWINDOW_H
#define VISUALIZEWINDOW_H

#include <QMainWindow>
#include <QSvgWidget>
#include <string>

using namespace std;

class VisualizeWindow : public QMainWindow
{
    Q_OBJECT

public:
    VisualizeWindow(QWidget *parent, string input);

private:
    QSvgWidget *tile;
};

#endif
