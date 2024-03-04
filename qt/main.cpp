#define BIBREF_VERSION "2024Mar03"

#include <QApplication>

#include "mainwindow.h"

using namespace Qt::StringLiterals;

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
    QString projectSourceDir = PROJECT_SOURCE_DIR; // This must be set externally, currently done via cmake
    if (bibrefTranslator.load(language, projectSourceDir)) {
        app.installTranslator(&bibrefTranslator);
    }
    // FIXME: the last item should be inserted in a simpler and more flexible way.

    MainWindow window;
    window.setWindowIcon(QIcon(PROJECT_SOURCE_DIR "/logo-Psalm40-192.png"));
    window.show();
    return app.exec();
}
