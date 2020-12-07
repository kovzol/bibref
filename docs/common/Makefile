all: getrefs.pdf authors.pdf manual_nt_length.pdf Rplots.pdf Romans.ppm

authors.pdf: authors.tex
	pdflatex authors

manual_nt_length.pdf: manual_nt_length.tex
	pdflatex manual_nt_length

getrefs.pdf: getrefs.tex
	pdflatex getrefs

Romans.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt > Romans.ppm

authors.tex: visualize.py quotations.sqlite3
	python3 visualize.py traditional > authors.tex

manual_nt_length.tex manual_nt_length.csv: visualize.py quotations.sqlite3
	python3 visualize.py traditional manual_nt_length > manual_nt_length.tex

getrefs.tex: visualize.py quotations.sqlite3
	python3 visualize.py getrefs > getrefs.tex

quotations.sqlite3: quotations.sql
	./dropdb
	./createdb

Rplots.pdf: manual_nt_length.csv manual_nt_length.r
	R -q --save < manual_nt_length.r

clean:
	rm -f quotations.sqlite3 authors.tex manual_nt_length.tex getrefs.tex authors.aux manual_nt_length.aux getrefs.aux authors.log manual_nt_length.log getrefs.log

fullclean: clean
	rm -f authors.pdf getrefs.pdf manual_nt_length.pdf Rplots.pdf

.PHONY: clean fullclean all
