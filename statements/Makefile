CC = cc -g
CXX = g++ -g
LEX = flex
YACC = bison
CFLAGS = -DYYDEBUG=1

all:	pbrst-cli

pbrst-cli:	pbrst.tab.o pbrst.o pbrst-cli.o books-wrapper.o fingerprint-wrapper.o books.o cli.o book.o psalmsinfo.o fingerprint.o
	${CXX} -o $@ books-wrapper.o fingerprint-wrapper.o pbrst.tab.o pbrst.o pbrst-cli.o books.o cli.o book.o psalmsinfo.o fingerprint.o \
         -lsword -lboost_system -lboost_filesystem -lreadline

pbrst.tab.c pbrst.tab.h:	pbrst.y
	${YACC} -vd pbrst.y

pbrst.c:	pbrst.l
	${LEX} -o $@ $<

pbrst.o:	pbrst.c pbrst.tab.h

pbrst-cli.o:	pbrst-cli.c

books-wrapper.o:	books-wrapper.cpp books-wrapper.h
	${CC} -o $@ -c $< -I/usr/include/sword

fingerprint-wrapper.o:	fingerprint-wrapper.cpp fingerprint-wrapper.h
	${CC} -o $@ -c $<

book.o:		book.cpp book.h
	${CXX} -o $@ -c $<

fingerprint.o:	fingerprint.cpp fingerprint.h
	${CXX} -o $@ -c $<

psalmsinfo.o:	psalmsinfo.cpp psalmsinfo.h
	${CXX} -o $@ -c $<

books.o:	books.cpp books.h
	${CXX} -o $@ -c $< -I/usr/include/sword

cli.o:	cli.cpp cli.h
	${CXX} -o $@ -c $< -I/usr/include/sword

test: pbrst-cli
	./pbrst-cli < test.brst

clean:
	rm -f pbrst-cli pbrst-cli.o pbrst.tab.c pbrst.tab.h pbrst.c pbrst.tab.o pbrst.o pbrst.output \
         books-wrapper.o fingerprint-wrapper.o book.o fingerprint.o psalmsinfo.o books.o cli.o

.SUFFIXES:	.l .y .c

.PHONY: test
