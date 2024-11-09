CC = cc -g
LEX = flex
YACC = bison
CFLAGS = -DYYDEBUG=1

all:	pbrst-cli

pbrst-cli:	pbrst.tab.o pbrst.o pbrst-cli.o
	${CC} -o $@ pbrst.tab.o pbrst.o pbrst-cli.o

pbrst.tab.c pbrst.tab.h:	pbrst.y
	${YACC} -vd pbrst.y

pbrst.c:	pbrst.l
	${LEX} -o $@ $<

pbrst.o:	pbrst.c pbrst.tab.h

pbrst-cli.o:	pbrst-cli.c

test: pbrst-cli
	./pbrst-cli < test.brst

clean:
	rm -f pbrst-cli pbrst-cli.o pbrst.tab.c pbrst.tab.h pbrst.c pbrst.tab.o pbrst.o pbrst.output

.SUFFIXES:	.l .y .c

.PHONY: test
