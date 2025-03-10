#include <iostream>

#include "statementwindow.h"
#include "visualizewindow.h"
#include "settings.h"
#include "descriptions.h"

#include <QtWidgets>

#include <string>
#include <boost/algorithm/string/trim.hpp>
#include <boost/algorithm/string/predicate.hpp>
#include <boost/algorithm/string/split.hpp>

extern "C" char* brst_scan_string(char *string, int correct_raw, int correct_differ,
  int correct_cover, int correct_versification, int show_dump);

using namespace std;

StatementWindow::StatementWindow(QWidget *parent)
    : QMainWindow(parent)
{
    this->setAttribute(::Qt::WA_DeleteOnClose);
    setupFileMenu();
    setupProveMenu();
    setupHelpMenu();
    setupEditor();

    setCentralWidget(editor);
    setWindowTitle(tr("Statement Editor"));
    setMessage();
}

void StatementWindow::setMessage()
{
    QTextCursor c = editor->textCursor();
    int col = c.positionInBlock() + 1;
    int row = c.blockNumber() + 1;
    statusBar()->showMessage(tr("Line: %1, Col: %2").arg(row).arg(col), 0);
}

void StatementWindow::setPosition()
{
    QTextCursor c = editor->textCursor();
    auto const elements = sender()->objectName().split('_');
    int row = elements.at(1).toInt();
    int col = elements.at(2).toInt();
    c.movePosition(QTextCursor::Start, QTextCursor::MoveAnchor);
    c.movePosition(QTextCursor::NextBlock, QTextCursor::MoveAnchor, row - 1);
    // select the line until the column appearing in the report
    c.movePosition(QTextCursor::Right, QTextCursor::KeepAnchor, col - 1);
    editor->setTextCursor(c);
    editor->setFocus(Qt::OtherFocusReason);
    // std::cout << row << " " << col << endl;
    setMessage();
}

StatementWindow::~StatementWindow() {
    QSettings settings;
    settings.setValue("Statements/text", editor->toPlainText());
    // std::cout << "destructor " << (editor->toPlainText()).toStdString() << endl;
}

void StatementWindow::newFile()
{
    editor->clear();
}

void StatementWindow::openFile(const QString &path)
{
    QString fileName = path;
    if (directory.isEmpty()) {
      directory = qApp -> applicationDirPath();
      QString d1 = directory + QDir::separator() + "statements";
      const QFileInfo f1(d1);
      QString d2 = directory + QDir::separator() + ".." + QDir::separator() + "statements";
      const QFileInfo f2(d2);
      QString d3 = directory + QDir::separator() + ".." + QDir::separator()
        + ".." + QDir::separator() + "statements";
      const QFileInfo f3(d3);
      QString d4 = directory + QDir::separator() + ".." + QDir::separator()
        + "share" + QDir::separator() + "statements";
      const QFileInfo f4(d4);
      QString d5 = directory + QDir::separator() + ".." + QDir::separator()
        + "Resources" + QDir::separator() + "statements";
      const QFileInfo f5(d5);
      if (f1.exists() && f1.isDir())
        directory = d1;
      else if (f2.exists() && f2.isDir())
        directory = d2;
      else if (f3.exists() && f3.isDir())
        directory = d3;
      else if (f4.exists() && f4.isDir())
        directory = d4;
      else if (f5.exists() && f5.isDir())
        directory = d5;
      }

    if (fileName.isNull()) {
        fileName = QFileDialog::getOpenFileName(this, tr("Open File"), directory, tr("bibref statement files (*.brst)"));
        QString basename = QUrl(fileName).fileName();
        directory = fileName;
        directory.remove(basename);
        }

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
    QSettings settings;
    font.setPointSize(settings.value("Application/fontsize", defaultFontSize).toInt());

    editor = new QTextEdit;
    editor->setFont(font);

    highlighter = new Highlighter(editor->document());

    // Set default value if unset:
    if (settings.value("Statements/text").isNull())
        settings.setValue("Statements/text", QString("") + "Statement Matthew-1,23 connects\n" +
                                                 " SBLGNT Matthew 1:23 1:23-34 (1922-1994) with\n" +
                                                 " LXX Isaiah 7:14+35 7:14 (14234-14304) based on\n" +
                                                 "  introduction 1:22 1:22 (1856-1921) a-y form toytodeolongegoneninaplhrvuhtorhuenypokyrioydiatoyprofhtoylegontos that\n" +
                                                 "   declares a quotation with 'το ρηθεν υπο κυριου ... λεγοντος' also\n" +
                                                 "   identifies the source with 'δια του προφητου' moreover\n" +
                                                 "  fragment 1:23 1:23-34 (1922-1994, length 73) a-y form idoyhparuenosengastriejeikaitejetaiyionkaikalesoysintoonomaaytoyemmanoyhl\n" +
                                                 "   matches LXX Isaiah 7:14+35 7:14 (14234-14304, length 71) a-y form idoyhparuenosengastriejeikaitejetaiyionkaikaleseistoonomaaytoyemmanoyhl\n" +
                                                 "    unique in Old Testament\n" +
                                                 "   differing by 8.33%\n" +
                                                 "  providing an overall cover of 100.00%.");
    QString statement = settings.value("Statements/text").toString();
    editor->setPlainText(statement);

    connect(editor, SIGNAL(cursorPositionChanged()), this, SLOT(setMessage()));
}

void StatementWindow::setupFileMenu()
{
    QMenu *fileMenu = new QMenu(tr("&File"), this);
    menuBar()->addMenu(fileMenu);

    fileMenu->addAction(QIcon::fromTheme("document-new"), tr("&New"), QKeySequence::New,
                        this, &StatementWindow::newFile);
    fileMenu->addAction(QIcon::fromTheme("document-open"), tr("&Open…"), QKeySequence::Open,
                        this, [this](){ openFile(); });
}

void StatementWindow::parse()
{
    char* output = brst_scan_string((char*)editor->toPlainText().toStdString().c_str(), 0, 0, 0, 0, 0);
    string output_s(output);
    vector<string> statementAnalysis;
    boost::split(statementAnalysis, output_s, boost::is_any_of("\n"));

    int infos = 0, warnings = 0, errors = 0;
    QString details;
    bool dmode = false;
    graphviz_input = "";
    bool diagram_defined = false;

    for (auto l: statementAnalysis) {
        if (l.find(": info: ")!=string::npos)
            infos++;
        if (l.find(": warning: ")!=string::npos)
            warnings++;
        if (l.find(": error: ")!=string::npos)
            errors++;
        if (l.find(": debug: ")==string::npos &&
            l.find("diagram: graphviz: ")==string::npos && !dmode) {
            details += QString::fromStdString(l);
            details += "\n";
            }
        if (l.find("diagram: graphviz: end")!=string::npos) {
            dmode = false;
        }
        if (dmode) {
            graphviz_input += l + "\n";
        }
        if (l.find("diagram: graphviz: start")!=string::npos) {
            dmode = true;
            diagram_defined = true;
        }
    }

    QMessageBox msgBox;
    msgBox.setWindowTitle(tr("Parse"));
    msgBox.setText(tr("%1 successful tests, %2 warnings, %3 errors.").arg(infos).arg(warnings).arg(errors));
    QPushButton* visualizeButton;
    QPushButton* visualizeXButton;
    QPushButton* backButton = msgBox.addButton(tr("Back to &Editor"), QMessageBox::RejectRole);
    if (!diagram_defined) {
        msgBox.setIcon(QMessageBox::Critical);
    } else {
        if (warnings>0) {
            msgBox.setIcon(QMessageBox::Warning);
        } else {
            msgBox.setIcon(QMessageBox::Information);
        }
        if (diagram_defined) {
            visualizeButton = msgBox.addButton(tr("&Visualize"), QMessageBox::ActionRole);
            visualizeXButton = msgBox.addButton(tr("E&xport graph"), QMessageBox::ActionRole);
        }
    }

    msgBox.setDetailedText(details);

    QSpacerItem* horizontalSpacer = new QSpacerItem(500, 0, QSizePolicy::Minimum, QSizePolicy::Expanding);
    QGridLayout* layout = (QGridLayout*)msgBox.layout();
    layout->addItem(horizontalSpacer, layout->rowCount(), 0, 1, layout->columnCount());

    int ret = msgBox.exec();

    if (msgBox.clickedButton() == visualizeButton) {
        showSvg();
    }
    if (msgBox.clickedButton() == visualizeXButton) {
        QString link = "https://dreampuf.github.io/GraphvizOnline/?engine=dot#";
        link += QUrl::toPercentEncoding(QString::fromStdString(graphviz_input));
        QDesktopServices::openUrl(QUrl(link));
    }
}

void StatementWindow::analyze()
{
    char* output = brst_scan_string((char*)editor->toPlainText().toStdString().c_str(), 0, 0, 0, 0, 0);
    string output_s(output);
    vector<string> statementAnalysis;
    boost::split(statementAnalysis, output_s, boost::is_any_of("\n"));

    int lines = statementAnalysis.size(); // this is probably more what we need
    // since diagram lines will be included in this way (and we don't want that, see below)

    QWidget *widget = new QWidget;
    widget->setWindowTitle(tr("Analyze"));
    widget->setWindowIcon(QIcon::fromTheme("utilities-system-monitor"));

    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();
    bool debug = settings.value("Application/debug", defaultDebug).toBool();

    QVBoxLayout *layout = new QVBoxLayout;
    layout->setContentsMargins(size / 2, size / 2, size / 2,  size / 2);

    t = new QTableWidget(lines, 5, this);
    int infos = 0, warnings = 0, errors = 0, debugs = 0;
    QString details;
    bool dmode = false;

    int j = 0;
    for (auto l: statementAnalysis) {
        bool store = false;
        QString color;
        if (l.find(": info: ")!=string::npos) {
            infos++;
            store = true;
        }
        if (l.find(": warning: ")!=string::npos) {
            warnings++;
            store = true;
            color = "orange";
        }
        if (l.find(": error: ")!=string::npos) {
            errors++;
            store = true;
            color = "red";
        }
        if (debug && l.find(": debug: ")!=string::npos &&
            l.find("diagram: graphviz: ")==string::npos) {
            debugs++;
            store = true;
            color = "darkcyan";
        }
        if (l.find("diagram: graphviz: end")!=string::npos) {
            dmode = false;
        }
        if (l.find("diagram: graphviz: start")!=string::npos) {
            dmode = true;
        }
        if (store) {
            int row, col;
            std::sscanf(l.c_str(), "%d,%d: ", &row, &col);

            // Fix col:
            QTextCursor c = editor->textCursor();
            c.movePosition(QTextCursor::Start, QTextCursor::MoveAnchor);
            c.movePosition(QTextCursor::NextBlock, QTextCursor::MoveAnchor, row - 1);
            for (int i = 0; i < col - 1; i++) {
                c.movePosition(QTextCursor::Right, QTextCursor::MoveAnchor);
                c.movePosition(QTextCursor::Left, QTextCursor::KeepAnchor); // select the ith character
                QString character = c.selectedText();
                bool containsNonASCII = character.contains(QRegularExpression(QStringLiteral("[^\\x{0000}-\\x{007F}]")));
                if (containsNonASCII) col--; // this is counted twice by flex/bison, but only once by Qt
                c.movePosition(QTextCursor::Right, QTextCursor::MoveAnchor);
            }
            // Col is fixed now.

            vector<string> line;
            boost::split(line, l, boost::is_any_of(":"));
            string type = line.at(1).substr(1);
            string message;
            for (int i = 2; i < line.size(); i++) {
                message += line.at(i);
                if (i < line.size() - 1)
                    message += ":";
            }
            message = message.substr(1);
            if (boost::ends_with(message, "syntax error"))
                message += " E22";
            QLabel *messageLabel = new QLabel();
            // Check if there is additional key to some info at the end of the message
            QRegularExpression pattern = QRegularExpression(" [EWI][0-9]+");
            QRegularExpressionMatch match = pattern.match(QString::fromStdString(message));
            if (match.hasMatch()) {
                string key = match.captured(0).toStdString().substr(1) + " ";
                message = message.substr(0, message.length() - key.length()); // remove key from message
                for (auto info : descriptions) {
                    if (boost::starts_with(info, key)) {
                        // Show the additional info as tooltip:
                        messageLabel->setToolTip("<html><head/><body><p>" +
                            QString::fromStdString(info.substr(key.length())) +
                            "</p></body></html>"); // force HTML to have multiple lines
                        QString color;
                        if (key.at(0) == 'E') color = "pink";
                        if (key.at(0) == 'W') color = "#FFD580";
                        if (key.at(0) == 'I') color = "lightgreen";
                        messageLabel->setStyleSheet("QToolTip {border-width:2px; border-style:solid;"
                            "background-color:" + color + "; max-width:700px}");
                    }
                }
            }
            messageLabel->setText(QString(message.c_str()));
            messageLabel->setMargin(2);

            QLabel *typeLabel = new QLabel(QString(type.c_str()));
            typeLabel->setAlignment(Qt::AlignCenter);
            typeLabel->setStyleSheet("QLabel { color : " + color + " ; }");
            QLabel *rowLabel = new QLabel(QString::number(row));
            rowLabel->setAlignment(Qt::AlignCenter);
            QLabel *columnLabel = new QLabel(QString::number(col));
            columnLabel->setAlignment(Qt::AlignCenter);
            QCommonStyle style;
            QPushButton *b = new QPushButton(style.standardIcon(QStyle::SP_ArrowRight), "");
            b->setObjectName(QString{"rc_%1_%2"}.arg(row).arg(col));
            connect(b, SIGNAL(clicked()), this, SLOT(setPosition()));

            t->setCellWidget(j, 0, typeLabel);
            t->setCellWidget(j, 1, rowLabel);
            t->setCellWidget(j, 2, columnLabel);
            t->setCellWidget(j, 3, b);
            t->setCellWidget(j, 4, messageLabel);
            t->setHorizontalHeaderLabels({tr("Type"), tr("Row"), tr("Col"), tr("Source"), tr("Message") });
            t->setColumnWidth(0, 7 * size);
            t->setColumnWidth(1, 4 * size);
            t->setColumnWidth(2, 4 * size);
            t->setColumnWidth(4, 32 * size);
            t->setColumnWidth(3, 5 * size);
            j++; // count the wanted lines
        }
    }
    t->setRowCount(j); // remove unnecessary lines
    t->horizontalHeader()->setStretchLastSection(true);

    layout->addWidget(t);
    widget->setLayout(layout);
    widget->resize(57 * size, 32 * size);

    widget->show();
}


void StatementWindow::showSvg()
{
    auto vwindow = new VisualizeWindow(this, graphviz_input);
    QSettings settings;
    int size = settings.value("Application/fontsize", defaultFontSize).toInt();
    vwindow->resize(30 * size, 15 * size); // this should be refined
    vwindow->show();
    vwindow->setWindowIcon(QIcon::fromTheme("emblem-photos"));
    vwindow->setWindowTitle(tr("Visualize"));
}

void StatementWindow::setupProveMenu()
{
    QMenu *proveMenu = new QMenu(tr("&Prove"), this);
    menuBar()->addMenu(proveMenu);

    proveMenu->addAction(QIcon::fromTheme("tools-check-spelling"), tr("&Parse"), QKeySequence::Forward,
                        this, &StatementWindow::parse);
    proveMenu->addAction(QIcon::fromTheme("utilities-system-monitor"), tr("&Analyze"), this, &StatementWindow::analyze);
}

void StatementWindow::setupHelpMenu()
{
    QMenu *helpMenu = new QMenu(tr("&Help"), this);
    menuBar()->addMenu(helpMenu);

    helpMenu->addAction(QIcon::fromTheme("system-help"), tr("&Blog entry"), this,
                        [this]() {
                            QString link = "https://matek.hu/zoltan/blog-20250102.php";
                            QDesktopServices::openUrl(QUrl(link)); });
}
