cmake_minimum_required(VERSION 3.0)
project(bibref)

set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_FLAGS "-pedantic-errors")

find_package(PkgConfig REQUIRED)
pkg_check_modules(sword REQUIRED sword)

include_directories(/usr/include/sword)

add_executable(bibref main.cpp book.cpp book.h books.cpp books.h fingerprint.cpp fingerprint.h cli.cpp cli.h)

target_link_libraries(bibref sword readline)



