cmake_minimum_required(VERSION 3.16)
project(bibref-qt LANGUAGES CXX C)

set(BIBREF_ADDBOOKS_CACHE_FOLDER "${CMAKE_CURRENT_SOURCE_DIR}/../bibref-addbooks-cache" CACHE STRING
 "Set the previously created bibref-addbooks-cache folder for the Emscripten build")
set(HTML_BUILD_DIR html-output CACHE STRING
 "Set the output folder for the Emscripten build")
option(WEBENGINE "Use QtWebEngine to show diagrams in HTML/SVG format directly" OFF)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Concurrent SvgWidgets)

set(QTWEBENGINEWIDGETS "") # default
if(WEBENGINE)
find_package(Qt6 REQUIRED COMPONENTS WebEngineWidgets)
add_definitions(-DUSE_WEBENGINE)
set(QTWEBENGINEWIDGETS "Qt6::WebEngineWidgets")
endif(WEBENGINE)

find_package(PkgConfig REQUIRED)
pkg_check_modules(sword REQUIRED sword)

if(EMSCRIPTEN)
find_library(SWORD_LIB NAMES libsword.a)

find_library(gvc_LIB NAMES libgvc.a)
find_library(gvpr_LIB NAMES libgvpr.a)
find_library(gvplugin_dot_layout_LIB NAMES libgvplugin_dot_layout.a PATHS "$ENV{EMSDK}/upstream/emscripten/cache/sysroot/lib/graphviz")
find_library(gvplugin_core_LIB NAMES libgvplugin_core.a PATHS "$ENV{EMSDK}/upstream/emscripten/cache/sysroot/lib/graphviz")
find_library(cdt_LIB NAMES libcdt.a)
find_library(cgraph_LIB NAMES libcgraph.a)
find_library(xdot_LIB NAMES libxdot.a)
find_library(pathplan_LIB NAMES libpathplan.a)

set(CMAKE_CXX_FLAGS "-sUSE_BOOST_HEADERS -sUSE_ZLIB")
endif(EMSCRIPTEN)

find_package(Qt6LinguistTools)
file(GLOB TRANSLATION_FILES ${CMAKE_CURRENT_SOURCE_DIR}/*.ts)
set_source_files_properties(${TRANSLATION_FILES}
    PROPERTIES OUTPUT_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}")
if(EMSCRIPTEN)
else()
  qt6_add_translation(QM_FILES ${TRANSLATION_FILES})
endif(EMSCRIPTEN)

set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost CONFIG COMPONENTS system filesystem)

if (EMSCRIPTEN)
else()
  pkg_check_modules(gvc REQUIRED libgvc)
endif(EMSCRIPTEN)

if(MINGW)
    find_package(ICU REQUIRED uc in)
    find_package(LibLZMA REQUIRED)
    find_package(ZLIB REQUIRED)
    find_package(BZip2 REQUIRED)
endif(MINGW)

if(APPLE) # sword may be difficult to locate and readline seems to have trouble on MacOS
find_library(sword NAMES sword
 HINTS "/usr/local/lib" "${CMAKE_SOURCE_DIR}/sword-1.9.0/lib/.libs"
 "${CMAKE_SOURCE_DIR}/../sword-1.9.0/lib/.libs"
)
else()
# One needs readline >= 8.0 to make this work:
if (EMSCRIPTEN)
else()
  pkg_check_modules (readline REQUIRED readline)
endif(EMSCRIPTEN)
endif()

include_directories(${sword_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS} ${readline_INCLUDE_DIRS} ${gvc_INCLUDE_DIRS})

# This works when Qt >= 6.3:
# qt_standard_project_setup()
# Otherwise, with Qt <= 6.2 this is required:
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

add_definitions(-DPROJECT_SOURCE_DIR="${PROJECT_SOURCE_DIR}"
    -DINSTALL_PREFIX="${CMAKE_INSTALL_PREFIX}")

set(PARSER_DIR "${CMAKE_CURRENT_BINARY_DIR}")
find_package(FLEX 2.6 REQUIRED)
find_package(BISON 3.0 REQUIRED)

set(LEXER_OUT "${PARSER_DIR}/pbrst.c")
set(PARSER_OUT "${PARSER_DIR}/pbrst.tab.c")

flex_target(LEXER "${CMAKE_CURRENT_SOURCE_DIR}/../statements/pbrst.l" "${LEXER_OUT}")
bison_target(PARSER "${CMAKE_CURRENT_SOURCE_DIR}/../statements/pbrst.y" "${PARSER_OUT}"
  COMPILE_FLAGS -vd DEFINES_FILE "${PARSER_DIR}/pbrst.tab.h")
add_flex_bison_dependency(LEXER PARSER)

include_directories(${PARSER_DIR} "${CMAKE_CURRENT_SOURCE_DIR}/..")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DYYDEBUG=1")

SET(PBRST_SRCS
 books-wrapper.cpp books-wrapper.h
 fingerprint-wrapper.cpp fingerprint-wrapper.h
 "${LEXER_OUT}" "${PARSER_OUT}"
)

# set the Application icon, the first line is the property added to Info.plist
set(MACOSX_BUNDLE_ICON_FILE bibref-qt.icns)
set(bibref_qt_ICON ${CMAKE_CURRENT_SOURCE_DIR}/logo-Psalm40-256.icns)
set_source_files_properties(${bibref_qt_ICON} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")

qt_add_executable(bibref-qt MACOSX_BUNDLE
    main.cpp main.h
    mainwindow.cpp mainwindow.h
    statementwindow.cpp statementwindow.h
    highlighter.cpp highlighter.h
    visualizewindow.cpp visualizewindow.h
    book.cpp book.h
    books.cpp books.h
    cli.cpp cli.h
    settings.h descriptions.h
    fingerprint.cpp fingerprint.h
    psalmsinfo.cpp psalmsinfo.h
    ${PBRST_SRCS}
    # ${QM_FILES} # this is handled via bibref.qrc
    bibref.qrc
    ${bibref_qt_ICON}
    editor.h editor.cpp
)

set_target_properties(bibref-qt PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

if(MINGW OR APPLE)
SET(EXTRA_LIBS -lgvplugin_dot_layout -lgvplugin_rsvg -lgvplugin_core -lgvplugin_pango)
endif(MINGW OR APPLE)

if(APPLE)
set(sword_LIBRARIES_folder "-L/usr/local/lib") # this is hardcoded (via configure/make install), FIXME
# GraphViz's plugins are located in a subfolder:
set(graphviz_LIBRARIES_folder "-L/opt/homebrew/lib -L/opt/homebrew/lib/graphviz -L/usr/local/lib -L/usr/local/lib/graphviz")
# On GitHub Actions, this folder is located elsewhere than on usual installations of homebrew. FIXME
# On macOS, the QT libraries are usually not installed into the system library folders...
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
endif()

if(EMSCRIPTEN)
target_link_libraries(bibref-qt PRIVATE
  Qt6::Core
  Qt6::Gui
  Qt6::Widgets
  Qt6::Concurrent
  Qt6::SvgWidgets
  # Qt6::WebEngineWidgets # or ${QTWEBENGINEWIDGETS}, maybe it will be supported in the future...
  ${SWORD_LIB} ${Boost_LIBRARIES}
  ${gvc_LIB} ${gvpr_LIB} ${cdt_LIB} ${cgraph_LIB} ${xdot_LIB} ${pathplan_LIB}
  ${gvplugin_dot_layout_LIB} ${gvplugin_core_LIB}
)
target_link_options(bibref-qt PUBLIC -sSINGLE_FILE -sALLOW_MEMORY_GROWTH -O3 -fexceptions -sASYNCIFY -O3 -flto)
target_link_options(bibref-qt PUBLIC "SHELL:
  --preload-file '$ENV{HOME}/.sword@/'")
target_link_options(bibref-qt PUBLIC "SHELL:
  --preload-file '${BIBREF_ADDBOOKS_CACHE_FOLDER}@/bibref-addbooks-cache'")
target_link_options(bibref-qt PUBLIC "SHELL:
  --preload-file '${CMAKE_SOURCE_DIR}/../statements/StatResGNT@statements/StatResGNT'")
target_link_options(bibref-qt PUBLIC "SHELL:
  --preload-file '${CMAKE_SOURCE_DIR}/../statements/SBLGNT@statements/SBLGNT'")
add_custom_command(TARGET bibref-qt POST_BUILD COMMAND cp "${CMAKE_SOURCE_DIR}/qtlogo.svg" ${CMAKE_BINARY_DIR})

install(TARGETS bibref-qt DESTINATION "${CMAKE_BINARY_DIR}/${HTML_BUILD_DIR}")
install(FILES ${CMAKE_BINARY_DIR}/bibref-qt.data ${CMAKE_BINARY_DIR}/bibref-qt.html ${CMAKE_SOURCE_DIR}/qtlogo.svg
  ${CMAKE_BINARY_DIR}/qtloader.js DESTINATION "${CMAKE_BINARY_DIR}/${HTML_BUILD_DIR}")

else()
target_link_libraries(bibref-qt PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    Qt6::Concurrent
    Qt6::SvgWidgets
    ${QTWEBENGINEWIDGETS}
    ${sword_LIBRARIES} ${Boost_LIBRARIES} ${readline_LIBRARIES}
    ${ICU_LIBRARIES} ${LIBLZMA_LIBRARIES} ${ZLIB_LIBRARIES} ${BZIP2_LIBRARIES}
    ${gvc_LIBRARIES} ${EXTRA_LIBS} ${sword_LIBRARIES_folder} ${graphviz_LIBRARIES_folder}
)

# If not set, XDG_DATA_HOME is set to $HOME:
if(NOT DEFINED ENV{XDG_DATA_HOME})
    set(ENV{XDG_DATA_HOME} $ENV{HOME})
endif(NOT DEFINED ENV{XDG_DATA_HOME})

# Create Sword modules from the bundle:
install(
 CODE " set(ENV{SWORD_PATH} \"$ENV{XDG_DATA_HOME}/.sword\") "
 CODE " execute_process (COMMAND bash -c \"test -r \\\"$SWORD_PATH/mods.d/lxx.conf\\\" || unzip -d $ENV{XDG_DATA_HOME} ${CMAKE_SOURCE_DIR}/../sword-lxx-sblgnt-statresgnt-kjv-fallback.zip\") "
)

# Copy executable:
install(TARGETS bibref-qt DESTINATION bin)

# Copy translations and logo:
install(FILES ${QM_FILES} ../logo-Psalm40-192.png DESTINATION share/bibref-qt)

# Create desktop icon:
install(FILES ../logo-Psalm40-128.png DESTINATION share/icons/hicolor/128x128/apps RENAME io.github.kovzol.bibref.png)
install(FILES ../logo-Psalm40-192.png DESTINATION share/icons/hicolor/192x192/apps RENAME io.github.kovzol.bibref.png)
install(FILES ../logo-Psalm40-256.png DESTINATION share/icons/hicolor/256x256/apps RENAME io.github.kovzol.bibref.png)

# Copy other freedesktop standard files:
install(FILES io.github.kovzol.bibref.desktop DESTINATION share/applications)
install(FILES io.github.kovzol.bibref.metainfo.xml DESTINATION share/metainfo)

# Copy statements:
install(DIRECTORY ../statements/SBLGNT/ DESTINATION share/bibref-qt/statements/SBLGNT PATTERN "all" EXCLUDE)
install(DIRECTORY ../statements/StatResGNT/ DESTINATION share/bibref-qt/statements/StatResGNT PATTERN "all" EXCLUDE)

endif(EMSCRIPTEN)
