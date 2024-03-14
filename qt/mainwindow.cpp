#include "mainwindow.h"

#include "books.h"
#include "cli.h"
#include "main.h"

#include "swmgr.h"
#include "swversion.h"

#include <boost/algorithm/string/find.hpp>
#include <boost/algorithm/string/replace.hpp>
#include <boost/algorithm/string/split.hpp>
#include <boost/algorithm/string/trim.hpp>

#include <QCoreApplication>
#include <QThread>
#include <QtConcurrent/qtconcurrentmap.h>
#include <QtCore/qelapsedtimer.h>
#include <qtconcurrentrun.h>

#include <cstdio>

using namespace std;

using namespace sword;

// These are defined in cli.cpp. FIXME: Make this common in a better way.
extern bool booksAdded;
extern string text[2];
extern vector<bool> textset;
extern string collect_info;
extern string ot_color, nt_color, reset_color, error_color;

string lookupText = "LXX Genesis 1:1";              // example
string extendText = "LXX StatResGNT Romans 3:13";   // example
string getrefsText = "StatResGNT LXX Psalms 117:1"; // example
string rawText = "LXX Genesis 1 10";                // example
string searchText = "LXX 2097 1515 189 3";          // example

int maxClipboardShow = 100;

QString getClipboardInfos()
{
    string textShown[2];
    QString greekShown[2];
    QString intro = "<b>"
                    + MainWindow::tr("Contents of the clipboards in Greek (and in a-y notation)")
                    + "</b>";
    for (int i = 0; i < 2; ++i) {
        if (text[i].empty())
            intro += "<br>" + MainWindow::tr("Clipboard %1 is empty.").arg(i + 1);
        else {
            textShown[i] = text[i];
            greekShown[i] = latinToGreek(text[i]).c_str();
            if (text[i].length() > maxClipboardShow) {
                textShown[i] = textShown[i].substr(0, maxClipboardShow) + "…";
                greekShown[i] = greekShown[i].left(maxClipboardShow) + "…";
            }
            intro += "<br>"
                     + MainWindow::tr("Clipboard %1 contains %2 (%3), length %4.")
                           .arg(i + 1)
                           .arg(QString(greekShown[i]))
                           .arg(QString(textShown[i].c_str()))
                           .arg(text[i].length());
        }
    }
    if (textset[0] && textset[1]) {
        double j = jaccard_dist(text[0], text[1]);
        intro += "<br>" + MainWindow::tr("Their Jaccard distance is %1.").arg(j);
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
    clipboardInfos->setToolTip(tr("Show information on the two clipboards."));

    QWidget *bottomFiller = new QWidget;
    bottomFiller->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

    passageInfos = new QTextEdit;
    passageInfos->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    passageInfos->setReadOnly(true); // it's preferred to not edit
    passageInfos->setToolTip(tr("Show detailed information on lookups and searches."));

    QVBoxLayout *layout = new QVBoxLayout;
    layout->setContentsMargins(5, 5, 5, 5);
    // layout->addWidget(topFiller);
    layout->addWidget(clipboardInfos);
    layout->addWidget(passageInfos);
    // layout->addWidget(bottomFiller);

    widget->setLayout(layout);
    createActions();
    createMenus();

    QString message = tr("Welcome to bibref!");
    statusBar()->showMessage(message);

    setWindowTitle("bibref");
    setMinimumSize(160, 160);
    resize(480, 320);

    ot_color = "<span style=\"color: #626600\">";
    nt_color = "<span style=\"color: #006662\">";
    reset_color = "</span>";
    error_color = "<span style=\"color: red\">";
}

void addBiblesThread(MainWindow *window)
{
    addBibles();
    QString message = MainWindow::tr("Bibles are loaded.");
    window->statusBar()->showMessage(message);
    booksAdded = true;
    window->addBiblesAct->setEnabled(false);
    window->lookup1Act->setEnabled(true);
    window->lookup2Act->setEnabled(true);
    window->lookup2Act->setEnabled(true);
    window->find1Act->setEnabled(true);
    window->find2Act->setEnabled(true);
    window->minunique1Act->setEnabled(true);
    window->extendAct->setEnabled(true);
    window->getrefsAct->setEnabled(true);
    window->rawAct->setEnabled(true);
    window->raw1Act->setEnabled(true);
    window->raw2Act->setEnabled(true);
    window->tokensAct->setEnabled(true);
    window->searchAct->setEnabled(true);
}

// Used for communication between caller and thread:
string moduleName2, moduleName1, book1, getrefsRest, verse1ST0, verse1ET0;
int getrefsStart, getrefsEnd;

void getrefsThread(MainWindow *window)
{
    try {
        // Compute...
        collect_info = "";
        extern void getrefs(const string &moduleName2,
                            const string &moduleName1,
                            const string &book1,
                            const string &verse1S,
                            int start,
                            const string &verse1E,
                            int end);
        getrefs(moduleName2, moduleName1, book1, verse1ST0, getrefsStart, verse1ET0, getrefsEnd);
        QString message = MainWindow::tr("Finished.");
        window->statusBar()->showMessage(message);

        boost::trim(collect_info);
        boost::replace_all(collect_info, "\n", "<br>");

        window->passageInfos->append(
            ("<b>Get refs " + getrefsRest + "</b>" + "<br>" + collect_info).c_str());

        QTextCursor tc = window->passageInfos->textCursor();
        tc.setPosition(window->passageInfos->document()->characterCount() - 1);
        window->passageInfos->setTextCursor(tc); // Move cursor to the end.
    } catch (exception &e) {
        window->statusBar()->showMessage("Computation error.");
        return;
    }
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
    inputDialog.setWindowTitle("Text " + QString::number(index + 1));
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
        statusBar()->showMessage(tr("Text does not contain Greek letters, ignored."));
        return; // Success, but nothing happened.
    }
    text[index] = processed; // Store result.
    textset[index] = true;   // activate clipboard

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
    inputDialog.setWindowTitle("Latin text " + QString::number(index + 1));
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
    inputDialog.setWindowTitle("Lookup");
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
    if (restSize == 3) {                                    // e.g. lookup LXX Genesis 1:1
        collect_info = "";                                  // reset communication buffer
        lookupTranslation(tokens[0], tokens[1], tokens[2]); // simple lookup via Sword
        passageInfos->append(("<b>" + rest + "</b>" + "<br>" + collect_info).c_str());

        QTextCursor tc = passageInfos->textCursor();
        tc.setPosition(passageInfos->document()->characterCount() - 1);
        passageInfos->setTextCursor(tc); // Move cursor to the end.
    } else {
        QString message = tr(
            "Invalid input (3 words are needed: Bible edition, book, chapter:verse).");
        statusBar()->showMessage(message);
    }
    return; // Success!
}

void MainWindow::tokens()
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle("Tokens");
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
        try {
            collect_info = ""; // reset communication buffer
            getTokens(tokens[0], tokens[1], tokens[2]);
            passageInfos->append(
                ("<b>" + rest + ", " + tr("tokens").toStdString() + "</b>" + "<br>" + collect_info)
                    .c_str());

            QTextCursor tc = passageInfos->textCursor();
            tc.setPosition(passageInfos->document()->characterCount() - 1);
            passageInfos->setTextCursor(tc); // Move cursor to the end.
        } catch (exception &e) {
            QString message = tr("Computation error.");
            statusBar()->showMessage(message);
        }
    } else {
        QString message = tr(
            "Invalid input (3 words are needed: Bible edition, book, chapter:verse).");
        statusBar()->showMessage(message);
    }
}

void MainWindow::search()
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle("Search");
    inputDialog.setLabelText(tr("Parameters:"));
    inputDialog.setTextValue(searchText.c_str());
    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    searchText = value.toStdString();
    string rest = searchText;

    // Taken mostly from cli:
    int index = rest.find(" ");
    string moduleName = rest.substr(0, index); // Search in the given Bible edition...
    rest = rest.substr(index + 1);

    vector<int> pattern; // the token pattern to be searched
    std::stringstream ss(rest);

    int s = 0;
    int t;
    while (ss >> t) {
        pattern.push_back(t);
        s += 1; // count the tokens in the pattern
    }
    if (s == 0) { // no pattern was defined
        statusBar()->showMessage("No pattern was defined.");
        return;
    }

    s--;
    int length = pattern.at(s); // the last parameter
    pattern.pop_back();         // remove it from the token pattern
    string info = tr("%1 tokens given, search for an extension of max. %2 tokens.")
                      .arg(s)
                      .arg(length)
                      .toStdString();
    if (length < s) { // the length must be at least the length of the pattern
        info += " " + tr("Impossible.").toStdString();
        statusBar()->showMessage(info.c_str());
    } else {
        statusBar()->showMessage(info.c_str());
        collect_info = "";                                 // reset communication buffer
        searchTokenset(moduleName, pattern, length, true); // Start search...
        passageInfos->append(
            ("<b>Search " + moduleName + " " + rest + "</b>" + "<br>" + collect_info).c_str());

        QTextCursor tc = passageInfos->textCursor();
        tc.setPosition(passageInfos->document()->characterCount() - 1);
        passageInfos->setTextCursor(tc); // Move cursor to the end.
    }
}

void MainWindow::lookupN(int index)
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle("Lookup " + QString::number(index + 1));
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
        try {                                                     // e.g. lookup1 LXX Genesis 1:1
            verse = lookupVerse(tokens[1], tokens[0], tokens[2]); // lookup in the a-y database
            text[index] = verse;                                  // Store result.
            textset[index] = true;                                // activate clipboard
            statusBar()->showMessage(tr("Stored."));
            clipboardInfos->setText(getClipboardInfos());
        } catch (exception &e) {
            statusBar()->showMessage(tr("Unsuccessful lookup."));
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
            text[index] = verse;   // Store result.
            textset[index] = true; // activate clipboard
            statusBar()->showMessage(tr("Stored."));
            clipboardInfos->setText(getClipboardInfos());
        } catch (exception &e) {
            statusBar()->showMessage(tr("Unsuccessful lookup."));
        }
        return; // Success!
    }
    statusBar()->showMessage(tr("Wrong amount of parameters is given."));
}

void MainWindow::lookup1()
{
    this->lookupN(0);
}

void MainWindow::lookup2()
{
    this->lookupN(1);
}

void MainWindow::raw()
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle("Raw");
    inputDialog.setLabelText(tr("Parameters:"));
    inputDialog.setTextValue(rawText.c_str());
    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    rawText = value.toStdString();
    string rest = rawText;

    // Mostly taken from cli:
    vector<string> tokens;
    boost::split(tokens, rest, boost::is_any_of(" "));
    int restSize = tokens.size();
    if (restSize == 4) {                // e.g. raw LXX Genesis 1 10
        string module = tokens[0];      // LXX
        string book = tokens[1];        // Genesis
        int startPos = stoi(tokens[2]); // 1
        int length = stoi(tokens[3]);   // 10
        string text = getRaw(module, book, startPos - 1, length);
        passageInfos->append(("<b>Raw " + rest + "</b>" + "<br>" + text).c_str());

        QTextCursor tc = passageInfos->textCursor();
        tc.setPosition(passageInfos->document()->characterCount() - 1);
        passageInfos->setTextCursor(tc); // Move cursor to the end.
    } else {
        QString message = tr("Wrong amount of parameters.");
        statusBar()->showMessage(message);
    }
}

void MainWindow::rawN(int index)
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle("Raw " + QString::number(index + 1));
    inputDialog.setLabelText(tr("Parameters:"));
    inputDialog.setTextValue(rawText.c_str());
    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    rawText = value.toStdString();
    string rest = rawText;

    // Mostly taken from cli:
    vector<string> tokens;
    boost::split(tokens, rest, boost::is_any_of(" "));
    int restSize = tokens.size();
    if (restSize == 4) { // e.g. raw1 LXX Genesis 1 10
        // TODO: This part is same as above. Unify.
        try {
            string module = tokens[0];                                // LXX
            string book = tokens[1];                                  // Genesis
            int startPos = stoi(tokens[2]);                           // 1
            int length = stoi(tokens[3]);                             // 10
            text[index] = getRaw(module, book, startPos - 1, length); // Obtain the raw text...
            textset[index] = true;                                    // Report the result.
            statusBar()->showMessage(tr("Stored."));
            clipboardInfos->setText(getClipboardInfos());
            return; // Success!
        } catch (exception &e) {
            statusBar()->showMessage(tr("Error in the parameters."));
            return;
        }
    } else {
        statusBar()->showMessage(tr("Wrong number of parameters."));
        return;
    }
}

void MainWindow::raw1()
{
    this->rawN(0);
}

void MainWindow::raw2()
{
    this->rawN(1);
}

QStringList getModuleNames()
{
    QStringList items;
    extern vector<Book> books;
    // This is not the best way to collect the available Bible editions,
    // because we iterate on each Bible book (for each edition).
    // It would be better to maintain the available Bible editions by storing it globally.
    for (Book book : books) {
        string moduleName = book.getModuleName();
        if (!items.contains(moduleName.c_str())) {
            items.append(moduleName.c_str());
        }
    }
    return items;
}

void MainWindow::minunique1()
{
    // Taken mostly from cli:
    if (text[0].length() == 0) {
        statusBar()->showMessage(tr("Clipboard is empty, no search possible."));
        return;
    }

    QInputDialog inputDialog;

    inputDialog.setOptions(QInputDialog::UseListViewForComboBoxItems);
    inputDialog.setComboBoxItems(getModuleNames());
    inputDialog.setWindowTitle("Min. unique 1");
    inputDialog.setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    inputDialog.setLabelText(tr("Select a Bible edition:"));
    inputDialog.setFixedSize(200, 3);

    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    string rest = value.toStdString();

    collect_info = "";

    extern vector<string> find_min_unique(string text, const string &moduleName, bool verbose);
    find_min_unique(text[0], rest, true);

    boost::trim(collect_info);
    boost::replace_all(collect_info, "\n", "<br>");

    QString translated = tr("Minimal unique subtexts of %1 in %2")
                             .arg(QString(text[0].c_str()))
                             .arg(QString(rest.c_str()));
    passageInfos->append(("<b>" + translated.toStdString() + "</b><br>" + collect_info).c_str());

    QTextCursor tc = passageInfos->textCursor();
    tc.setPosition(passageInfos->document()->characterCount() - 1);
    passageInfos->setTextCursor(tc); // Move cursor to the end.
}

void MainWindow::findN(int index)
{
    // Taken mostly from cli:
    if (text[index].length() == 0) {
        statusBar()->showMessage(tr("Clipboard is empty, no search possible."));
        return;
    }

    QInputDialog inputDialog;

    inputDialog.setOptions(QInputDialog::UseListViewForComboBoxItems);
    inputDialog.setComboBoxItems(getModuleNames());
    inputDialog.setWindowTitle("Find " + QString::number(index + 1));
    inputDialog.setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    inputDialog.setLabelText(tr("Select a Bible edition:"));
    inputDialog.setFixedSize(60, 3);

    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    string rest = value.toStdString();

    collect_info = "";

    extern int find(const string &text, const string &moduleName, int maxFound, bool verbose);
    find(text[index], rest, maxresults, true);

    boost::trim(collect_info);
    boost::replace_all(collect_info, "\n", "<br>");

    QString translated
        = tr("Searching for %1 in %2").arg(QString(text[index].c_str())).arg(QString(rest.c_str()));
    passageInfos->append(("<b>" + translated.toStdString() + "</b><br>" + collect_info).c_str());

    QTextCursor tc = passageInfos->textCursor();
    tc.setPosition(passageInfos->document()->characterCount() - 1);
    passageInfos->setTextCursor(tc); // Move cursor to the end.
}

void MainWindow::find1()
{
    this->findN(0);
}

void MainWindow::find2()
{
    this->findN(1);
}

void MainWindow::extend()
{
    QInputDialog inputDialog(this);
    inputDialog.setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    inputDialog.setFixedSize(300, 3);
    inputDialog.setWindowTitle("Extend");
    inputDialog.setLabelText(tr("Parameters:"));
    inputDialog.setTextValue(extendText.c_str());
    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    extendText = value.toStdString();
    string rest = extendText;

    // Mostly taken from cli:
    vector<string> tokens;
    boost::split(tokens, rest, boost::is_any_of(" "));
    int restSize = tokens.size();
    string moduleName1 = tokens[0]; // Old Testament
    string moduleName2 = tokens[1]; // New Testament
    string book2 = tokens[2];       // a book from the New Testament
    string verse2S, verse2E;
    if (restSize == 4) {            // e.g. extend LXX StatResGNT Romans 3:13
        verse2S = tokens[3] + "+0"; // add zero plus shift implicitly
        verse2E = tokens[3] + "-0"; // add zero minus shift implicitly
    } else if (restSize == 5) {     // e.g. extend LXX StatResGNT Romans 15:11+38 15:11-22
        verse2S = tokens[3];
        verse2E = tokens[4];
    } else {
        statusBar()->showMessage(tr("Wrong number of parameters."));
        return;
    }
    vector<string> verse2ST, verse2ET;
    int start = 0, end = 0;
    boost::split(verse2ST, verse2S, boost::is_any_of("+"));
    if (verse2ST.size() > 1) {
        start = stoi(verse2ST[1]); // read off plus shift
    }
    boost::split(verse2ET, verse2E, boost::is_any_of("-"));
    if (verse2ET.size() > 1) {
        end = stoi(verse2ET[1]); // read off minus shift
    }
    try {
        // Compute...
        collect_info = "";
        extern void extend(const string &moduleName1,
                           const string &moduleName2,
                           const string &book2,
                           const string &verse2S,
                           int start,
                           const string &verse2E,
                           int end);
        extend(moduleName1, moduleName2, book2, verse2ST[0], start, verse2ET[0], end);
        passageInfos->append(("<b>Extend " + rest + "</b>" + "<br>" + collect_info).c_str());

        QTextCursor tc = passageInfos->textCursor();
        tc.setPosition(passageInfos->document()->characterCount() - 1);
        passageInfos->setTextCursor(tc); // Move cursor to the end.
    } catch (exception &e) {
        statusBar()->showMessage(tr("Computation error."));
        return;
    }
    return; // Success!
}

void MainWindow::getrefs()
{
    QInputDialog inputDialog(this);
    inputDialog.setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    inputDialog.setFixedSize(300, 3);
    inputDialog.setWindowTitle("Get refs");
    inputDialog.setLabelText(tr("Parameters:"));
    inputDialog.setTextValue(getrefsText.c_str());
    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    getrefsText = value.toStdString();
    getrefsRest = getrefsText;

    // Mostly taken from cli:
    vector<string> tokens;
    boost::split(tokens, getrefsRest, boost::is_any_of(" "));
    int restSize = tokens.size();
    if (restSize < 3) {
        statusBar()->showMessage(tr("Wrong number of parameters."));
        return;
    }
    moduleName2 = tokens[0]; // New Testament
    moduleName1 = tokens[1]; // Old Testament
    book1 = tokens[2];       // a book from the Old Testament
    if (restSize == 3) {     // TODO: implement this
        statusBar()->showMessage(
            tr("Getting references from full books is not yet implemented, sorry."));
        return;
    }
    string verse1S, verse1E;
    if (restSize == 4) { // e.g. getrefs StatResGNT LXX Isaiah 9:2
        if (book1 == "Psalms") {
            vector<string> r;
            boost::split(r, tokens[3], boost::is_any_of(":"));
            if (r.size()
                == 1) { // only the psalm number is given, e.g. getrefs StatResGNT LXX Psalms 51
                verse1S = r[0] + ":1+0";
                try {
                    verse1E = r[0] + ":" + to_string(getPsalmLastVerse(moduleName1, stoi(r[0])))
                              + "-0";
                } catch (exception &e) {
                    statusBar()->showMessage(tr("Computation error."));
                    return;
                }
            } else { // one verse is given in the psalm, e.g. getrefs StatResGNT LXX Psalms 51:4
                verse1S = tokens[3] + "+0"; // add zero plus shift implicitly
                verse1E = tokens[3] + "-0"; // add zero minus shift implicitly
            }
        } else {                        // this is not a psalm and one verse is given
            verse1S = tokens[3] + "+0"; // add zero plus shift implicitly
            verse1E = tokens[3] + "-0"; // add zero negative shift implicitly
        }
    } else if (restSize == 5) { // e.g. getrefs StatResGNT LXX Psalms 51:4 51:5
        verse1S = tokens[3];
        verse1E = tokens[4];
    } else {
        statusBar()->showMessage(tr("Computation error."));
        return;
    }
    vector<string> verse1ST, verse1ET;
    boost::split(verse1ST, verse1S, boost::is_any_of("+"));
    if (verse1ST.size() > 1) {
        getrefsStart = stoi(verse1ST[1]); // read off plus shift
    }
    boost::split(verse1ET, verse1E, boost::is_any_of("-"));
    if (verse1ET.size() > 1) {
        getrefsEnd = stoi(verse1ET[1]); // read off minus shift
    }
    verse1ST0 = verse1ST[0];
    verse1ET0 = verse1ET[0];
    try {
        QString message = tr("Please wait...");
        statusBar()->showMessage(message);
        QFuture<void> future = QtConcurrent::run(getrefsThread, this);
    } catch (exception &e) {
        statusBar()->showMessage(tr("Computation error."));
        return;
    }
    return; // Success!
}

void MainWindow::about()
{
    QMessageBox::about(
        this,
        tr("About bibref") + " (" + BIBREF_VERSION + ")",
        tr("<a href=\"https://github.com/kovzol/bibref\">bibref</a> is a tool that helps "
           "discovering internal references in the Bible."
           "<br>It aims at finding quotations of the <a "
           "href=\"https://en.wikipedia.org/wiki/Septuagint\">Septuagint</a>"
           " in the <a href=\"https://en.wikipedia.org/wiki/New_Testament\">Greek New Testament</a>"
           " in a mechanical way."));
}

void setWindowLogo(QWidget *widget)
{
    if (std::filesystem::exists(PROJECT_SOURCE_DIR "/" LOGO_FILE))
        widget->setWindowIcon(QIcon(PROJECT_SOURCE_DIR "/" LOGO_FILE));
    else if (std::filesystem::exists(INSTALL_PREFIX "/" SHARE_FOLDER "/" LOGO_FILE))
        widget->setWindowIcon(QIcon(INSTALL_PREFIX "/" SHARE_FOLDER "/" LOGO_FILE));
    else
        widget->setWindowIcon(QIcon(SHARE_FOLDER "/" LOGO_FILE));
}

void MainWindow::aboutSword()
{
    // Avoid showing bibref's logo inside the window (which is the default for about boxes)...
    QWidget *widget = new QWidget;
    setWindowLogo(widget);

    QTextBrowser *aboutText = new QTextBrowser;
    QVBoxLayout *layout = new QVBoxLayout;
    layout->setContentsMargins(5, 5, 5, 5);
    aboutText->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    aboutText->setOpenExternalLinks(true);
    layout->addWidget(aboutText);

    QString aboutContent
        = tr("<a href=\"https://www.crosswire.org/sword/index.jsp\">The SWORD Project</a> is an "
             "effort to create an ever-expanding software package "
             "for research and study of God and His Word. The SWORD Project framework "
             "allows easy use and study of Bible texts, commentaries, lexicons, "
             "dictionaries, and other books. Many frontends are built using this framework. "
             "An installed set of books may be shared among all frontends using the framework.")
          + "<br><br>"
          + tr("This program uses version %1 of the SWORD library.")
                .arg(QString(SWVersion().currentVersion));
    aboutText->setText(aboutContent);
    widget->setLayout(layout);
    widget->setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    widget->setFixedSize(400, 200);
    widget->setWindowTitle(tr("About SWORD"));
    widget->show();
}

void MainWindow::tutorial()
{
    QWidget *widget = new QWidget;
    setWindowLogo(widget);

    QVBoxLayout *layout = new QVBoxLayout;
    layout->setContentsMargins(5, 5, 5, 5);

    QTextBrowser *tutorialText = new QTextBrowser;
    tutorialText->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    tutorialText->setOpenExternalLinks(true);
    layout->addWidget(tutorialText);

    QString tutorialContent
        = "<h2>" + tr("Introduction") + "</h2>"
          + tr("This Bible study tool offers work on texts that are close to "
               "the oldest manuscripts. Since there are no punctuation "
               "(spaces, commas, periods) in the old texts, and there is no "
               "verse numbering, we consider each book of a Bible edition "
               "as a continuous raw text of Greek characters from α to ω. "
               "(To simplify working with texts, Greek characters are transcribed to "
               "latin characters a-y.)")
          + "<br>"
          + tr("A Bible edition is defined as an old compilation of books "
               "that are considered canonical. Definitely, we work "
               "with a set of Old Testament books, translated into Greek "
               "and presented as the electronic version of the Septuagint, "
               "identified with the name <a "
               "href=\"https://www.crosswire.org/sword/modules/ModInfo.jsp?modName=LXX\">LXX</a>. "
               "Also, a set of Greek New Testament books are present, identified with the name "
               "<a "
               "href=\"https://www.crosswire.org/sword/modules/"
               "ModInfo.jsp?modName=StatResGNT\">StatResGNT</a>.")
          + "<br>"
          + tr("Research questions like <i>Is an Old Testament passage quoted properly?</i> "
               "can be studied with this program. Non-punctuated texts can be "
               "compared without loading Bible databases. Also, if the default databases "
               "are loaded (via File&gt;Add books…), Greek Bible texts can also "
               "be compared directly.")
          + "<br>"
          + tr("The program is command-driven. Its graphical user interface follows "
               "the conventions of the terminal based application. Therefore, the commands "
               "provided by the menus are literally the same as in the terminal based "
               "application and not translated into other languages, either.")
          + "<h2>" + tr("Example uses") + "</h2>" + "<ol><li>"
          + tr("In Romans 2:21 Paul seems to quote the Law. "
               "In the program in menu Passage&gt;Lookup… the user types <b>KJV Romans 2:21</b> "
               "to check the English version of the text, and similarly, "
               "<b>StatResGNT Romans 2:21</b> to get the Greek version. "
               "(Importantly, the modules KJV and StatResGNT need to be installed by the system "
               "administrator in advance. See Help&gt;Show available Bibles… for your options in "
               "simple lookups.) "
               "By doing the same for Romans 2:22, Exodus 20:14 and 20:15, the "
               "user decides to compare the Greek texts <b>ου μοιχευσεις ου κλεψεις</b> "
               "and <b>κλεπτεις ο λεγων μη μοιχευειν μοιχευεις</b>. These should copied and "
               "pasted in Edit&gt;Text 1… and Edit&gt;Text 2… After then, "
               "the program informs the user that the two texts have a Jaccard distance "
               "near 0.63 (which is a substantial distance).")
          + "</li>" + "<li>"
          + tr("The words κλεψεις and κλεπτεις are similar. In the a-y transcription "
               "they are shown as <b>kleceis</b> and <b>klepteis</b>. "
               "The user may want to enter these words with their a-y transcriptions "
               "in Edit&gt;Latin Text 1… and Edit&gt;Latin Text 2… "
               "Their Jaccard distance is near 0.42 (which is a bit closer).")
          + "</li>" + "<li>"
          + tr(
              "Now, the user loads the indexed Bibles via File&gt;Add books… Several features "
              "of the program can be used from now on. For example, the user can put "
              "the a-y transcription of a part of Psalms 40:13-17 and 70:1-5 in the two "
              "clipboards. "
              "(Note that these texts are numbered as 40:14-18 and 70:1-6 in some Bible editions.) "
              "This is achievable via Passage&gt;Lookup 1… and Passage&gt;Lookup 2… by typing "
              "<b>LXX Psalms 40:13+23 40:17</b> and <b>LXX Psalms 70:1+37 70:5</b>, respectively. "
              "This notation allows to cut the first 23 or 37 letters of the passages. "
              "(Analogously, appending a number with a minus sign to the end of the passage "
              "definition, "
              "it is possible to cut some of the last letters of the passages.) "
              "The Jaccard distance is near 0.19 (which means a close relationship).")
          + "</li>" + "<li>"
          + tr("The user wants to check if Exodus 20:13-17 is repeated in the Old Testament. "
               "By putting this passage in Passage&gt;Lookup 1… by typing "
               "<b>LXX Exodus 20:13 20:17</b> it is possible to start a search for an exact "
               "match via Edit&gt;Search 1… By selecting <b>LXX</b>, the program finds another "
               "match in Deuteronomy "
               "5:17-21. Book position 19880-20171 means that the second match can be found in "
               "Raw&gt;Raw… by entering <b>LXX Deuteronomy 19880 292</b> (here 292 is the "
               "length), or stored in "
               "clipboard 2 with the same input in Raw&gt;Raw 2… Here, the Jaccard distance of "
               "the texts in the clipboards is 0 (because they are identical).")
          + "</li>" + "<li>"
          + tr("The user thinks that parts of Psalm 117 are quoted somewhere in the New Testament. "
               "The command Quotation&gt;Get refs… with parameters <b>StatResGNT LXX Psalms "
               "117</b> "
               "starts a search for all possible matches where the Old Testament passage can be a "
               "unique "
               "text that is quoted in the New Testament. Among other candidates, Romans 15:11 "
               "seems to be a plausible result.")
          + "</li>" + "<li>"
          + tr("The user would like to identify the quotation mentioned by Paul "
               "in I Corinthians 1:31. This is a difficult task, so a tokenized "
               "transcription of the verse is obtained via the command Passage&gt;Tokens… with "
               "parameters <b>StatResGNT I_Corinthians 1:31</b> (note the underscore) and the "
               "tokens 2443 2531 1125 3588 2744 1722 2962 2744 are shown. (Currently, "
               "these are <a "
               "href=\"https://en.wikipedia.org/wiki/"
               "Strong%27s_Concordance#Strong's_numbers\">Strong's numbers</a>.) "
               "After checking these numbers, 2744, 1722 and 2962 seem relevant. "
               "A search via Edit&gt;Search… with parameters <b>LXX 2744 1722 2962 6</b> "
               "shows that on a length of 6 tokens there is only one match in the Old Testament, "
               "namely, in Jeremiah 9:23. Another search with parameters <b>StatResGNT 2744 1722 "
               "2962 3</b> "
               "informs the user on a second match in the New Testament, namely, in II Corinthians "
               "10:17.")
          + "</li>" + "</ol>"
          + tr("For further examples we point the reader to <a "
               "href=\"https://matek.hu/zoltan/blog-topics.php?t=b\">Zoltán Kovács's blog on "
               "bibref</a>.");

    tutorialText->setText(tutorialContent);
    widget->setLayout(layout);
    widget->setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    widget->setFixedSize(600, 400);
    widget->setWindowTitle(tr("Quick tutorial"));
    widget->show();
}

void MainWindow::showSwordBibles()
{
    collect_info = "";
    showAvailableBibles();
    // E.g.: "Available Bible versions: KJV, StatResGNT."
    int start = collect_info.find(":");
    vector<string> bibles;
    boost::split(bibles,
                 collect_info.substr(start + 2, collect_info.length() - start - 4),
                 boost::is_any_of(","));
    QStringList b;
    for (string bible : bibles) {
        b.append(QString(bible.c_str()).trimmed());
    }

    QInputDialog inputDialog;

    inputDialog.setOptions(QInputDialog::UseListViewForComboBoxItems | QInputDialog::NoButtons);
    inputDialog.setComboBoxItems(b);
    inputDialog.setWindowTitle(tr("Show available Bibles"));
    inputDialog.setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    inputDialog.setLabelText(tr("Available Bible translations:"));
    inputDialog.setFixedSize(200, 5);

    inputDialog.exec();
}

void MainWindow::aboutQt() {}

void MainWindow::createActions()
{
    addBiblesAct = new QAction("&Add books", this);
    addBiblesAct->setIcon(QIcon::fromTheme("document-new"));
    addBiblesAct->setShortcuts(QKeySequence::New);
    addBiblesAct->setStatusTip(tr("Load and index the default Bible editions"));
    connect(addBiblesAct, &QAction::triggered, this, &MainWindow::addBibles);

    exitAct = new QAction("&Quit", this);
    exitAct->setIcon(QIcon::fromTheme("application-exit"));
    exitAct->setShortcuts(QKeySequence::Quit);
    exitAct->setStatusTip(tr("Exit the application"));
    connect(exitAct, &QAction::triggered, this, &QWidget::close);

    string greekStatusTip
        = tr("Define a Greek text and put its Latin transcription in clipboard %1").toStdString();
    greekText1Act = new QAction("&Text 1…", this);
    greekText1Act->setIcon(QIcon::fromTheme("flag-gr"));
    greekText1Act->setStatusTip(tr(greekStatusTip.c_str()).arg(1));
    connect(greekText1Act, &QAction::triggered, this, &MainWindow::greekText1);

    greekText2Act = new QAction("Text 2…", this);
    greekText2Act->setIcon(QIcon::fromTheme("flag-gr"));
    greekText2Act->setStatusTip(tr(greekStatusTip.c_str()).arg(2));
    connect(greekText2Act, &QAction::triggered, this, &MainWindow::greekText2);

    string latinStatusTip = tr("Put a Latin (a-y) transcription in clipboard %1").toStdString();
    latinText1Act = new QAction("&Latin text 1…", this);
    latinText1Act->setIcon(QIcon::fromTheme("insert-text"));
    latinText1Act->setStatusTip(tr(latinStatusTip.c_str()).arg(1));
    connect(latinText1Act, &QAction::triggered, this, &MainWindow::latinText1);

    latinText2Act = new QAction("Latin text 2…", this);
    latinText2Act->setIcon(QIcon::fromTheme("insert-text"));
    latinText2Act->setStatusTip(tr(latinStatusTip.c_str()).arg(2));
    connect(latinText2Act, &QAction::triggered, this, &MainWindow::latinText2);

    string findStatusTip = tr("Search for the text of clipboard %1 in a Bible").toStdString();
    find1Act = new QAction("&Find 1…", this);
    find1Act->setIcon(QIcon::fromTheme("edit-find"));
    find1Act->setStatusTip(tr(findStatusTip.c_str()).arg(1));
    connect(find1Act, &QAction::triggered, this, &MainWindow::find1);
    find1Act->setDisabled(true);

    find2Act = new QAction("Find 2…", this);
    find2Act->setIcon(QIcon::fromTheme("edit-find"));
    find2Act->setStatusTip(tr(findStatusTip.c_str()).arg(2));
    connect(find2Act, &QAction::triggered, this, &MainWindow::find2);
    find2Act->setDisabled(true);

    minunique1Act = new QAction("&Min. unique 1…", this);
    minunique1Act->setIcon(QIcon::fromTheme("go-previous"));
    minunique1Act->setStatusTip(tr("Search for minimal unique passages in clipboard 1 in a Bible"));
    connect(minunique1Act, &QAction::triggered, this, &MainWindow::minunique1);
    minunique1Act->setDisabled(true);

    extendAct = new QAction("&Extend…", this);
    extendAct->setIcon(QIcon::fromTheme("go-next"));
    extendAct->setStatusTip(
        tr("Extend a passage to the longest possible quotation from another Bible"));
    connect(extendAct, &QAction::triggered, this, &MainWindow::extend);
    extendAct->setDisabled(true);

    getrefsAct = new QAction("&Get refs…", this);
    getrefsAct->setIcon(QIcon::fromTheme("scanner"));
    getrefsAct->setStatusTip(
        tr("Search for references in a Bible on the passage in another Bible"));
    connect(getrefsAct, &QAction::triggered, this, &MainWindow::getrefs);
    getrefsAct->setDisabled(true);

    lookupAct = new QAction("&Lookup…", this);
    lookupAct->setIcon(QIcon::fromTheme("document-open"));
    lookupAct->setStatusTip(tr("Search for a verse in a book in the given Bible"));
    connect(lookupAct, &QAction::triggered, this, &MainWindow::lookup);

    string lookupStatusTip
        = tr("Search for a passage in a book in the given Bible and put it in clipboard %1")
              .toStdString();
    lookup1Act = new QAction("Lookup &1…", this);
    lookup1Act->setStatusTip(tr(lookupStatusTip.c_str()).arg(1));
    connect(lookup1Act, &QAction::triggered, this, &MainWindow::lookup1);
    lookup1Act->setDisabled(true);

    lookup2Act = new QAction("Lookup &2…", this);
    lookup2Act->setStatusTip(tr(lookupStatusTip.c_str()).arg(2));
    connect(lookup2Act, &QAction::triggered, this, &MainWindow::lookup2);
    lookup2Act->setDisabled(true);

    tokensAct = new QAction("&Tokens…", this);
    tokensAct->setIcon(QIcon::fromTheme("view-sort-ascending"));
    tokensAct->setStatusTip(tr("Search for a tokenized verse in a book in the given Bible"));
    connect(tokensAct, &QAction::triggered, this, &MainWindow::tokens);
    tokensAct->setDisabled(true);

    searchAct = new QAction("&Search…", this);
    searchAct->setIcon(QIcon::fromTheme("view-sort-ascending"));
    searchAct->setStatusTip(tr("Search for a set of tokens on a maximal length in a Bible"));
    connect(searchAct, &QAction::triggered, this, &MainWindow::search);
    searchAct->setDisabled(true);

    rawAct = new QAction("&Raw…", this);
    rawAct->setIcon(QIcon::fromTheme("media-flash"));
    rawAct->setStatusTip(tr("Show the a-y transcription of a positioned text in a given book"));
    connect(rawAct, &QAction::triggered, this, &MainWindow::raw);
    rawAct->setDisabled(true);

    string rawStatusTip
        = tr("Put the a-y transcription of a positioned text in a given book in clipboard %1")
              .toStdString();
    raw1Act = new QAction("Raw &1…", this);
    raw1Act->setStatusTip(tr(rawStatusTip.c_str()).arg(1));
    connect(raw1Act, &QAction::triggered, this, &MainWindow::raw1);
    raw1Act->setDisabled(true);

    raw2Act = new QAction("Raw &2…", this);
    raw2Act->setStatusTip(tr(rawStatusTip.c_str()).arg(2));
    connect(raw2Act, &QAction::triggered, this, &MainWindow::raw2);
    raw2Act->setDisabled(true);

    aboutAct = new QAction(tr("About &bibref…"), this);
    aboutAct->setIcon(QIcon::fromTheme("help-about"));
    aboutAct->setStatusTip(tr("Show a short description of the program"));
    connect(aboutAct, &QAction::triggered, this, &MainWindow::about);

    aboutSwordAct = new QAction(tr("About &SWORD…"), this);
    aboutSwordAct->setStatusTip(tr("Show information on the SWORD library"));
    connect(aboutSwordAct, &QAction::triggered, this, &MainWindow::aboutSword);

    aboutQtAct = new QAction(tr("About &Qt…"), this);
    aboutQtAct->setStatusTip(tr("Show the Qt library's About box"));
    connect(aboutQtAct, &QAction::triggered, qApp, &QApplication::aboutQt);
    connect(aboutQtAct, &QAction::triggered, this, &MainWindow::aboutQt);

    tutorialAct = new QAction(tr("Quick tutorial…"), this);
    tutorialAct->setStatusTip(tr("Show a short introduction to the program"));
    connect(tutorialAct, &QAction::triggered, this, &MainWindow::tutorial);

    showAvailableBiblesAct = new QAction(tr("Show available Bibles…"), this);
    showAvailableBiblesAct->setStatusTip(tr("Show available Bibles via SWORD"));
    connect(showAvailableBiblesAct, &QAction::triggered, this, &MainWindow::showSwordBibles);
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
    editMenu->addSeparator();
    editMenu->addAction(find1Act);
    editMenu->addAction(find2Act);
    editMenu->addAction(searchAct);

    passageMenu = menuBar()->addMenu(tr("&Passage"));
    passageMenu->addAction(lookupAct);
    passageMenu->addSeparator();
    passageMenu->addAction(lookup1Act);
    passageMenu->addAction(lookup2Act);
    passageMenu->addSeparator();
    passageMenu->addAction(tokensAct);

    quotationMenu = menuBar()->addMenu(tr("&Quotation"));
    quotationMenu->addAction(minunique1Act);
    quotationMenu->addAction(extendAct);
    quotationMenu->addAction(getrefsAct);

    rawMenu = menuBar()->addMenu(tr("&Raw"));
    rawMenu->addAction(rawAct);
    rawMenu->addSeparator();
    rawMenu->addAction(raw1Act);
    rawMenu->addAction(raw2Act);

    helpMenu = menuBar()->addMenu(tr("&Help"));
    helpMenu->addAction(aboutAct);
    helpMenu->addAction(tutorialAct);
    helpMenu->addAction(showAvailableBiblesAct);
    helpMenu->addSeparator();
    helpMenu->addAction(aboutSwordAct);
    helpMenu->addAction(aboutQtAct);
}
