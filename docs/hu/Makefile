all: bibref.pdf

bibref.pdf: bibref.tex bibref.bbl
	pdflatex bibref
	pdflatex bibref

bibref.bbl: ../common/bibref.bib
	pdflatex bibref
	bibtex bibref

clean:
	rm -f bibref.bbl bibref.blg bibref.log bibref.aux

fullclean: clean
	rm -f bibref.pdf

.PHONY: clean fullclean all

