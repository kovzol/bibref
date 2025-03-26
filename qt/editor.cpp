// Taken from https://stackoverflow.com/a/53688529/1044586

#include "editor.h"
#include <QMimeData>

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
