#include "statementwindow.h"
#include "visualizewindow.h"

#include <QtWidgets>
#include <iostream>

#ifdef WITH_PBRST
#include <string>
#include <boost/algorithm/string/trim.hpp>
#include <boost/algorithm/string/predicate.hpp>
#include <boost/algorithm/string/split.hpp>

extern "C" char* brst_scan_string(char *string, int correct_raw, int correct_differ,
  int correct_cover, int correct_versification, int show_dump);
#include "pbrst.tab.h" // the statements folder must be included among the folders

using namespace std;
#endif

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
      if (f1.exists() && f1.isDir())
        directory = d1;
      else if (f2.exists() && f2.isDir())
        directory = d2;
      else if (f3.exists() && f3.isDir())
        directory = d3;
      else if (f4.exists() && f4.isDir())
        directory = d4;
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
    fileMenu->addAction(QIcon::fromTheme("document-open"), tr("&Open…"), QKeySequence::Open,
                        this, [this](){ openFile(); });
}

void StatementWindow::parse()
{
#ifdef WITH_PBRST
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

#endif
}

void StatementWindow::showSvg()
{
#ifdef WITH_PBRST
    auto vwindow = new VisualizeWindow(this, graphviz_input);
    // vwindow->resize(600, 400);
    vwindow->show();
    vwindow->setWindowIcon(QIcon::fromTheme("emblem-photos"));
    vwindow->setWindowTitle(tr("Visualize"));
#endif // WITH_PBRST
}

void StatementWindow::setupProveMenu()
{
#ifdef WITH_PBRST
    QMenu *proveMenu = new QMenu(tr("&Prove"), this);
    menuBar()->addMenu(proveMenu);

    proveMenu->addAction(QIcon::fromTheme("tools-check-spelling"), tr("&Parse"), QKeySequence::Forward,
                        this, &StatementWindow::parse);
#endif // WITH_PBRST
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
