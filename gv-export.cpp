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

string gv_export(string input, const char* format)
{
    GVC_t *gvc = gvContext();
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

    char *output = nullptr;
    GVRENDERDATA_SIZE length;
    string output_s;
    if (gvRenderData(gvc, g, format, &output, &length) == 0) {
        output_s.assign(output, length);
        gvFreeRenderData(output);
    }
    gvFreeLayout(gvc, g);
    agclose(g);
    gvFreeContext(gvc);
    return output_s;
}
