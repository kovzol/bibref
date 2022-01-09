# This Makefile helps building bibref for the web platform.
#
# Steps to perform:
#
# 1. Install Emscripten and enable that its utilities ara availabe on your path.
# 2. Build libsword.a by using https://github.com/kovzol/crosswire-sword-mirror
#    and the cmake toolchain from Emscripten. You may need to have a recent cmake.
#    The build may be incomplete, but libsword.a can be successfully built.
# 3. Make sure that libsword.a is visible from the file system under the parent
#    folder of the current directory (..).
# 4. Issue "emmake make" in this directory.
# 5. Start wasm-build/bibref.html in your browser and enter the commands in
#    the popup window.
#
# Known issue: Sword's Bible databases are not accessible at the moment.

TARGET_HTML ?= bibref.html

BUILD_DIR ?= ./wasm-build
SRC_DIRS ?= .

SRCS := $(sort $(shell find $(SRC_DIRS) -name '*.cpp'))
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

LDFLAGS := $(shell find .. -name libsword.a | sort | head -1)
LDFLAGS += -s SINGLE_FILE=1 -s USE_BOOST_HEADERS=1

CPPFLAGS += -I/usr/include/sword

$(BUILD_DIR)/$(TARGET_HTML): $(OBJS)
	$(MKDIR_P) $(dir $@)
	$(CXX) $(OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR)

-include $(DEPS)

MKDIR_P ?= mkdir -p
