#include "statementwindow.h"

#include <QtWidgets>
#include <iostream>

StatementWindow::StatementWindow(QWidget *parent)
    : QMainWindow(parent)
{
    this->setAttribute(::Qt::WA_DeleteOnClose);
    setupFileMenu();
    setupHelpMenu();
    setupEditor();

    setCentralWidget(editor);
    setWindowTitle(tr("Statement Editor"));
}

void StatementWindow::newFile()
{
    editor->clear();
}

void StatementWindow::openFile(const QString &path)
{
    QString fileName = path;

    if (fileName.isNull())
        fileName = QFileDialog::getOpenFileName(this, tr("Open File"), "", tr("bibref statement files (*.brst)"));

    if (!fileName.isEmpty()) {
        QFile file(fileName);
        if (file.open(QFile::ReadOnly | QFile::Text))
            editor->setPlainText(file.readAll());
    }
}

void StatementWindow::setupEditor()
{
    QFont font;
    font.setFamily("Courier");
    font.setFixedPitch(true);
    font.setPointSize(10);

    editor = new QTextEdit;
    editor->setFont(font);

    highlighter = new Highlighter(editor->document());

    QFile file(PROJECT_SOURCE_DIR "/statements/SBLGNT/Matthew/Matthew-1,23.brst");
    if (file.open(QFile::ReadOnly | QFile::Text))
        editor->setPlainText(file.readAll());
    else {
        QString statement = QString("") + "Statement Matthew-1,23 connects\n" +
            " SBLGNT Matthew 1:23 1:23-34 (1922-1994) with\n" +
            " LXX Isaiah 7:14+35 7:14 (14234-14304) based on\n" +
            "  introduction 1:22 1:22 (1856-1921) a-y form toytodeolongegoneninaplhrvuhtorhuenypokyrioydiatoyprofhtoylegontos that\n" +
            "   declares a quotation with 'το ρηθεν υπο κυριου ... λεγοντος' also\n" +
            "   identifies the source with 'δια του προφητου' moreover\n" +
            "  fragment 1:23 1:23-34 (1922-1994, length 73) a-y form idoyhparuenosengastriejeikaitejetaiyionkaikalesoysintoonomaaytoyemmanoyhl\n" +
            "   matches LXX Isaiah 7:14+35 7:14 (14234-14304, length 71) a-y form idoyhparuenosengastriejeikaitejetaiyionkaikaleseistoonomaaytoyemmanoyhl\n" +
            "    unique in Old Testament\n" +
            "   differing by 8.33%\n" +
            "  providing an overall cover of 100.00%.";
        editor->setPlainText(statement);
    }
}

void StatementWindow::setupFileMenu()
{
    QMenu *fileMenu = new QMenu(tr("&File"), this);
    menuBar()->addMenu(fileMenu);

    fileMenu->addAction(QIcon::fromTheme("document-new"), tr("&New"), QKeySequence::New,
                        this, &StatementWindow::newFile);
    fileMenu->addAction(QIcon::fromTheme("document-open"), tr("&Open..."), QKeySequence::Open,
                        this, [this](){ openFile(); });
}

void StatementWindow::setupHelpMenu()
{
    QMenu *helpMenu = new QMenu(tr("&Help"), this);
    menuBar()->addMenu(helpMenu);

    helpMenu->addAction(QIcon::fromTheme("system-help"), tr("&Blog entry"), this,
                        [this]() {
                            QString link = "https://matek.hu/zoltan/blog-20240805.php";
                            QDesktopServices::openUrl(QUrl(link)); });
}
