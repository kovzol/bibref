# This cmake configuration file has been successfully tested on the following platforms:
# Linux, macOS, MSYS2/MINGW64, emscripten.

# When building for emscripten, build a native Linux version first, create the addbooks cache,
# and just then start the build for emscripten, providing the bibref-addbooks-cache folder name
# as an option when starting cmake. See the variable BIBREF_ADDBOOKS_CACHE_FOLDER below.
# As an optional setting, HTML_BUILD_DIR can be given to have all required files in the same
# folder (ready to deploy).

cmake_minimum_required(VERSION 3.16)
project(bibref)

set(BIBREF_ADDBOOKS_CACHE_FOLDER ../bibref-addbooks-cache CACHE STRING
 "Set the previously created bibref-addbooks-cache folder for the Emscripten build")
set(HTML_BUILD_DIR html-output CACHE STRING
 "Set the output folder for the Emscripten build")

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "-pedantic-errors")

find_package(PkgConfig REQUIRED)
pkg_check_modules(sword REQUIRED sword)

if(EMSCRIPTEN)
find_library(SWORD_LIB NAMES libsword.a)
endif(EMSCRIPTEN)

set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost CONFIG COMPONENTS system filesystem)

if(APPLE OR EMSCRIPTEN) # readline seems to have trouble on macOS, unsupported on emscripten
else()
# One needs readline >= 8.0 to make this work:
pkg_check_modules (readline REQUIRED readline)
endif()

include_directories(${sword_INCLUDE_DIRS})

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
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DYYDEBUG=1")

#add_executable(pbrst-cli statements/pbrst-cli.c ${PARSER_DIR}/pbrst.tab.h "${LEXER_OUT}" "${PARSER_OUT}")

SET(PBRST_SRCS
 books-wrapper.cpp books-wrapper.h
 fingerprint-wrapper.cpp fingerprint-wrapper.h
 ${PARSER_DIR}/pbrst.tab.h "${LEXER_OUT}" "${PARSER_OUT}"
)

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

if(EMSCRIPTEN)
target_link_libraries(bibref ${SWORD_LIB} ${Boost_LIBRARIES})
target_link_options(bibref PUBLIC -sSINGLE_FILE -sUSE_BOOST_HEADERS -sALLOW_MEMORY_GROWTH -O3 -fexceptions)
target_link_options(bibref PUBLIC "SHELL:
  --preload-file '$ENV{HOME}/.sword@/'")
target_link_options(bibref PUBLIC "SHELL:
  --preload-file '${BIBREF_ADDBOOKS_CACHE_FOLDER}@/bibref-addbooks-cache'")
target_link_options(bibref PUBLIC -sEXTRA_EXPORTED_RUNTIME_METHODS=['cwrap'] -sMODULARIZE -sEXPORT_NAME=bibref)
install(TARGETS bibref DESTINATION "${CMAKE_BINARY_DIR}/${HTML_BUILD_DIR}")
file(GLOB HTML_FILES ${CMAKE_CURRENT_SOURCE_DIR}/html/*)
install(FILES ${HTML_FILES} ${CMAKE_BINARY_DIR}/bibref.data DESTINATION "${CMAKE_BINARY_DIR}/${HTML_BUILD_DIR}")

else()
target_link_libraries(bibref ${sword_LIBRARIES} ${sword_LIBRARIES_folder} ${Boost_LIBRARIES} ${readline_LIBRARIES})

install(
 CODE " set(ENV{SWORD_PATH} \"$ENV{HOME}/.sword\") "
# Download and install LXX and SBLGNT via CrossWire...
## Now we disable this because LXX was updated to version 3.0 and its versification ("LXX") differs from version 2.5 ("KJV"),
## so we want to avoid installing the new version for the moment. Instead, we use the bundled versions...
## In fact, now (February 2025) the bundled version contains LXX version 3.0, but
## it is simpler to maintain a ZIP bundle than managing the modules via installmgr.
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
endif(EMSCRIPTEN)
