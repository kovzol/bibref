#include <QApplication>

#include "main.h"
#include "mainwindow.h"
#include "settings.h"

#include <iostream>

using namespace std;

void copyPath(QString src, QString dst)
{
    QDir dir(src);
    if (! dir.exists())
        return;

    foreach (QString d, dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot)) {
        QString dst_path = dst + QDir::separator() + d;
        dir.mkpath(dst_path);
        copyPath(src+ QDir::separator() + d, dst_path);
    }

    foreach (QString f, dir.entryList(QDir::Files)) {
        QFile::copy(src + QDir::separator() + f, dst + QDir::separator() + f);
    }
}

// This copies the SWORD modules bundle (assumed in Contents/Resources/sword/ on macOS
// or in sword/ on Windows) to the user's ~/.sword folder
// (or to the user's AppData/Roaming/.sword folder on Windows).
void copy_sword_files() {
#if defined(__APPLE__) or defined(__MINGW32__)
    QString userHome = QDir::homePath();
    QString d1 = userHome + QDir::separator();
#if defined(__MINGW32__)
    d1 += QString("AppData") + QDir::separator() + QString("Roaming") + QDir::separator();
#endif
    d1 += QString(".sword");
    const QFileInfo f1(d1);
    if (f1.exists() && f1.isDir()) {
      cout << d1.toStdString() << " exists, no changes will be made" << endl;
      return;
      }
    QString appDirectory = qApp -> applicationDirPath();
    QString d2 = appDirectory;
#if defined(__APPLE__)
    d2 += QDir::separator() + QString("..") + QDir::separator() + "Resources";
#endif // __APPLE__
    d2 += QDir::separator() + QString("sword");
    const QFileInfo f2(d2);
    if (f2.exists() && f2.isDir()) {
      cout << d1.toStdString() << " does not exist, creating it from bundle" << endl;
      // copyAndReplaceFolderContents(d2, d1, false);
      copyPath(d2,d1);
      }
    else {
      cout << d2.toStdString() << " does not exist, expect problems" << endl;
      }
#endif // __APPLE__ || __MINGW32__
}

int defaultFontSize;
bool defaultDebug;
bool defaultUseKoineGreekFont;
bool defaultTooltipsGreek;
int defaultMaxClipboardShow;

int main(int argc, char *argv[])
{
    QCoreApplication::setApplicationName("bibref");
    QCoreApplication::setApplicationVersion(BIBREF_VERSION);
    QCoreApplication::setOrganizationName("Zoltán Kovács");
    QCoreApplication::setOrganizationDomain("kovzol.github.io");
    QApplication app(argc, argv);
    app.setStyle("fusion");

    defaultFontSize = 9;
    defaultDebug = false;
    defaultUseKoineGreekFont = true;
    defaultMaxClipboardShow = 100;

    QFont f = app.font();
    QSettings settings;
    if (settings.contains("Application/fontsize")) {
        int size = settings.value("Application/fontsize", defaultFontSize).toInt();
        f.setPointSize(size);
        app.setFont(f);
    }

    QString language = QLocale::system().name();
    // language = "hu_HU";
    QTranslator qtTranslator;
    if (qtTranslator.load("qt_" + language,
                          QLibraryInfo::path(QLibraryInfo::TranslationsPath))) {
        app.installTranslator(&qtTranslator);
    }
    QTranslator qtBaseTranslator;
    if (qtBaseTranslator.load("qtbase_" + language,
                              QLibraryInfo::path(QLibraryInfo::TranslationsPath))) {
        app.installTranslator(&qtBaseTranslator);
    }
    QTranslator bibrefTranslator;
    QString qmDir;
    if (std::filesystem::exists(PROJECT_SOURCE_DIR "/hu.qm"))
        qmDir = PROJECT_SOURCE_DIR; // This must be set externally, currently done via cmake
    else if (std::filesystem::exists(INSTALL_PREFIX "/" SHARE_FOLDER "/hu.qm"))
        qmDir = INSTALL_PREFIX // This must be set externally, currently done via cmake
            "/" SHARE_FOLDER;
    else
        qmDir = SHARE_FOLDER; // for relative path (when extracted from a .zip)
    if (bibrefTranslator.load(language, qmDir)) {
        app.installTranslator(&bibrefTranslator);
    }
    // FIXME: the last item should be inserted in a simpler and more flexible way.

    MainWindow window;
    // Put the application logo on the window:
    if (std::filesystem::exists(PROJECT_SOURCE_DIR "/" LOGO_FILE))
        window.setWindowIcon(QIcon(PROJECT_SOURCE_DIR "/" LOGO_FILE));
    else if (std::filesystem::exists(INSTALL_PREFIX "/" SHARE_FOLDER "/" LOGO_FILE))
        window.setWindowIcon(QIcon(INSTALL_PREFIX "/" SHARE_FOLDER "/" LOGO_FILE));
    else
        window.setWindowIcon(QIcon(SHARE_FOLDER "/" LOGO_FILE));

    // Set working directory to home if XDG standards are used (e.g., for flatpak):
    char *home = std::getenv("XDG_DATA_HOME");
    if (home)
       std::filesystem::current_path(std::getenv("XDG_DATA_HOME"));
    copy_sword_files();
#ifdef __APPLE__
    // Set current working directory to Resources to have direct access to the cache:
    QString workingDirectory = qApp -> applicationDirPath();
    QString d1 = workingDirectory + QDir::separator() + ".." + QDir::separator() + "Resources";
    QDir::setCurrent(d1);
#endif // __APPLE__

    int koineGreekFont = QFontDatabase::addApplicationFont(":/KoineGreekBibref.ttf");
    if (koineGreekFont != -1) {
        std::cout << "Koine Greek font loaded" << endl;
    }

    window.showNormal();
    return app.exec();
}
