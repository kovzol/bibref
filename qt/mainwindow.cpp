#include <iostream>

#include "mainwindow.h"
#include "statementwindow.h"
#include "settings.h"

#include "books.h"
#include "cli.h"
#include "main.h"

#include "swmgr.h"
#include "swversion.h"
#include "markupfiltmgr.h"

#include <boost/algorithm/string/find.hpp>
#include <boost/algorithm/string/replace.hpp>
#include <boost/algorithm/string/split.hpp>
#include <boost/algorithm/string/trim.hpp>
#include <graphviz/graphviz_version.h>

#include <QCoreApplication>
#include <QLineEdit>
#include <QThread>
#include <QtConcurrent/qtconcurrentmap.h>
#include <QtCore/qelapsedtimer.h>
#include <qtconcurrentrun.h>

using namespace std;

using namespace sword;

// These are defined in cli.cpp. FIXME: Make this common in a better way.
extern bool booksAdded;
extern string text[2];
extern vector<bool> textset;
extern string collect_info;
extern string ot_color, nt_color, reset_color, error_color;
extern char* output_prepend_set;
extern vector<string> qt_wordlist;

string lookupText = "LXX Genesis 1:1";              // example
string extendText = "LXX StatResGNT Romans 3:13";   // example
string getrefsText = "StatResGNT LXX Psalms 116:1"; // example
string rawText = "LXX Genesis 1 10";                // example
string searchText = "LXX 2097 1515 189 3";          // example

QString getClipboardInfos()
{
    QSettings settings;
    bool useKoineGreekFont = settings.value("Application/useKoineGreekFont", defaultUseKoineGreekFont).toBool();
    int maxClipboardShow = settings.value("Application/maxClipboardShow", defaultMaxClipboardShow).toInt();

    string textShown[2];
    QString greekShown[2];
    QString intro = "<b>"
                    + MainWindow::tr("Contents of the clipboards in Greek (and in a-z notation)")
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
            if (useKoineGreekFont) {
                greekShown[i] = "<span style=\"font-family:'KoineGreekBibref';\">"
                                + greekShown[i] + "</span>";
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

    passageInfos = new QTextBrowser;
    passageInfos->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    passageInfos->setToolTip(tr("Show detailed information on lookups and searches."));

    QVBoxLayout *layout = new QVBoxLayout;
    layout->setContentsMargins(5, 5, 5, 5);
    layout->addWidget(clipboardInfos);
    layout->addWidget(passageInfos);

    widget->setLayout(layout);
    createActions();
    createMenus();

    QString message = tr("Welcome to bibref!");
    statusBar()->showMessage(message);

    setWindowTitle("bibref");
    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();
    setMinimumSize(16 * size, 16 * size);
    resize(48 * size, 32 * size);

    ot_color = "<span style=\"color: #626600\">";
    nt_color = "<span style=\"color: #006662\">";
    reset_color = "</span>";
    error_color = "<span style=\"color: red\">";
    output_prepend_set = (char *)malloc(1);
    output_prepend_set[0] = '\0';
}

QStringList getAvailableBibles() {
    QStringList b;
    collect_info = "";
    showAvailableBibles();
    // E.g.: "Available Bible editions: KJV, StatResGNT."
    int start = collect_info.find(":");
    vector<string> bibles;
    boost::split(bibles,
                 collect_info.substr(start + 2, collect_info.length() - start - 4),
                 boost::is_any_of(","));
    for (string bible : bibles) {
        QString be = QString(bible.c_str()).trimmed();
        b.append(be);
    }
    return b;
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
    window->statementAct->setEnabled(true);
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
        window->moveCursorEnd(window->passageInfos);
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
    inputDialog.setToolTip(toolTipHelp("textN"));
    if (textset[index]) {
        inputDialog.setTextValue(latinToGreek(text[index]).c_str());
    }
    // inputDialog.setFont(QFont("KoineGreek")); // This would change all fonts in the whole dialog.
    // It's not what we want.

    // Only after the dialog is show()n, the QLineEdit field will be generated and it can be searched and edited.
    // Otherwise, the QLineEdit field does not exist yet and cannot be found via findChild.
    QSettings settings;
    bool useKoineGreekFont = settings.value("Application/useKoineGreekFont", defaultUseKoineGreekFont).toBool();
    if (useKoineGreekFont) {
        inputDialog.showNormal();
        QLineEdit *inputField = inputDialog.findChild<QLineEdit *>();
        inputField->setFont(QFont("KoineGreekBibref"));
    }

    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;
    string rest = value.toStdString();

    if (useKoineGreekFont) {
        // Maybe the user typed the input with a-z notation, and they are displayed
        // with the Koine font. In such cases we want to convert the user input
        // (or parts of it) into Greek.
        rest = latinToGreek(rest);
    }

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
    statusBar()->clearMessage(); // proper operation

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
    inputDialog.setToolTip(toolTipHelp("latintextN"));
    if (textset[index]) {
        inputDialog.setTextValue(text[index].c_str());
    }
    if (inputDialog.exec() != QDialog::Accepted)
        return;
    const QString value = inputDialog.textValue().trimmed();
    if (value.isEmpty())
        return;

    text[index] = "";
    for (int i = 0; i < value.length(); i++) {
        QChar c = value.at(i);
        if (c >= 'a' && c <= 'z') {
            text[index] += c.toLatin1();
        }
        if (c >= 'A' && c <= 'Z') {
            text[index] += c.toLower().toLatin1();
        }
        if (text[index].back() == 'q') {
            text[index].back() = 'z';
        }
        if (text[index].back() == 'w') {
            text[index].back() = 's';
        }
    }
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

void MainWindow::nearest12()
{
    string best_c_d = best_jaccard_substr(text[1], text[0]);
    vector<string> tokens;
    boost::split(tokens, best_c_d, boost::is_any_of(" "));
    if (tokens.size() < 2) {
        QMessageBox msgBox;
        msgBox.setText(MainWindow::tr("Both clipboards must contain at least 2 characters."));
        msgBox.setIcon(QMessageBox::Critical);
        msgBox.exec();
        return;
    }
    string message = "Nearest Jaccard distance is " + tokens[1] + " with substring " + tokens[0] + ".";
    passageInfos->append(
        ("<b>Nearest 12</b><br>" + message).c_str());
    moveCursorEnd(passageInfos);
}

QString MainWindow::toolTipHelp(std::string command)
{
    // Retrieve help syntax for the current command:
    string helpLines = getHelp(command);
    vector<string> help;
    boost::split(help, helpLines, boost::is_any_of("\n"));
    QTextDocument d;
    d.setMarkdown(tr("Syntax:") + " " + help.at(0).c_str());
    return d.toHtml();
}

void MainWindow::moveCursorEnd(QTextEdit *b)
{
    QTextCursor tc = b->textCursor();
    tc.setPosition(b->document()->characterCount() - 1);
    b->setTextCursor(tc); // Move cursor to the end.
}


void setWindowLogo(QWidget *widget)
{
    widget->setWindowIcon(QIcon(":/" LOGO_FILE));
}

void MainWindow::performLookup(QLineEdit *lookupEdit) {
    QString value = lookupEdit->text().trimmed();
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
        passageInfos->append(("<b>" + rest + "</b>").c_str());
        QSettings settings;
        bool useKoineGreekFont = settings.value("Application/useKoineGreekFont", defaultUseKoineGreekFont).toBool();
        if (useKoineGreekFont && (tokens[0] == "LXX" || tokens[0] == "StatResGNT" || tokens[0] == "SBLGNT"))
            collect_info = "<span style=\"font-family:'KoineGreekBibref';\">"
                           + collect_info + "</span><br>";
        passageInfos->append(collect_info.c_str());
        moveCursorEnd(passageInfos);
        statusBar()->clearMessage(); // proper operation
    } else {
        QString message = tr(
            "Invalid input (3 words are needed: Bible edition, book, chapter:verse).");
        statusBar()->showMessage(message);
    }

}

void MainWindow::lookup()
{
    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();

    QWidget *widget = new QWidget;
    setWindowLogo(widget);

    QLabel *lookupLabel = new QLabel(tr("Verse:"));
    lookupLabel->setToolTip(toolTipHelp("lookup"));
    lookupLabel->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Fixed);
    QLineEdit *lookupEdit = new QLineEdit(this);
    lookupEdit->setText(lookupText.c_str());
    lookupEdit->setMinimumWidth(30 * size);

    QStringList wordList = getAvailableBibles();
    for (auto word : qt_wordlist) {
        wordList.append(QString(word.c_str()));
    }
    wordList.sort();

    QCompleter *completer = new QCompleter(wordList, this);
    completer->setCaseSensitivity(Qt::CaseInsensitive);
    completer->setCompletionMode(QCompleter::InlineCompletion);
    lookupEdit->setCompleter(completer);

    buttonBox = new QDialogButtonBox(QDialogButtonBox::Ok | QDialogButtonBox::Cancel, Qt::Horizontal);

    QVBoxLayout *layout = new QVBoxLayout;
    layout->setSizeConstraint(QLayout::SetMinAndMaxSize);
    layout->addWidget(lookupLabel);
    layout->addWidget(lookupEdit);
    layout->addWidget(buttonBox);

    widget->setLayout(layout);
    widget->setWindowTitle("Lookup");

    auto escAction = new QAction(lookupEdit);
    escAction->setShortcut(Qt::Key_Escape);
    lookupEdit->addAction(escAction);

    // The widget will be finally closed unless Return is pressed.
    connect(lookupEdit, &QLineEdit::returnPressed, [=](){
        performLookup(lookupEdit);
    });
    connect(buttonBox, &QDialogButtonBox::accepted, [=]() {
        performLookup(lookupEdit);
        widget->close();
    });

    connect(escAction, &QAction::triggered, [=](){
        widget->close();
    });
    connect(buttonBox, &QDialogButtonBox::rejected, [=]() {
        widget->close();
    });

    widget->showNormal();
}

void MainWindow::tokens()
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle("Tokens");
    inputDialog.setLabelText(tr("Verse:"));
    inputDialog.setTextValue(lookupText.c_str());
    inputDialog.setToolTip(toolTipHelp("tokens"));
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
            moveCursorEnd(passageInfos);
        } catch (exception &e) {
            QString message = tr("Computation error.");
            statusBar()->showMessage(message);
        }
    } else {
        QString message = tr(
            "Invalid input (3 words are needed: Bible edition, book, chapter:verse).");
        statusBar()->showMessage(message);
    }
    statusBar()->clearMessage(); // proper operation
}

void MainWindow::search()
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle("Search");
    inputDialog.setLabelText(tr("Parameters:"));
    inputDialog.setTextValue(searchText.c_str());
    inputDialog.setToolTip(toolTipHelp("search"));
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

        boost::trim(collect_info);
        boost::replace_all(collect_info, "\n", "<br>");

        passageInfos->append(
            ("<b>Search " + moduleName + " " + rest + "</b>" + "<br>" + collect_info).c_str());
        moveCursorEnd(passageInfos);
    }
    statusBar()->clearMessage(); // proper operation
}


void MainWindow::lookupN(int index)
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle("Lookup " + QString::number(index + 1));
    inputDialog.setLabelText(tr("Verse:"));
    inputDialog.setTextValue(lookupText.c_str());
    inputDialog.setToolTip(toolTipHelp("lookupN"));
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
            verse = lookupVerse(tokens[1], tokens[0], tokens[2]); // lookup in the a-z database
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
            // Shift-allowed lookup in the a-z database...
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
    inputDialog.setToolTip(toolTipHelp("raw"));
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
        moveCursorEnd(passageInfos);
    } else {
        QString message = tr("Wrong amount of parameters.");
        statusBar()->showMessage(message);
    }
    statusBar()->clearMessage(); // proper operation
}

void MainWindow::rawN(int index)
{
    QInputDialog inputDialog(this);
    inputDialog.setWindowTitle("Raw " + QString::number(index + 1));
    inputDialog.setLabelText(tr("Parameters:"));
    inputDialog.setTextValue(rawText.c_str());
    inputDialog.setToolTip(toolTipHelp("rawN"));
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
    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();

    inputDialog.setOptions(QInputDialog::UseListViewForComboBoxItems);
    inputDialog.setComboBoxItems(getModuleNames());
    inputDialog.setWindowTitle("Min. unique 1");
    inputDialog.setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    inputDialog.setLabelText(tr("Select a Bible edition:"));
    inputDialog.setFixedSize(20 * size, 3);

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
    moveCursorEnd(passageInfos);
    statusBar()->clearMessage(); // proper operation
}

void MainWindow::findN(int index)
{
    // Taken mostly from cli:
    if (text[index].length() == 0) {
        statusBar()->showMessage(tr("Clipboard is empty, no search possible."));
        return;
    }

    QInputDialog inputDialog;
    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();

    inputDialog.setOptions(QInputDialog::UseListViewForComboBoxItems);
    inputDialog.setComboBoxItems(getModuleNames());
    inputDialog.setWindowTitle("Find " + QString::number(index + 1));
    inputDialog.setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    inputDialog.setLabelText(tr("Select a Bible edition:"));
    inputDialog.setFixedSize(6 * size, 3);

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
    moveCursorEnd(passageInfos);
    statusBar()->clearMessage(); // proper operation
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
    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();

    inputDialog.setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    inputDialog.setFixedSize(30 * size, 3);
    inputDialog.setWindowTitle("Extend");
    inputDialog.setToolTip(toolTipHelp("extend"));
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
        moveCursorEnd(passageInfos);
    } catch (exception &e) {
        statusBar()->showMessage(tr("Computation error."));
        return;
    }
    statusBar()->clearMessage(); // proper operation
    return; // Success!
}

void MainWindow::statement() {
    auto swindow = new StatementWindow();
    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();
    swindow->resize(64 * size, 50 * size);
    swindow->showNormal();
    swindow->setWindowIcon(QIcon::fromTheme("input-keyboard"));
}

void MainWindow::getrefs()
{
    QInputDialog inputDialog(this);
    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();
    inputDialog.setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    inputDialog.setFixedSize(30 * size, 3);
    inputDialog.setWindowTitle("Get refs");
    inputDialog.setToolTip(toolTipHelp("getrefs"));
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
    statusBar()->clearMessage(); // proper operation
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

void MainWindow::aboutOther()
{
    QMessageBox::about(
        this,
        tr("Technical information"),
        tr("The version %0 (%1) of the bibref program you are currently running is built with "
            "Boost %2 and GraphViz %3.")
            .arg(BIBREF_VERSION)
            .arg(QSysInfo::kernelType() + " " +
            QSysInfo::buildCpuArchitecture() + ", Qt " + QT_VERSION_STR)
            .arg(QString::fromStdString(
                to_string(BOOST_VERSION % 100) + "." + to_string(BOOST_VERSION / 100 % 1000) + "." + to_string(BOOST_VERSION / 100000)))
            .arg(PACKAGE_VERSION));
}

void MainWindow::aboutSword()
{
    // Avoid showing bibref's logo inside the window (which is the default for about boxes)...
    QWidget *widget = new QWidget;
    setWindowLogo(widget);

    QTextBrowser *aboutText = new QTextBrowser;
    QVBoxLayout *layout = new QVBoxLayout;

    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();

    layout->setContentsMargins(size / 2, size / 2, size / 2, size / 2);
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
    widget->setFixedSize(40 * size, 20 * size);
    widget->setWindowTitle(tr("About SWORD"));
    widget->showNormal();
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

    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();

    QString tutorialContent
        = "<h2>" + tr("Introduction") + "</h2>"
          + tr("This Bible study tool offers work on texts that are close to "
               "the oldest manuscripts. Since there are no punctuation "
               "(spaces, commas, periods) in the old texts, and there is no "
               "verse numbering, we consider each book of a Bible edition "
               "as a continuous raw text of Greek characters from α to ω. "
               "(To simplify working with texts, Greek characters are transcribed to "
               "latin characters a-z.)")
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
               "are loaded (via File&gt;Add books), Greek Bible texts can also "
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
               "By doing the same for Romans 2:22, and for LXX Exodus 20:13 and 20:14, the "
               "user decides to compare the Greek texts <b>ου μοιχευσεις ου κλεψεις</b> "
               "and <b>κλεπτεις ο λεγων μη μοιχευειν μοιχευεις</b>. These should be copied and "
               "pasted in Edit&gt;Text 1… and Edit&gt;Text 2… After then, "
               "the program informs the user that the two texts have a Jaccard distance "
               "near 0.63 (which is a substantial distance).")
          + "</li>" + "<li>"
          + tr("The words κλεψεις and κλεπτεις are similar. In the a-z transcription "
               "they are shown as <b>kleceis</b> and <b>klepteis</b>. "
               "The user may want to enter these words with their a-z transcriptions "
               "in Edit&gt;Latin Text 1… and Edit&gt;Latin Text 2… "
               "Their Jaccard distance is near 0.42 (which is a bit closer).")
          + "</li>" + "<li>"
          + tr(
              "Now, the user loads the indexed Bibles via File&gt;Add books. Several features "
              "of the program can be used from now on. For example, the user can put "
              "the a-z transcription of a part of Psalms 39:14-18 and 69:1-6 in the two "
              "clipboards. "
              "(Note that these texts are numbered as 40:14-18 and 70:1-6 in some Bible editions.) "
              "This is achievable via Passage&gt;Lookup 1… and Passage&gt;Lookup 2… by typing "
              "<b>LXX Psalms 39:14+23 39:18</b> and <b>LXX Psalms 69:1+37 69:6</b>, respectively. "
              "This notation allows to cut the first 23 or 37 letters of the passages. "
              "(Analogously, appending a number with a minus sign to the end of the passage "
              "definition, "
              "it is possible to cut some of the last letters of the passages.) "
              "The Jaccard distance is near 0.19 (which means a close relationship).")
          + "</li>" + "<li>"
          + tr("The user wants to check if Exodus 20:13 is repeated in the Old Testament. "
               "By putting this passage in Passage&gt;Lookup 1… by typing "
               "<b>LXX Exodus 20:13</b> it is possible to start a search for an exact "
               "match via Edit&gt;Search 1… By selecting <b>LXX</b>, the program finds another "
               "match in Deuteronomy "
               "5:17. Book position 19880-19891 means that the second match can be found in "
               "Raw&gt;Raw… by entering <b>LXX Deuteronomy 19880 12</b> (here 12 is the "
               "length), or stored in "
               "clipboard 2 with the same input in Raw&gt;Raw 2… Here, the Jaccard distance of "
               "the texts in the clipboards is 0 (because they are identical).")
          + "</li>" + "<li>"
          + tr("The user thinks that parts of Psalm 116 are quoted somewhere in the New Testament. "
               "The command Quotation&gt;Get refs… with parameters <b>StatResGNT LXX Psalms "
               "116</b> "
               "starts a search for all possible matches where the Old Testament passage can be a "
               "unique "
               "text that is quoted in the New Testament. Here, Romans 15:11 "
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
               "namely, in Jeremiah 9:22, and, among the deuterocanonical books, in Sirach 39:8. "
               "Another search with parameters <b>StatResGNT 2744 1722 2962 3</b> "
               "informs the user on a second match in the New Testament, namely, in II Corinthians "
               "10:17.")
          + "</li>" + "</ol>";

    tutorialText->setText(tutorialContent);
    widget->setLayout(layout);
    widget->setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    widget->setFixedSize(60 * size, 40 * size);
    widget->setWindowTitle(tr("Quick tutorial"));
    widget->showNormal();
}

void MainWindow::showSwordBibles()
{
    QStringList b;

    /*
    collect_info = "";
    showAvailableBibles();
    // E.g.: "Available Bible editions: KJV, StatResGNT."
    int start = collect_info.find(":");
    vector<string> bibles;
    boost::split(bibles,
                 collect_info.substr(start + 2, collect_info.length() - start - 4),
                 boost::is_any_of(","));
    for (string bible : bibles) {
        QString be = QString(bible.c_str()).trimmed();
        b.append(be);
    }
    */ // Old version, without extra information on the modules

    // Retrieving information directly via SWORD:
    SWMgr manager(new MarkupFilterMgr(FMT_XHTML));
    ModMap::iterator it;
    for (it = manager.Modules.begin(); it != manager.Modules.end(); ++it) {
        if (strcmp((*it).second->getType(), "Biblical Texts") == 0) {
            string moduleName = (*it).second->getName();
            if (moduleName == "LXX")
                moduleName= "𝗟𝗫𝗫";
            if (moduleName == "SBLGNT")
                moduleName= "𝗦𝗕𝗟𝗚𝗡𝗧";
            if (moduleName == "StatResGNT")
                moduleName= "𝗦𝘁𝗮𝘁𝗥𝗲𝘀𝗚𝗡𝗧";
            string moduleVersion = (*it).second->getConfigEntry("Version");
            string moduleDescription = (*it).second->getConfigEntry("Description");
            // Remove extra spaces:
            moduleDescription = (QString::fromStdString(moduleDescription).
                                 replace(QRegularExpression("\\s+"), QString(" "))).toStdString();
            QString be = QString(moduleName.c_str()).trimmed() + QString(" (")
                         + QString(moduleDescription.c_str()) + QString(", version ")
                         + QString(moduleVersion.c_str())
                         + QString(")");
            b.append(be);
        }
    }

    QInputDialog inputDialog;
    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();

    inputDialog.setOptions(QInputDialog::UseListViewForComboBoxItems | QInputDialog::NoButtons);
    inputDialog.setComboBoxItems(b);
    inputDialog.setWindowTitle(tr("Show available Bibles"));
    inputDialog.setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    inputDialog.setLabelText(tr("Available Bible editions:"));
    inputDialog.setFixedSize(70 * size, size * b.size() * 1.5);

    inputDialog.exec();
}

void MainWindow::webTerminal()
{
    QString link = "https://matek.hu/kovzol/bibref";
    QDesktopServices::openUrl(QUrl(link));
}

void MainWindow::wiki()
{
    QString link = "https://github.com/kovzol/bibref/wiki";
    QDesktopServices::openUrl(QUrl(link));
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

    string latinStatusTip = tr("Put a Latin (a-z) transcription in clipboard %1").toStdString();
    latinText1Act = new QAction("&Latin text 1…", this);
    latinText1Act->setIcon(QIcon::fromTheme("insert-text"));
    latinText1Act->setStatusTip(tr(latinStatusTip.c_str()).arg(1));
    connect(latinText1Act, &QAction::triggered, this, &MainWindow::latinText1);

    latinText2Act = new QAction("Latin text 2…", this);
    latinText2Act->setIcon(QIcon::fromTheme("insert-text"));
    latinText2Act->setStatusTip(tr(latinStatusTip.c_str()).arg(2));
    connect(latinText2Act, &QAction::triggered, this, &MainWindow::latinText2);

    string nearest12StatusTip
        = tr("Find the nearest subtext of clipboard 1 to clipboard 2").toStdString();
    nearest12Act = new QAction("Nearest 12", this);
    nearest12Act->setIcon(QIcon::fromTheme("go-down"));
    nearest12Act->setStatusTip(tr(nearest12StatusTip.c_str()));
    connect(nearest12Act, &QAction::triggered, this, &MainWindow::nearest12);

    string findStatusTip = tr("Search for the text of clipboard %1 in a Bible").toStdString();
    find1Act = new QAction("&Find 1…", this);
    find1Act->setIcon(QIcon::fromTheme("edit-find"));
    find1Act->setStatusTip(tr(findStatusTip.c_str()).arg(1));
    connect(find1Act, &QAction::triggered, this, &MainWindow::find1);
#ifndef __APPLE__
    find1Act->setDisabled(true);
#endif

    find2Act = new QAction("Find 2…", this);
    find2Act->setIcon(QIcon::fromTheme("edit-find"));
    find2Act->setStatusTip(tr(findStatusTip.c_str()).arg(2));
    connect(find2Act, &QAction::triggered, this, &MainWindow::find2);
#ifndef __APPLE__
    find2Act->setDisabled(true);
#endif

    minunique1Act = new QAction("&Min. unique 1…", this);
    minunique1Act->setIcon(QIcon::fromTheme("go-previous"));
    minunique1Act->setStatusTip(tr("Search for minimal unique passages in clipboard 1 in a Bible"));
    connect(minunique1Act, &QAction::triggered, this, &MainWindow::minunique1);
#ifndef __APPLE__
    minunique1Act->setDisabled(true);
#endif

    extendAct = new QAction("&Extend…", this);
    extendAct->setIcon(QIcon::fromTheme("go-next"));
    extendAct->setStatusTip(
        tr("Extend a passage to the longest possible quotation from another Bible"));
    connect(extendAct, &QAction::triggered, this, &MainWindow::extend);
#ifndef __APPLE__
    extendAct->setDisabled(true);
#endif

    getrefsAct = new QAction("&Get refs…", this);
    getrefsAct->setIcon(QIcon::fromTheme("scanner"));
    getrefsAct->setStatusTip(
        tr("Search for references in a Bible on the passage in another Bible"));
    connect(getrefsAct, &QAction::triggered, this, &MainWindow::getrefs);
#ifndef __APPLE__
    getrefsAct->setDisabled(true);
#endif

    statementAct = new QAction("&Statement…", this);
    statementAct->setIcon(QIcon::fromTheme("input-keyboard"));
    statementAct->setStatusTip(
        tr("Open a text editor to edit a statement"));
    connect(statementAct, &QAction::triggered, this, &MainWindow::statement);
#ifndef __APPLE__
    statementAct->setDisabled(true);
#endif

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
#ifndef __APPLE__
    lookup1Act->setDisabled(true);
#endif

    lookup2Act = new QAction("Lookup &2…", this);
    lookup2Act->setStatusTip(tr(lookupStatusTip.c_str()).arg(2));
    connect(lookup2Act, &QAction::triggered, this, &MainWindow::lookup2);
#ifndef __APPLE__
    lookup2Act->setDisabled(true);
#endif

    tokensAct = new QAction("&Tokens…", this);
    tokensAct->setIcon(QIcon::fromTheme("view-sort-ascending"));
    tokensAct->setStatusTip(tr("Search for a tokenized verse in a book in the given Bible"));
    connect(tokensAct, &QAction::triggered, this, &MainWindow::tokens);
#ifndef __APPLE__
    tokensAct->setDisabled(true);
#endif

    searchAct = new QAction("&Search…", this);
    searchAct->setIcon(QIcon::fromTheme("view-sort-ascending"));
    searchAct->setStatusTip(tr("Search for a set of tokens on a maximal length in a Bible"));
    connect(searchAct, &QAction::triggered, this, &MainWindow::search);
#ifndef __APPLE__
    searchAct->setDisabled(true);
#endif

    preferencesAct = new QAction(tr("Pr&eferences…"), this);
    preferencesAct->setIcon(QIcon::fromTheme("preferences-desktop-font"));
    preferencesAct->setStatusTip(tr("Set preferences in the application"));
    connect(preferencesAct, &QAction::triggered, this, &MainWindow::preferences);

    rawAct = new QAction("&Raw…", this);
    rawAct->setIcon(QIcon::fromTheme("media-flash"));
    rawAct->setStatusTip(tr("Show the a-z transcription of a positioned text in a given book"));
    connect(rawAct, &QAction::triggered, this, &MainWindow::raw);
#ifndef __APPLE__
    rawAct->setDisabled(true);
#endif

    string rawStatusTip
        = tr("Put the a-z transcription of a positioned text in a given book in clipboard %1")
              .toStdString();
    raw1Act = new QAction("Raw &1…", this);
    raw1Act->setStatusTip(tr(rawStatusTip.c_str()).arg(1));
    connect(raw1Act, &QAction::triggered, this, &MainWindow::raw1);
#ifndef __APPLE__
    raw1Act->setDisabled(true);
#endif

    raw2Act = new QAction("Raw &2…", this);
    raw2Act->setStatusTip(tr(rawStatusTip.c_str()).arg(2));
    connect(raw2Act, &QAction::triggered, this, &MainWindow::raw2);
#ifndef __APPLE__
    raw2Act->setDisabled(true);
#endif

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
    // connect(aboutQtAct, &QAction::triggered, this, &MainWindow::aboutQt);

    aboutOtherAct = new QAction(tr("Technical information…"), this);
    aboutOtherAct->setStatusTip(tr("Show information on other libraries used in bibref"));
    connect(aboutOtherAct, &QAction::triggered, this, &MainWindow::aboutOther);

    tutorialAct = new QAction(tr("Quick tutorial…"), this);
    tutorialAct->setIcon(QIcon::fromTheme("system-help"));
    tutorialAct->setStatusTip(tr("Show a short introduction to the program"));
    connect(tutorialAct, &QAction::triggered, this, &MainWindow::tutorial);

    wikiAct = new QAction(tr("Wiki…"), this);
    wikiAct->setIcon(QIcon::fromTheme("help-contents"));
    wikiAct->setStatusTip(tr("Open documentation of the program in a web browser"));
    connect(wikiAct, &QAction::triggered, this, &MainWindow::wiki);

    showAvailableBiblesAct = new QAction(tr("Show available Bibles…"), this);
    showAvailableBiblesAct->setIcon(QIcon::fromTheme("system-file-manager"));
    showAvailableBiblesAct->setStatusTip(tr("Show available Bibles via SWORD"));
    connect(showAvailableBiblesAct, &QAction::triggered, this, &MainWindow::showSwordBibles);

    webTerminalAct = new QAction(tr("Start bibref in a web &terminal"), this);
    webTerminalAct->setIcon(QIcon::fromTheme("utilities-terminal"));
    webTerminalAct->setStatusTip(tr("Start a web version of bibref in a web based terminal"));
    connect(webTerminalAct, &QAction::triggered, this, &MainWindow::webTerminal);
}

void MainWindow::createMenus()
{
    fileMenu = menuBar()->addMenu(tr("&File"));
    fileMenu->addAction(addBiblesAct);
#ifndef __EMSCRIPTEN__ // Don't show exit action in the web version
    fileMenu->addSeparator();
    fileMenu->addAction(exitAct);
#endif

    editMenu = menuBar()->addMenu(tr("&Edit"));
    editMenu->addAction(greekText1Act);
    editMenu->addAction(greekText2Act);
    editMenu->addAction(latinText1Act);
    editMenu->addAction(latinText2Act);
    editMenu->addAction(nearest12Act);
    editMenu->addSeparator();
    editMenu->addAction(find1Act);
    editMenu->addAction(find2Act);
    editMenu->addAction(searchAct);
    editMenu->addSeparator();
    editMenu->addAction(preferencesAct);

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
    quotationMenu->addSeparator();
    quotationMenu->addAction(statementAct);

    rawMenu = menuBar()->addMenu(tr("&Raw"));
    rawMenu->addAction(rawAct);
    rawMenu->addSeparator();
    rawMenu->addAction(raw1Act);
    rawMenu->addAction(raw2Act);

    helpMenu = menuBar()->addMenu(tr("&Help"));
    helpMenu->addAction(aboutAct);
    helpMenu->addAction(tutorialAct);
    helpMenu->addAction(wikiAct);
    helpMenu->addAction(showAvailableBiblesAct);
    helpMenu->addAction(webTerminalAct);
    helpMenu->addSeparator();
    helpMenu->addAction(aboutSwordAct);
    helpMenu->addAction(aboutQtAct);
    helpMenu->addAction(aboutOtherAct);
}

void MainWindow::preferences()
{
    QWidget *widget = new QWidget;
    setWindowLogo(widget);

    QSettings settings;
    QString lang = settings.value("Application/language", "").toString();
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();
    bool debug = settings.value("Application/debug", defaultDebug).toBool();
    bool diagramHtml = settings.value("Application/diagramHtml", defaultDiagramHtml).toBool();
    bool useKoineGreekFont = settings.value("Application/useKoineGreekFont",
        defaultUseKoineGreekFont).toBool();
    bool tooltipsGreek = settings.value("Application/tooltipsGreek",
                                            defaultTooltipsGreek).toBool();
    int maxClipboardShow = settings.value("Application/maxClipboardShow", defaultMaxClipboardShow).toInt();

    QVBoxLayout *layout = new QVBoxLayout;
    layout->setContentsMargins(size / 2, size / 2, size / 2,  size / 2);

    QHBoxLayout *hlayout = new QHBoxLayout;

    /* Language: */
    QLabel *languageLabel = new QLabel(tr("Application language:"));
    string languageTip
        = tr("Set the language used in the application")
              .toStdString();
    languageLabel->setToolTip(languageTip.c_str());
    QComboBox *languageCombo = new QComboBox(this);
    languageCombo->addItem(tr("System default")); // 0
    languageCombo->addItem("English"); // 1
    languageCombo->addItem("German (deutsch)"); // 2
    languageCombo->addItem("Hungarian (magyar)"); // 3
    if (lang == "")
        languageCombo->setCurrentIndex(0);
    if (lang == "en")
        languageCombo->setCurrentIndex(1);
    if (lang == "de")
        languageCombo->setCurrentIndex(2);
    if (lang == "hu")
        languageCombo->setCurrentIndex(3);
    hlayout->addWidget(languageLabel);
    hlayout->addWidget(languageCombo);
    hlayout->addStretch(1);
    layout->addLayout(hlayout, 1);

    /* Font size: */
    QLabel *fontSizeLabel = new QLabel(tr("Font size:"));
    string fontSizeTip
        = tr("Set general font size in the application (default: %1)")
              .toStdString();
    fontSizeLabel->setToolTip(tr(fontSizeTip.c_str()).arg(defaultFontSize));
    QLineEdit *fontSizeEdit = new QLineEdit(this);
    fontSizeEdit->setText(QString::number(size));
    fontSizeEdit->setMaxLength(3);
    // fontSizeEdit->setInputMask("000");
    hlayout = new QHBoxLayout;
    hlayout->addWidget(fontSizeLabel);
    hlayout->addWidget(fontSizeEdit);
    hlayout->addStretch(1);
    layout->addLayout(hlayout, 1);
    // widget->setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    // widget->setFixedSize(30 * size, 10 * size);

    /* Show debug in Analyze: */
    QLabel *debugLabel = new QLabel(tr("Debug mode:"));
    string debugTip
        = tr("Show debug messages in the Analyze window")
              .toStdString();
    debugLabel->setToolTip(tr(debugTip.c_str()));
    QCheckBox *debugCheckbox = new QCheckBox(this);
    debugCheckbox->setChecked(debug);
    hlayout = new QHBoxLayout;
    hlayout->addWidget(debugLabel);
    hlayout->addWidget(debugCheckbox);
    hlayout->addStretch(1);
    layout->addLayout(hlayout, 1);

    /* Show diagram as HTML/SVG: */
    QLabel *diagramHtmlLabel = new QLabel(tr("Diagram as HTML/SVG:"));
    string diagramHtmlTip
        = tr("Show visualized diagram as HTML/SVG")
              .toStdString();
    diagramHtmlLabel->setToolTip(tr(diagramHtmlTip.c_str()));
    QCheckBox *diagramHtmlCheckbox = new QCheckBox(this);
    diagramHtmlCheckbox->setChecked(diagramHtml);
#ifndef USE_WEBENGINE
    diagramHtmlCheckbox->setChecked(false);
    diagramHtmlCheckbox->setEnabled(false); // This does not work at the moment.
#endif // USE_WEBENGINE
    hlayout = new QHBoxLayout;
    hlayout->addWidget(diagramHtmlLabel);
    hlayout->addWidget(diagramHtmlCheckbox);
    hlayout->addStretch(1);
    layout->addLayout(hlayout, 1);

    /* Use Koine Greek font: */
    QLabel *useKoineGreekFontLabel = new QLabel(tr("Use Koine Greek font:"));
    string useKoineGreekFontTip
        = tr("Show Greek text with Koine Greek font whenever possible")
              .toStdString();
    useKoineGreekFontLabel->setToolTip(tr(useKoineGreekFontTip.c_str()));
    QCheckBox *useKoineGreekFontCheckbox = new QCheckBox(this);
    useKoineGreekFontCheckbox->setChecked(useKoineGreekFont);
    hlayout = new QHBoxLayout;
    hlayout->addWidget(useKoineGreekFontLabel);
    hlayout->addWidget(useKoineGreekFontCheckbox);
    hlayout->addStretch(1);
    layout->addLayout(hlayout, 1);

    /* Show tooltips in Greek: */
    QLabel *tooltipsGreekLabel = new QLabel(tr("Tooltips in Greek:"));
    string tooltipsGreekTip
        = tr("Show tooltips in Greek in the visualized outputs")
              .toStdString();
    tooltipsGreekLabel->setToolTip(tr(tooltipsGreekTip.c_str()));
    QCheckBox *tooltipsGreekCheckbox = new QCheckBox(this);
    tooltipsGreekCheckbox->setChecked(tooltipsGreek);
    hlayout = new QHBoxLayout;
    hlayout->addWidget(tooltipsGreekLabel);
    hlayout->addWidget(tooltipsGreekCheckbox);
    hlayout->addStretch(1);
    layout->addLayout(hlayout, 1);

    /* Maximal size of clipboard to show: */
    QLabel *clipboardSizeLabel = new QLabel(tr("Maximal shown size of clipboard:"));
    string clipboardSizeTip
        = tr("Set maximal shown size of the clipboard (default: %1)")
              .toStdString();
    clipboardSizeLabel->setToolTip(tr(clipboardSizeTip.c_str()).arg(defaultMaxClipboardShow));
    QLineEdit *clipboardSizeEdit = new QLineEdit(this);
    clipboardSizeEdit->setText(QString::number(maxClipboardShow));
    clipboardSizeEdit->setMaxLength(6);
    hlayout = new QHBoxLayout;
    hlayout->addWidget(clipboardSizeLabel);
    hlayout->addWidget(clipboardSizeEdit);
    hlayout->addStretch(1);
    layout->addLayout(hlayout, 1);

    /* End of settings. */
    widget->setLayout(layout);
    // widget->setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
    // widget->setFixedSize(30 * size, 10 * size);
    widget->setWindowTitle(tr("Preferences"));

    buttonBox = new QDialogButtonBox(QDialogButtonBox::Ok);

    connect(buttonBox, &QDialogButtonBox::accepted, [=]() {
        QSettings settings;
        int langIndex = languageCombo->currentIndex();
        QString newlang;
        switch (langIndex) {
        case 0: newlang = "";
            break;
        case 1: newlang = "en";
            break;
        case 2: newlang = "de";
            break;
        case 3: newlang = "hu";
            break;
        }
        setLanguage(newlang);
        settings.setValue("Application/language", newlang);
        if (lang != newlang) {
            QMessageBox::information(this, tr("Information"),
                                     tr("Please restart the application to change the language in the whole program."));
        }

        int size = fontSizeEdit->text().toInt();
        if (size > 0) { // do not save any nonsense values
            settings.setValue("Application/fontsize", size);
        }
        bool debug = debugCheckbox->isChecked();
        settings.setValue("Application/debug", debug);
        bool diagramHtml = diagramHtmlCheckbox->isChecked();
        settings.setValue("Application/diagramHtml", diagramHtml);
        bool useKoineGreekFont = useKoineGreekFontCheckbox->isChecked();
        settings.setValue("Application/useKoineGreekFont", useKoineGreekFont);
        bool tooltipsGreek = tooltipsGreekCheckbox->isChecked();
        settings.setValue("Application/tooltipsGreek", tooltipsGreek);
        int maxClipboardSize = clipboardSizeEdit->text().toInt();
        if (maxClipboardSize > 0) { // do not save any nonsense values
            settings.setValue("Application/maxClipboardShow", maxClipboardSize);
        }

        QFont f = qApp->font();
        f.setPointSize(size);
        qApp->setFont(f);
        widget->close();
        clipboardInfos->setText(getClipboardInfos()); // update
    });

    layout->addWidget(buttonBox);

    widget->showNormal();
}
