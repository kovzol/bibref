CC = cc -g
LEX = flex
YACC = bison
CFLAGS = -DYYDEBUG=1

#all:	pbrst

all:	pbrst.o pbrst.tab.o

#pbrst:	pbrst.tab.o pbrst.o
#	${CC} -o $@ pbrst.tab.o pbrst.o

pbrst.tab.c pbrst.tab.h:	pbrst.y
	${YACC} -vd pbrst.y

pbrst.c:	pbrst.l
	${LEX} -o $@ $<

pbrst.o:	pbrst.c pbrst.tab.h

#test: pbrst
#	./pbrst < test.brst

clean:
	rm -f pbrst pbrst.tab.c pbrst.tab.h pbrst.c pbrst.tab.o pbrst.o pbrst.output

.SUFFIXES:	.l .y .c

.PHONY: test
