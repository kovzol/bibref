#include "visualizewindow.h"
#include "settings.h"

#include <QtSvg>
#include <QSvgWidget>
#include <QtWidgets>
#ifndef __EMSCRIPTEN__
#include <QWebEngineView>
#endif // __EMSCRIPTEN__

#include <iostream>
#include <string>
#include <graphviz/cdt.h>
#include <graphviz/cgraph.h>
#include <graphviz/gvc.h>
#include <graphviz/gvplugin.h>
#include <graphviz/graphviz_version.h>
#if GVPLUGIN_VERSION==8
#define GVRENDERDATA_SIZE size_t
#else
#define GVRENDERDATA_SIZE unsigned int
#endif

using namespace std;

VisualizeWindow::VisualizeWindow(QWidget *parent, string input)
    : QMainWindow(parent)
{
    this->setAttribute(::Qt::WA_DeleteOnClose);
    QSettings settings;
    bool diagramHtml = settings.value("Application/diagramHtml", defaultDiagramHtml).toBool();
    if (!diagramHtml) {
        tile = new QSvgWidget(this);
        setCentralWidget(tile);
    }

    GVC_t *gvc= gvContext();
#if defined(__MINGW32__) || defined(__APPLE__) || defined(__EMSCRIPTEN__)
    /* This seems to be required on Windows, MacOS and the WebAssembly platform, otherwise the
     * executable will not know anything about the dot format,
     * the svg export, and so on.
     * Also, in CMake's library settings these 4 dynamic libraries
     * must be included. There seems to be no official way to
     * do this elegantly.
     */
    extern gvplugin_library_t gvplugin_dot_layout_LTX_library;
    extern gvplugin_library_t gvplugin_core_LTX_library;
    gvAddLibrary(gvc, &gvplugin_dot_layout_LTX_library);
    gvAddLibrary(gvc, &gvplugin_core_LTX_library);
#ifndef __EMSCRIPTEN__ // Interestingly, Emscripten does not compile these and they are not required, either:
    extern gvplugin_library_t gvplugin_rsvg_LTX_library;
    extern gvplugin_library_t gvplugin_pango_LTX_library;
    gvAddLibrary(gvc, &gvplugin_rsvg_LTX_library);
    gvAddLibrary(gvc, &gvplugin_pango_LTX_library);
#endif // __EMSCRIPTEN__
#endif // all platforms that require such definitions

    Agraph_t *g = agmemread((char*)input.c_str());
    gvLayout(gvc, g, "dot");

#define MAX_SVG_LENGTH ((GVRENDERDATA_SIZE) 200000)
    char *svg = (char*) malloc(MAX_SVG_LENGTH);
    GVRENDERDATA_SIZE length;
    gvRenderData(gvc, g, "svg", &svg, &length);
    gvFreeLayout(gvc, g);
    agclose(g);
    gvFreeContext(gvc);
    string svg_s = string(svg);
    if (!diagramHtml) {
        tile->load(QByteArray::fromStdString(svg_s));
        tile->renderer()->setAspectRatioMode(Qt::KeepAspectRatio);
    } else {
#ifndef __EMSCRIPTEN__
        QTemporaryFile file;
        file.setFileTemplate("XXXXXX.html");
        file.setAutoRemove(false);
        if (file.open()) {
            QString fileName = file.fileName();
            file.write("<center>\n"); // This is not valid HTML, but works...
            file.write(svg_s.c_str());
            file.write("</center>\n"); // This is not valid HTML, but works...
            file.flush();
            QWebEngineView *view = new QWebEngineView(this);
            QString fn = QDir::currentPath()
                        + "/" + fileName;
            view->setUrl(QUrl::fromLocalFile(fn));
            view->resize(1000, 400);
            view->show();
            setCentralWidget(view->focusWidget());
        } // else: raise an exception, TODO
#endif // __EMSCRIPTEN__
    }
}
