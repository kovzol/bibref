cmake_minimum_required(VERSION 3.16)
project(bibref-qt LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Concurrent)

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
find_package(Boost 1.74.0 COMPONENTS system filesystem)

if(MINGW)
    find_package(ICU REQUIRED uc in)
    find_package(LibLZMA REQUIRED)
    find_package(ZLIB REQUIRED)
    find_package(BZip2 REQUIRED)
endif(MINGW)

pkg_check_modules (readline REQUIRED readline)

include_directories(${sword_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS} ${readline_INCLUDE_DIRS})

# This works when Qt >= 6.3:
# qt_standard_project_setup()
# Otherwise, with Qt <= 6.2 this is required:
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

add_definitions(-DPROJECT_SOURCE_DIR="${PROJECT_SOURCE_DIR}"
    -DINSTALL_PREFIX="${CMAKE_INSTALL_PREFIX}")

qt_add_executable(bibref-qt
    main.cpp
    mainwindow.cpp mainwindow.h
    book.cpp book.h
    books.cpp books.h
    cli.cpp cli.h
    fingerprint.cpp fingerprint.h
    psalmsinfo.cpp psalmsinfo.h
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
    ${sword_LIBRARIES} ${Boost_LIBRARIES} ${readline_LIBRARIES}
    ${ICU_LIBRARIES} ${LIBLZMA_LIBRARIES} ${ZLIB_LIBRARIES} ${BZIP2_LIBRARIES}
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
