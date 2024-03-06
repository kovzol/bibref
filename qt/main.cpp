#define BIBREF_VERSION "2024Mar04"

#include <QApplication>

#include "mainwindow.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setApplicationName("bibref");
    QCoreApplication::setApplicationVersion(BIBREF_VERSION);
    // QCoreApplication::setOrganizationName("Zoltán Kovács");
    // QCoreApplication::setOrganizationDomain("kovzol.github.io");
    QApplication app(argc, argv);

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
    else
        qmDir = INSTALL_PREFIX "/share/bibref-qt/"; // This must be set externally, currently done via cmake
    if (bibrefTranslator.load(language, qmDir)) {
        app.installTranslator(&bibrefTranslator);
    }
    // FIXME: the last item should be inserted in a simpler and more flexible way.

    MainWindow window;
    // Put the application logo on the window:
    if (std::filesystem::exists(PROJECT_SOURCE_DIR "/logo-Psalm40-192.png"))
        window.setWindowIcon(QIcon(PROJECT_SOURCE_DIR "/logo-Psalm40-192.png"));
    else
        window.setWindowIcon(QIcon(INSTALL_PREFIX "/share/bibref-qt/logo-Psalm40-192.png"));

    // Set working directory to home if XDG standards are used (e.g., for flatpak):
    char *home = std::getenv("XDG_DATA_HOME");
    if (home)
       std::filesystem::current_path(std::getenv("XDG_DATA_HOME"));
    window.show();
    return app.exec();
}
