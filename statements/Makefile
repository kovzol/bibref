# You need at least the package libantlr4-dev-runtime (and build-essential) on Ubuntu to make this work.
# Unfortunately, the package antlr4 has a different version on Ubuntu 24.04, so we need
# the correct version of antlr4 to avoid incompatible generated code
# (see https://bugs.launchpad.net/ubuntu/+source/antlr4-cpp-runtime/+bug/2078040).

# ANTLR_VERSION := 4.10
ANTLR_VERSION := $(shell sh -c "dpkg -l libantlr4-runtime-dev | grep libantlr4" | awk '{print $$3}' | cut -f1 -d+)

ANTLR_PROGRAM := antlr-$(ANTLR_VERSION)-complete.jar

ANTLR_CMD := java -jar $(ANTLR_PROGRAM)

main: main.cpp BrstLexer.cpp BrstParser.cpp
	g++ -o main main.cpp BrstLexer.cpp BrstParser.cpp -I /usr/include/antlr4-runtime/ -lantlr4-runtime

BrstLexer.cpp BrstParser.cpp: BrstLexer.g4 BrstParser.g4 $(ANTLR_PROGRAM)
	$(ANTLR_CMD) -Dlanguage=Cpp BrstParser.g4 BrstLexer.g4

$(ANTLR_PROGRAM):
	wget https://github.com/antlr/website-antlr4/raw/gh-pages/download/$(ANTLR_PROGRAM)

.PHONY:
test: main test.brst
	./main test.brst

clean:
	rm -f main BrstLexer.cpp BrstLexer.h BrstLexer.interp BrstLexer.tokens \
	    BrstParser.cpp BrstParser.h BrstParser.interp BrstParser.tokens \
	    BrstParserBaseListener.cpp BrstParserBaseListener.h \
	    BrstParserListener.cpp BrstParserListener.h
