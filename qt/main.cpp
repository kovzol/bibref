#include <QApplication>

#include "mainwindow.h"

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
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
    window.show();
    return app.exec();
}
