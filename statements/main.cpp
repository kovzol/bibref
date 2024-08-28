#include <iostream>
#include <string>
#include <fstream>
#include <streambuf>
#include "antlr4-runtime.h"
#include "BrstLexer.h"
#include "BrstParser.h"

int main(int argc, const char* argv[]) {

    if (argc != 2) {
        std::cout << "Usage: " << argv[0] << " <input .brst file>\n";
        exit(1);
       }

    // Provide the input text in a stream
    std::ifstream t(argv[1]);
    std::string str((std::istreambuf_iterator<char>(t)),
    std::istreambuf_iterator<char>());

    antlr4::ANTLRInputStream input(str);

    // Create a lexer from the input
    BrstLexer lexer(&input);

    // Create a token stream from the lexer
    antlr4::CommonTokenStream tokens(&lexer);

    // Create a parser from the token stream
    BrstParser parser(&tokens); 

    // Display the parse tree
    std::cout << parser.brst_stmt()->toStringTree() << std::endl;
    return 0;
}