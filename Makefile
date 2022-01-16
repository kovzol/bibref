# This Makefile builds bibref for the web platform.
#
# Steps to perform:
#
# 0. Install all prerequisites of the native version, and build it properly (via cmake).
#
# 1. Install Emscripten and enable that its utilities are available on your path.
#
# 2. Build libsword.a by using https://github.com/kovzol/crosswire-sword-mirror
#    and the cmake toolchain from Emscripten (via "ecmake cmake").
#    You may need to have a recent cmake. Then run "make sword_static" to
#    build libsword.a.
#
# 3. Make sure that libsword.a is visible from the file system under the parent
#    folder of the current directory (..).
#
# 4. Issue "emmake make" in the current directory.
#
# See also the GitHub actions in the .github/ folder for more information on the
# steps above.
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
#    version of the web build of bibref by using "TARGET_HTML=bibref.js emmake make".
#    Then simply copy the files wasm-build/bibref.html and wasm-build/bibref.data
#    to the html/ folder, and finally the whole folder to a web server.

TARGET_HTML ?= bibref.html

BUILD_DIR ?= ./wasm-build

SRCS := book.cpp books.cpp cli.cpp fingerprint.cpp main.cpp
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

CPPFLAGS += -I/usr/include/sword -s USE_BOOST_HEADERS=1

CXXFLAGS := -s EXPORTED_FUNCTIONS=[_bibref_wasm] -s EXTRA_EXPORTED_RUNTIME_METHODS=['cwrap'] -fexceptions

BIBREF_NATIVE_FOLDER := $(shell find . -name bibref -executable -printf "%h\n" | sort | head -1)

LDFLAGS := $(shell find .. -name libsword.a | sort | head -1)
LDFLAGS += -s SINGLE_FILE=1 -s USE_BOOST_HEADERS=1
LDFLAGS += -s ALLOW_MEMORY_GROWTH=1
# LDFLAGS += -s TOTAL_MEMORY=2047MB
LDFLAGS += --preload-file ~/.sword@/ --preload-file .bibref@/.bibref -O3
LDFLAGS += -fexceptions -s EXTRA_EXPORTED_RUNTIME_METHODS=['cwrap']
ifeq ($(TARGET_HTML),bibref.js)
LDFLAGS += -s MODULARIZE=1 -s EXPORT_NAME=bibref
endif

$(BUILD_DIR)/$(TARGET_HTML): $(OBJS)
	$(MKDIR_P) $(dir $@)
	echo addbooks | $(BIBREF_NATIVE_FOLDER)/bibref # Make sure bibref generates its cache.
	$(CXX) $(OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR)

MKDIR_P ?= mkdir -p
