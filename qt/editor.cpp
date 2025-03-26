// Taken partially from https://stackoverflow.com/a/53688529/1044586

#include "editor.h"

#include <QMimeData>
#include <QKeyEvent>
#include <QInputDialog>

void Editor::insertFromMimeData(const QMimeData * source)
{
    if (source->hasText())
    {
        QString text = source->text();
        QTextCursor cursor = textCursor();

        for (int x = 0, pos = cursor.positionInBlock(); x < text.size(); x++, pos++)
        {
            if (text[x] == '\t')
            {
                text[x] = ' ';
                for (int spaces = TAB_SPACES - (pos % TAB_SPACES) - 1; spaces > 0; spaces--)
                    text.insert(x, ' ');
            }
            else if (text[x] == '\n')
            {
                pos = -1;
            }
        }
        cursor.insertText(text);
    }
}

void Editor::keyPressEvent(QKeyEvent *event)
{
    if (event->type() == QKeyEvent::KeyPress &&
        event->matches(QKeySequence::Find)) {
            QInputDialog inputDialog(this);
            inputDialog.setWindowTitle(tr("Find text"));
            inputDialog.setLabelText(tr("Text to find:"));
            inputDialog.setTextValue(searchText);
            if (inputDialog.exec() == QDialog::Accepted) {
                searchText = inputDialog.textValue();
                this->find(searchText);
            }
        }
    else {
        QTextEdit::keyPressEvent(event); // call "super"
    }
}
