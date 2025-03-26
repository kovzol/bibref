#pragma once
#include <QTextEdit>

class Editor : public QTextEdit
{
    Q_OBJECT

public:
    Editor(QWidget * parent) : QTextEdit(parent) {}

    Editor() : QTextEdit() {}

    void insertFromMimeData(const QMimeData * source) override;

private:
    static const int TAB_SPACES = 4;
};
