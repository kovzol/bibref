#include "mainwindow.h"

#include "books.h"
#include "cli.h"
#include "swmgr.h"

#include <boost/algorithm/string/trim.hpp>
#include <boost/algorithm/string/split.hpp>

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
extern string collect_info;

string lookupText = "LXX Genesis 1:1"; // example

QString getClipboardInfos() {
    QString intro = "<b>Contents of the clipboards in Greek (and in a-y notation)</b>";
    for (int i = 0; i < 2; ++i) {
        intro += "<br>Clipboard " + QString::number(i + 1);
        if (text[i].empty())
            intro += " is empty.";
        else {
            intro += " contains " + latinToGreek(text[i]) + " (" + text[i] + "),"
                     + " length ";
            intro += QString::number(text[i].length()) + ".";
        }
    }
    if (textset[0] && textset[1]) {
        // double c = dist(text[0], text[1]);
        double j = jaccard_dist(text[0], text[1]);
        intro += "<br>Their Jaccard distance is " + QString::number(j) + ".";
    }
    return intro;
}

MainWindow::MainWindow()
{
    QWidget *widget = new QWidget;
    setCentralWidget(widget);
    QWidget *topFiller = new QWidget;
    topFiller->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

    clipboardInfos = new QLabel(getClipboardInfos());
    clipboardInfos->setFrameStyle(QFrame::StyledPanel | QFrame::Sunken);
    clipboardInfos->setAlignment(Qt::AlignCenter);
    clipboardInfos->setWordWrap(true);
    clipboardInfos->setTextInteractionFlags(Qt::TextSelectableByMouse); // selectable

    QWidget *bottomFiller = new QWidget;
    bottomFiller->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

    passageInfos = new QTextEdit;
    passageInfos->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    passageInfos->setReadOnly(true); // it's preferred to not edit

    QVBoxLayout *layout = new QVBoxLayout;
    layout->setContentsMargins(5, 5, 5, 5);
    layout->addWidget(topFiller);
    layout->addWidget(clipboardInfos);
    layout->addWidget(passageInfos);
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

//void addBiblesThread(QStatusBar* statusBar) {
void addBiblesThread(MainWindow* window) {
    addBibles();
    QString message = "Bibles are loaded.";
    window->statusBar()->showMessage(message);
    booksAdded = true;
    window->lookup1Act->setEnabled(true);
    window->lookup2Act->setEnabled(true);
}

void MainWindow::addBibles()
{
    QString message = tr("Please wait...");
    statusBar()->showMessage(message);
    QFuture<void> future = QtConcurrent::run(addBiblesThread, this);
}

void MainWindow::greekTextN(int index)
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle(tr("Text " + index));
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

    clipboardInfos->setText(getClipboardInfos());
}

void MainWindow::greekText1()
{
    this->greekTextN(0);
}

void MainWindow::greekText2()
{
    this->greekTextN(1);
}

void MainWindow::latinTextN(int index)
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle(tr("Latin text " + index));
    inputDialog.setLabelText(tr("Latin text:"));
    if (textset[index]) {
        inputDialog.setTextValue(text[index].c_str());
    }
    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    string rest = value.toStdString();

    text[index] = rest;
    textset[index] = true; // activate clipboard

    clipboardInfos->setText(getClipboardInfos());
}

void MainWindow::latinText1()
{
    this->latinTextN(0);
}

void MainWindow::latinText2()
{
    this->latinTextN(1);
}

void MainWindow::lookup()
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle(tr("Lookup"));
    inputDialog.setLabelText(tr("Verse:"));
    inputDialog.setTextValue(lookupText.c_str());
    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    lookupText = value.toStdString();
    string rest = lookupText;

    // Mostly taken from cli:
    vector<string> tokens;
    boost::split(tokens, rest, boost::is_any_of(" "));
    int restSize = tokens.size();
    if (restSize == 3) { // e.g. lookup LXX Genesis 1:1
        collect_info = ""; // reset communication buffer
        lookupTranslation(tokens[0], tokens[1], tokens[2]); // simple lookup via Sword
        passageInfos->append(("<b>" + rest + "</b>" + "<br>" + collect_info).c_str());

        QTextCursor tc = passageInfos->textCursor();
        tc.setPosition(passageInfos->document()->characterCount() - 1);
        passageInfos->setTextCursor(tc); // Move cursor to the end.
    } else {
        QString message = "Invalid input (3 words are needed: Bible edition, book, chapter:verse).";
        statusBar()->showMessage(message);
    }
    return; // Success!
}

void MainWindow::lookupN(int index)
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle(tr("Lookup " + index));
    inputDialog.setLabelText(tr("Verse:"));
    inputDialog.setTextValue(lookupText.c_str());
    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    lookupText = value.toStdString();
    string rest = lookupText;

    // Mostly taken from cli:
    vector<string> tokens;
    boost::split(tokens, rest, boost::is_any_of(" "));
    int restSize = tokens.size();
    if (restSize == 3) {
        string verse = "";
        try { // e.g. lookup1 LXX Genesis 1:1
            verse = lookupVerse(tokens[1], tokens[0], tokens[2]); // lookup in the a-y database
            text[index] = verse; // Store result.
            textset[index] = true; // activate clipboard
            statusBar()->showMessage("Stored.");
            clipboardInfos->setText(getClipboardInfos());
        } catch (exception &e) {
            statusBar()->showMessage("Unsuccessful lookup.");
        }
        return; // Success!
    }
    if (restSize == 4) { // e.g. lookup1 LXX Genesis 1:1+3 1:2-4
        string verse = "";
        try {
            vector<string> tokens2, tokens3;
            int start = 0, end = 0;
            boost::split(tokens2, tokens[2], boost::is_any_of("+"));
            if (tokens2.size() > 1) {
                start = stoi(tokens2[1]); // read off the plus shift
            }
            boost::split(tokens3, tokens[3], boost::is_any_of("-"));
            if (tokens3.size() > 1) {
                end = stoi(tokens3[1]); // read off the minus shift
            }
            // Shift-allowed lookup in the a-y database...
            verse = getText(tokens[1], tokens[0], tokens2.at(0), tokens3.at(0), start, end);
            text[index] = verse; // Store result.
            textset[index] = true; // activate clipboard
            statusBar()->showMessage("Stored.");
            clipboardInfos->setText(getClipboardInfos());
        } catch (exception &e) {
            statusBar()->showMessage("Unsuccessul lookup.");
        }
        return; // Success!
    }
    statusBar()->showMessage("Wrong amount of parameters is given.");
}

void MainWindow::lookup1()
{
    this->lookupN(0);
}

void MainWindow::lookup2()
{
    this->lookupN(1);
}




void MainWindow::about()
{
    QMessageBox::about(this, tr("About Menu"),
        tr("<a href=\"https://github.com/kovzol/bibref\">bibref</a> is a tool that helps discovering internal references in the Bible."
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

    greekText2Act = new QAction(tr("Text 2"), this);
    greekText2Act->setStatusTip(tr("Define a Greek text and put its Latin transcription in clipboard 2"));
    connect(greekText2Act, &QAction::triggered, this, &MainWindow::greekText2);

    latinText1Act = new QAction(tr("&Latin text 1"), this);
    latinText1Act->setStatusTip(tr("Put a Latin (a-y) transcription in clipboard 1"));
    connect(latinText1Act, &QAction::triggered, this, &MainWindow::latinText1);

    latinText2Act = new QAction(tr("Latin text 2"), this);
    latinText2Act->setStatusTip(tr("Put a Latin (a-y) transcription in clipboard 2"));
    connect(latinText2Act, &QAction::triggered, this, &MainWindow::latinText2);

    lookupAct = new QAction(tr("&Lookup"), this);
    lookupAct->setStatusTip(tr("Search for a verse in a book in the given Bible"));
    connect(lookupAct, &QAction::triggered, this, &MainWindow::lookup);

    lookup1Act = new QAction(tr("Lookup &1"), this);
    lookup1Act->setStatusTip(tr("Search for a passage in a book in the given Bible and put it in clipboard 1"));
    connect(lookup1Act, &QAction::triggered, this, &MainWindow::lookup1);
    lookup1Act->setDisabled(true);

    lookup2Act = new QAction(tr("Lookup &2"), this);
    lookup2Act->setStatusTip(tr("Search for a passage in a book in the given Bible and put it in clipboard 1"));
    connect(lookup2Act, &QAction::triggered, this, &MainWindow::lookup2);
    lookup2Act->setDisabled(true);

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
    editMenu->addAction(latinText1Act);
    editMenu->addAction(latinText2Act);

    passageMenu = menuBar()->addMenu(tr("&Passage"));
    passageMenu->addAction(lookupAct);
    passageMenu->addSeparator();
    passageMenu->addAction(lookup1Act);
    passageMenu->addAction(lookup2Act);

    helpMenu = menuBar()->addMenu(tr("&Help"));
    helpMenu->addAction(aboutAct);
    helpMenu->addAction(aboutQtAct);
}
