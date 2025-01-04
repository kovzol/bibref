cmake_minimum_required(VERSION 3.16)
project(bibref)

option(PBRST "Include the precompiled brst parser" OFF)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "-pedantic-errors")

find_package(PkgConfig REQUIRED)
pkg_check_modules(sword REQUIRED sword)

set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost CONFIG COMPONENTS system filesystem)

if(APPLE) # readline seems to have trouble on MacOS
else()
# One needs readline >= 8.0 to make this work:
pkg_check_modules (readline REQUIRED readline)
endif()

include_directories(${sword_INCLUDE_DIRS})

if(PBRST)
add_compile_definitions(WITH_PBRST)

set(PARSER_DIR "${CMAKE_CURRENT_BINARY_DIR}")
find_package(FLEX 2.6 REQUIRED)
find_package(BISON 3.0 REQUIRED)

set(LEXER_OUT "${PARSER_DIR}/pbrst.c")
set(PARSER_OUT "${PARSER_DIR}/pbrst.tab.c")

flex_target(LEXER "${CMAKE_CURRENT_SOURCE_DIR}/statements/pbrst.l" "${LEXER_OUT}")
bison_target(PARSER "${CMAKE_CURRENT_SOURCE_DIR}/statements/pbrst.y" "${PARSER_OUT}"
  COMPILE_FLAGS -vd DEFINES_FILE "${PARSER_DIR}/pbrst.tab.h")
add_flex_bison_dependency(LEXER PARSER)

include_directories(${PARSER_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DYYDEBUG=1 -DIN_BIBREF")

#add_executable(pbrst-cli statements/pbrst-cli.c ${PARSER_DIR}/pbrst.tab.h "${LEXER_OUT}" "${PARSER_OUT}")

SET(PBRST_SRCS
 books-wrapper.cpp books-wrapper.h
 fingerprint-wrapper.cpp fingerprint-wrapper.h
 ${PARSER_DIR}/pbrst.tab.h "${LEXER_OUT}" "${PARSER_OUT}"
)
endif(PBRST)

add_executable(bibref main.cpp book.cpp book.h books.cpp books.h fingerprint.cpp fingerprint.h cli.cpp cli.h psalmsinfo.cpp psalmsinfo.h
 ${PBRST_SRCS}
)

SET_SOURCE_FILES_PROPERTIES(
  PROPERTIES
  EXTERNAL_OBJECT true
  GENERATED true
)

if(APPLE)
set(sword_LIBRARIES_folder "-L/usr/local/lib") # this is hardcoded (via configure/make install), FIXME
endif()

target_link_libraries(bibref
    ${sword_LIBRARIES} ${sword_LIBRARIES_folder} ${Boost_LIBRARIES} ${readline_LIBRARIES}
)


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
