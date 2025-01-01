cmake_minimum_required(VERSION 3.16)
project(bibref-qt LANGUAGES CXX C)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Concurrent SvgWidgets)

find_package(PkgConfig REQUIRED)
pkg_check_modules(sword REQUIRED sword)

find_package(Qt6LinguistTools)
file(GLOB TRANSLATION_FILES ${CMAKE_CURRENT_SOURCE_DIR}/*.ts)
set_source_files_properties(${TRANSLATION_FILES}
    PROPERTIES OUTPUT_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}")
qt6_add_translation(QM_FILES ${TRANSLATION_FILES})

set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost CONFIG COMPONENTS system filesystem)

pkg_check_modules(gvc REQUIRED libgvc)

if(MINGW)
    find_package(ICU REQUIRED uc in)
    find_package(LibLZMA REQUIRED)
    find_package(ZLIB REQUIRED)
    find_package(BZip2 REQUIRED)
endif(MINGW)

pkg_check_modules (readline REQUIRED readline)

include_directories(${sword_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS} ${readline_INCLUDE_DIRS} ${gvc_INCLUDE_DIRS})

# This works when Qt >= 6.3:
# qt_standard_project_setup()
# Otherwise, with Qt <= 6.2 this is required:
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

add_definitions(-DPROJECT_SOURCE_DIR="${PROJECT_SOURCE_DIR}"
    -DINSTALL_PREFIX="${CMAKE_INSTALL_PREFIX}")

if(PBRST)
add_compile_definitions(WITH_PBRST)

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
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DYYDEBUG=1 -DIN_BIBREF")

SET(PBRST_SRCS
 books-wrapper.cpp books-wrapper.h
 fingerprint-wrapper.cpp fingerprint-wrapper.h
 "${LEXER_OUT}" "${PARSER_OUT}"
)

endif(PBRST)

qt_add_executable(bibref-qt
    main.cpp
    mainwindow.cpp mainwindow.h
    statementwindow.cpp statementwindow.h
    highlighter.cpp highlighter.h
    visualizewindow.cpp visualizewindow.h
    book.cpp book.h
    books.cpp books.h
    cli.cpp cli.h
    fingerprint.cpp fingerprint.h
    psalmsinfo.cpp psalmsinfo.h
    ${PBRST_SRCS}
    ${QM_FILES}
    bibref.qrc
)

set_target_properties(bibref-qt PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(bibref-qt PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    Qt6::Concurrent
    Qt6::SvgWidgets
    ${sword_LIBRARIES} ${Boost_LIBRARIES} ${readline_LIBRARIES}
    ${ICU_LIBRARIES} ${LIBLZMA_LIBRARIES} ${ZLIB_LIBRARIES} ${BZIP2_LIBRARIES}
    ${gvc_LIBRARIES} -lgvplugin_dot_layout -lgvplugin_rsvg -lgvplugin_core -lgvplugin_pango
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
