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

using namespace std;

VisualizeWindow::VisualizeWindow(QWidget *parent, string input)
    : QMainWindow(parent)
{
    this->setAttribute(::Qt::WA_DeleteOnClose);
    tile = new QSvgWidget(this);
    setCentralWidget(tile);
    GVC_t *gvc= gvContext();
    Agraph_t *g = agmemread((char*)input.c_str());
    gvLayout(gvc, g, "dot");
#define MAX_SVG_LENGTH ((unsigned int) 200000)
    char *svg = (char*) malloc(MAX_SVG_LENGTH);
    unsigned int length;
    gvRenderData(gvc, g, "svg", &svg, &length);
    gvFreeLayout(gvc, g);
    agclose(g);
    (gvFreeContext(gvc));
    string svg_s = string(svg);
    tile->load(QByteArray::fromStdString(svg_s));
}

