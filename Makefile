# This Makefile builds bibref for the web platform.
#
# Steps to perform:
#
# 0. Install all prerequisites of the native version, and build it properly (via cmake).
# 1. Install Emscripten and enable that its utilities are available on your path.
# 2. Build libsword.a by using https://github.com/kovzol/crosswire-sword-mirror
#    and the cmake toolchain from Emscripten (via "ecmake cmake").
#    You may need to have a recent cmake. The build may be incomplete,
#    but libsword.a can be built successfully.
# 3. Make sure that libsword.a is visible from the file system under the parent
#    folder of the current directory (..).
# 4. Issue "emmake make" in the current directory.
# 5. Copy the files wasm-build/bibref.html and wasm-build/bibref.data to a web server.
#    Note that bibref.data contains the whole content of your ~/.sword folder.
# 6. Open wasm-build/bibref.html in your browser and enter some bibref commands in
#    the popup window. (The following commands should work: addbooks, lookup, textN,
#    latintextN, find, maxresults, and maybe some others too.)
#    Meanwhile you can open the Developer Console (F12). ESC can show the output
#    and errors, double ESC exits the program.
#
# Known issues: some commands like getrefs and lookupN throw an exception
# (they do not work yet).
#
# See also the GitHub actions in the .github/ folder for more information.

TARGET_HTML ?= bibref.html

BUILD_DIR ?= ./wasm-build

SRCS := book.cpp books.cpp cli.cpp fingerprint.cpp main.cpp
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

CPPFLAGS += -I/usr/include/sword -s USE_BOOST_HEADERS=1

LDFLAGS := $(shell find .. -name libsword.a | sort | head -1)
LDFLAGS += -s SINGLE_FILE=1 -s USE_BOOST_HEADERS=1
LDFLAGS += -s ALLOW_MEMORY_GROWTH=1
LDFLAGS += -s TOTAL_MEMORY=2047MB
LDFLAGS += --preload-file ~/.sword@/ -O3

$(BUILD_DIR)/$(TARGET_HTML): $(OBJS)
	$(MKDIR_P) $(dir $@)
	$(CXX) $(OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR)

MKDIR_P ?= mkdir -p
