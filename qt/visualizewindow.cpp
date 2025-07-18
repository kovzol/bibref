#ifndef __EMSCRIPTEN__
#include "visualizewindow.h"

#include <QtSvg>
#include <QSvgWidget>
#include <QtWidgets>

#include <cstdio>
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
    tile = new QSvgWidget(this);
    setCentralWidget(tile);

    GVC_t *gvc= gvContext();
#if defined(__MINGW32__) || defined(__APPLE__)
    /* This seems to be required on Windows and MacOS, otherwise the
     * executable will not know anything about the dot format,
     * the svg export, and so on.
     * Also, in CMake's library settings these 4 dynamic libraries
     * must be included. There seems to be no official way to
     * do this elegantly.
     */
    extern gvplugin_library_t gvplugin_dot_layout_LTX_library;
    extern gvplugin_library_t gvplugin_rsvg_LTX_library;
    extern gvplugin_library_t gvplugin_core_LTX_library;
    extern gvplugin_library_t gvplugin_pango_LTX_library;
    gvAddLibrary(gvc, &gvplugin_dot_layout_LTX_library);
    gvAddLibrary(gvc, &gvplugin_rsvg_LTX_library);
    gvAddLibrary(gvc, &gvplugin_core_LTX_library);
    gvAddLibrary(gvc, &gvplugin_pango_LTX_library);
#endif

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
    tile->load(QByteArray::fromStdString(svg_s));
    tile->renderer()->setAspectRatioMode(Qt::KeepAspectRatio);
}

#endif // __EMSCRIPTEN__
