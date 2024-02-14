#include <QtWidgets>

#include "mainwindow.h"

#include "books.h"
#include "cli.h"
#include "swmgr.h"

#include <QCoreApplication>
#include <qtconcurrentrun.h>
#include <QThread>
#include <QtConcurrent/qtconcurrentmap.h>
#include <QtCore/qelapsedtimer.h>

using namespace std;

using namespace sword;

// These are defined in cli.cpp. FIXME: Make this common in a better way.
extern bool booksAdded;
extern string text[2];
extern vector<bool> textset;

QString getClipboardInfos() {
    QString intro = "<b>Contents of the clipboards in a-y notation</b>";
    for (int i = 0; i < 2; ++i) {
        intro += "<br>Clipboard " + QString::number(i + 1);
        if (text[i].empty())
            intro += " is empty.";
        else
            intro += " contains " + text[i] + ".";
    }
    return intro;
}

MainWindow::MainWindow()
{
    QWidget *widget = new QWidget;
    setCentralWidget(widget);
    QWidget *topFiller = new QWidget;
    topFiller->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

    infoLabel = new QLabel(getClipboardInfos());
    infoLabel->setFrameStyle(QFrame::StyledPanel | QFrame::Sunken);
    infoLabel->setAlignment(Qt::AlignCenter);

    QWidget *bottomFiller = new QWidget;
    bottomFiller->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

    QVBoxLayout *layout = new QVBoxLayout;
    layout->setContentsMargins(5, 5, 5, 5);
    layout->addWidget(topFiller);
    layout->addWidget(infoLabel);
    layout->addWidget(bottomFiller);
    widget->setLayout(layout);
    createActions();
    createMenus();

    QString message = tr("Welcome to bibref!");
    statusBar()->showMessage(message);

    setWindowTitle(tr("bibref"));
    setMinimumSize(160, 160);
    resize(480, 320);
}

void addBiblesThread(QStatusBar* statusBar) {
    addBibles();
    QString message = "Bibles are loaded.";
    statusBar->showMessage(message);
    booksAdded = true;
}

void MainWindow::addBibles()
{
    QString message = tr("Please wait...");
    statusBar()->showMessage(message);
    QFuture<void> future = QtConcurrent::run(addBiblesThread, statusBar());
}

void MainWindow::greekText(int index)
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle(tr("Define a Greek text and put its Latin transcription in clipboard"));
    inputDialog.setLabelText(tr("Greek text:"));
    if (textset[index]) {
        inputDialog.setTextValue(latinToGreek(text[index]).c_str());
    }
    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    string rest = value.toStdString();

    // Taken from cli:
    SWMgr manager;
    manager.setGlobalOption("Greek Accents", "Off"); // disable accents
    SWBuf to_convert = rest.data();
    manager.filterText("Greek Accents", to_convert);
    // Convert Greek to Latin:
    string processed = processVerse(to_convert.c_str());
    if (processed.length() == 0) {
        error("Text does not contain Greek letters, ignored.");
        return; // Success, but nothing happened.
    }
    text[index] = processed; // Store result.
    textset[index] = true; // activate clipboard
    info("Stored internally as " + processed + "."); // Success!

    infoLabel->setText(getClipboardInfos());
}

void MainWindow::greekText1()
{
    this->greekText(0);
}


void MainWindow::greekText2()
{
    this->greekText(1);
}

void MainWindow::about()
{
    QMessageBox::about(this, tr("About Menu"),
        tr("<i>bibref</i> is a tool that helps discovering internal references in the Bible."
        "<br>It aims at finding citations of the <a href=\"https://en.wikipedia.org/wiki/Septuagint\">Septuagint</a>"
        " in the <a href=\"https://en.wikipedia.org/wiki/New_Testament\">Greek New Testament</a>"
        " in a mechanical way."));
}

void MainWindow::aboutQt()
{
}

void MainWindow::createActions()
{
    addBiblesAct = new QAction(tr("&Add books"), this);
    addBiblesAct->setShortcuts(QKeySequence::New);
    addBiblesAct->setStatusTip(tr("Load and index the default Bible editions"));
    connect(addBiblesAct, &QAction::triggered, this, &MainWindow::addBibles);

    exitAct = new QAction(tr("E&xit"), this);
    exitAct->setShortcuts(QKeySequence::Quit);
    exitAct->setStatusTip(tr("Exit the application"));
    connect(exitAct, &QAction::triggered, this, &QWidget::close);

    greekText1Act = new QAction(tr("&Text 1"), this);
    greekText1Act->setStatusTip(tr("Define a Greek text and put its Latin transcription in clipboard 1"));
    connect(greekText1Act, &QAction::triggered, this, &MainWindow::greekText1);

    greekText2Act = new QAction(tr("&Text 2"), this);
    greekText2Act->setStatusTip(tr("Define a Greek text and put its Latin transcription in clipboard 2"));
    connect(greekText2Act, &QAction::triggered, this, &MainWindow::greekText2);

    aboutAct = new QAction(tr("&About"), this);
    aboutAct->setStatusTip(tr("Show the application's About box"));
    connect(aboutAct, &QAction::triggered, this, &MainWindow::about);

    aboutQtAct = new QAction(tr("About &Qt"), this);
    aboutQtAct->setStatusTip(tr("Show the Qt library's About box"));
    connect(aboutQtAct, &QAction::triggered, qApp, &QApplication::aboutQt);
    connect(aboutQtAct, &QAction::triggered, this, &MainWindow::aboutQt);
}
void MainWindow::createMenus()
{
    fileMenu = menuBar()->addMenu(tr("&File"));
    fileMenu->addAction(addBiblesAct);
    fileMenu->addSeparator();
    fileMenu->addAction(exitAct);

    editMenu = menuBar()->addMenu(tr("&Edit"));
    editMenu->addAction(greekText1Act);
    editMenu->addAction(greekText2Act);

    helpMenu = menuBar()->addMenu(tr("&Help"));
    helpMenu->addAction(aboutAct);
    helpMenu->addAction(aboutQtAct);
}
