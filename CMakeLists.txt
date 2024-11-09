cmake_minimum_required(VERSION 3.5)
project(bibref)

set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_FLAGS "-pedantic-errors")

find_package(PkgConfig REQUIRED)
pkg_check_modules(sword REQUIRED sword)

set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost 1.74.0 COMPONENTS system filesystem)

# One needs readline >= 8.0 to make this work:
pkg_check_modules (readline REQUIRED readline)

include_directories(/usr/include/sword)

add_compile_definitions(WITH_PBRST)
# These should be compiled first in the folder "statements/" by issuing a "make" command.
# TODO: Do it from the cmake machinery.
SET(OBJS
  ${CMAKE_CURRENT_SOURCE_DIR}/statements/pbrst.o
  ${CMAKE_CURRENT_SOURCE_DIR}/statements/pbrst.tab.o
)

add_executable(bibref main.cpp book.cpp book.h books.cpp books.h fingerprint.cpp fingerprint.h cli.cpp cli.h psalmsinfo.cpp psalmsinfo.h
 statements/pbrst.tab.h ${OBJS})

SET_SOURCE_FILES_PROPERTIES(
  ${OBJS}
  PROPERTIES
  EXTERNAL_OBJECT true
  GENERATED true
)

target_link_libraries(bibref sword readline boost_system boost_filesystem)

install(
 CODE " set(ENV{SWORD_PATH} \"$ENV{HOME}/.sword\") "
# Download and install LXX and SBLGNT via CrossWire...
## Now we disable this because LXX was updated to version 3.0 and its versification ("LXX") differs from version 2.5 ("KJV"),
## so we want to avoid installing the new version for the moment. Instead, we use the bundled versions...
## CODE " execute_process (COMMAND bash -c \"test -d \\\"$SWORD_PATH/mods.d\\\" || (mkdir -p \\\"$SWORD_PATH/mods.d\\\"; echo yes | installmgr -init)\") "
## CODE " execute_process (COMMAND bash -c \"installmgr -s | grep \\\"\\\\[CrossWire\\\\]\\\" || echo yes | installmgr -sc\") "
## CODE " execute_process (COMMAND bash -c \"echo yes | installmgr -r CrossWire\") "
## CODE " execute_process (COMMAND bash -c \"installmgr -l | grep \\\"\\\\[LXX\\\\]\\\" || echo yes | installmgr -ri CrossWire LXX\") "
## CODE " execute_process (COMMAND bash -c \"installmgr -l | grep \\\"\\\\[SBLGNT\\\\]\\\" || echo yes | installmgr -ri CrossWire SBLGNT\") "
## CODE " execute_process (COMMAND bash -c \"installmgr -l | grep \\\"\\\\[StatResGNT\\\\]\\\" || echo yes | installmgr -ri CrossWire StatResGNT\") "
## CODE " execute_process (COMMAND bash -c \"installmgr -l | grep \\\"\\\\[KJV\\\\]\\\" || echo yes | installmgr -ri CrossWire KJV\") "
# If it was unsuccessful, as fallback, unzip bundled LXX and SBLGNT (this may be required on snap-packaging in a CI sandbox)
 CODE " execute_process (COMMAND bash -c \"test -r \\\"$SWORD_PATH/mods.d/lxx.conf\\\" || unzip -d ~ ${CMAKE_SOURCE_DIR}/sword-lxx-sblgnt-statresgnt-kjv-fallback.zip\") "
)

install(TARGETS bibref DESTINATION bin)
