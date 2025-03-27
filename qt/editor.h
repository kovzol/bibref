#pragma once
#include <QTextEdit>

class Editor : public QTextEdit
{
    Q_OBJECT

public:
    Editor(QWidget * parent) : QTextEdit(parent) {}

    Editor() : QTextEdit() {}

    void insertFromMimeData(const QMimeData * source) override;
    void keyPressEvent(QKeyEvent *event) override;

private:
    static const int TAB_SPACES = 4;

    QString searchText;
};
