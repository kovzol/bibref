cmake_minimum_required(VERSION 3.16)
project(bibref-qt LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Concurrent)

find_package(PkgConfig REQUIRED)
pkg_check_modules(sword REQUIRED sword)

include_directories(/usr/include/sword)

qt_standard_project_setup()

qt_add_executable(bibref-qt
    main.cpp
    mainwindow.cpp mainwindow.h
    book.cpp book.h
    books.cpp books.h
    cli.cpp cli.h
    fingerprint.cpp fingerprint.h
    psalmsinfo.cpp psalmsinfo.h
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
    sword readline boost_system boost_filesystem)

install(TARGETS bibref-qt
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
