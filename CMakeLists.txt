cmake_minimum_required(VERSION 3.0)
project(bibref)

set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_FLAGS "-pedantic-errors")

find_package(PkgConfig REQUIRED)
pkg_check_modules(sword REQUIRED sword)
# One needs readline >= 8.0 to make this work:
# pkg_check_modules (readline REQUIRED readline)

include_directories(/usr/include/sword)

add_executable(bibref main.cpp book.cpp book.h books.cpp books.h fingerprint.cpp fingerprint.h cli.cpp cli.h)

target_link_libraries(bibref sword readline)

# Download and install LXX and SBLGNT
set(ENV{SWORD_PATH} "$ENV{HOME}/.sword")
execute_process (COMMAND bash -c "mkdir -p \"$SWORD_PATH/mods.d\" \
    && echo yes | installmgr -init \
    && echo yes | installmgr -sc \
    && echo yes | installmgr -r CrossWire \
    && echo yes | installmgr -ri CrossWire LXX \
    && echo yes | installmgr -ri CrossWire SBLGNT")
# Sometimes a second run messes ~/.sword up, in such cases first a removal is required.
