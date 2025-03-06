# This Makefile creates Doxygen documentation.
# In case you want to build bibref for the web platform, have a look at the
# file .github/workflows/build.yml. Alternatively, you can use the old method,
# described at the end of this file. It is obsoleted and will be removed in the future.
# (For all other purposes with the bibref project, have a look at README.md first.)
#
#######################################################################################################
# Documentation related code

documentation: docs/latex/refman.pdf docs/html/index.html

docs/latex/refman.pdf: docs/latex/refman.tex
	$(MAKE) -C docs/latex

docs/html/index.html docs/latex/refman.tex: Doxyfile $(SRCS) $(DOXS) README.md logo-Psalm40-doxygen.png
	doxygen Doxyfile

.PHONY: clean documentation

clean:
	$(RM) -r $(BUILD_DIR)

MKDIR_P ?= mkdir -p

#######################################################################################################
# Obsoleted information on building the web version of bibref:

# Steps to perform:
#
# 0. Install all prerequisites of the native version, and build it properly (via cmake).
#    You can choose an arbitrary folder, this Makefile will find it later, assuming
#    that there is only one folder which fits (see the BIBREF_NATIVE_BUILD variable below).
#    You need to run "make install" as well to have a minimally working local SWORD
#    installation. (This step may finally fail because of missing write privileges to
#    /usr, but that's okay.) If you already have a ~/.sword folder with other modules
#    than supported by bibref by default, then you should skip the step "make install".
#
# 1. Install Emscripten and enable that its utilities are available on your path.
#    It is usually safe to install and activate the latest stable version.
#
# 2. Build libsword.a by using https://github.com/kovzol/crosswire-sword-mirror
#    and the cmake toolchain from Emscripten (via
#    "emcmake cmake -DSWORD_BUILD_UTILS=No -DSWORD_BUILD_EXAMPLES=No -DLIBSWORD_LIBRARY_TYPE=Static ..").
#    You may need to have a recent cmake. Then run "make sword_static" to
#    build libsword.a and type "make install" to copy the library automatically
#    to the folders .../emsdk/cache/sysroot/{lib,share,include}. The settings
#    in the cmake configuration are important, otherwise the SWORD utilities
#    and examples will also be built, but some of them will eventually fail
#    and the library will not be copied to the official emsdk folder.
#    (In that case you need to do that manually.) There can be no shared library created
#    on this platform, only static, but that's okay.
#
# 3. Step 2 will make sure that libsword.a is visible for the rest of the process.
#    Unfortunately, since static libraries are not available published properly by
#    the SWORD library setup, we still have to work around manually that
#    the first LDFLAGS setting extends the scope to find the library also under the ".." folder.
#
# 4. Create symlinks in this folder to the files statements/{pbrst.c,pbrst.tab.c,pbrst.tab.h}.
#    These files will be present only if you successfully compile the native program above.
#    Issue then "emmake make wasm" in the current directory.
#
# See also the GitHub actions in the .github/ folder for more information on the
# steps above. They may be somewhat different, but hopefully still working.
#
# 5. Copy the files wasm-build/bibref.html and wasm-build/bibref.data to a web server.
#    Note that bibref.data contains the whole content of your ~/.sword folder.
#    (In case you want to add/remove Bible texts, use Sword's command line
#    "installmgr" to fine tune the contents of the ~/.sword folder. See
#    the end of CMakeLists.txt for some examples.)
#
# 6. Open wasm-build/bibref.html in your browser. Open Developer Tools (F12 in most browsers).
#
# 7. Go to the JavaScript Console and type:
#
#    bibref = Module.cwrap("bibref_wasm", "string", ["string"])
#
#    If you get an answer like "ƒ (){return ccall(A,g,B,arguments,C)}" then bibref
#    should be properly installed.
#
# 8. Now you can use any bibref commands in the JavaScript Console like this:
#
#    bibref("help")
#    bibref("lookup LXX Genesis 1:1")
#    bibref("addbooks")
#
#    The web platform is somewhat slower than the native version, but fully functional.
#
# 9. In case you want to create an embedded version of bibref in an HTML page, you may
#    want to use the template in the html/ folder. You need to create a JavaScript
#    version of the web build of bibref by using "TARGET_HTML=bibref.js emmake make wasm".
#    Then simply copy the files wasm-build/bibref.html and wasm-build/bibref.data
#    to the html/ folder, and finally the whole folder to a web server.


TARGET_HTML ?= bibref.html

BUILD_DIR ?= ./wasm-build

wasm: $(BUILD_DIR)/$(TARGET_HTML)

CXX_SRCS := book.cpp books.cpp cli.cpp fingerprint.cpp main.cpp psalmsinfo.cpp \
	books-wrapper.cpp fingerprint-wrapper.cpp
CXX_OBJS := $(CXX_SRCS:%=$(BUILD_DIR)/%.o)
C_SRCS := pbrst.tab.c pbrst.c
C_OBJS := $(C_SRCS:%=$(BUILD_DIR)/%.o)
DOXS := book.dox books.dox cli.dox fingerprint.dox main.dox psalmsinfo.dox

CPPFLAGS += -I/usr/include/sword -s USE_BOOST_HEADERS=1 -DYYDEBUG=1

CFLAGS := -s EXPORTED_FUNCTIONS=[_bibref_wasm,_bibref_wasm_vocabulary] -s EXTRA_EXPORTED_RUNTIME_METHODS=['cwrap'] -fexceptions
CXXFLAGS := -s EXPORTED_FUNCTIONS=[_bibref_wasm,_bibref_wasm_vocabulary] -s EXTRA_EXPORTED_RUNTIME_METHODS=['cwrap'] -fexceptions

BIBREF_NATIVE_FOLDER := $(shell find . -name bibref -executable -printf "%h\n" | sort | head -1)

LDFLAGS := $(shell find .. -name libsword.a | sort | head -1)
LDFLAGS += -s SINGLE_FILE=1 -s USE_BOOST_HEADERS=1
LDFLAGS += -s ALLOW_MEMORY_GROWTH=1
# LDFLAGS += -s TOTAL_MEMORY=2047MB
LDFLAGS += --preload-file ~/.sword@/ --preload-file bibref-addbooks-cache@/bibref-addbooks-cache -O3
LDFLAGS += -fexceptions -s EXTRA_EXPORTED_RUNTIME_METHODS=['cwrap']
ifeq ($(TARGET_HTML),bibref.js)
LDFLAGS += -s MODULARIZE=1 -s EXPORT_NAME=bibref
endif

$(BUILD_DIR)/$(TARGET_HTML): $(CXX_OBJS) $(C_OBJS)
	$(MKDIR_P) $(dir $@)
	echo addbooks | $(BIBREF_NATIVE_FOLDER)/bibref # Make sure bibref generates its cache.
	$(LD) $(CXX_OBJS) $(C_OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

