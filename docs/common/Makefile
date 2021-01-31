all: getrefs.pdf authors.pdf manual_nt_length.pdf Rplots.pdf Romans-getrefs.png \
 Romans-table.pdf Romans-Rplots.pdf nt_frequencies.csv ot_frequencies.csv \
 jaccard-Romans-Rplots.pdf jaccard_Romans-sorted.txt \
 jaccard-Psalms-Rplots.pdf jaccard_Psalms-sorted.txt \
 selftest

authors.pdf: authors.tex
	pdflatex authors

manual_nt_length.pdf: manual_nt_length.tex
	pdflatex manual_nt_length

getrefs.pdf: getrefs.tex
	pdflatex getrefs

Romans-getrefs.png: Romans-getrefs.ppm
	convert Romans-getrefs.ppm png:Romans-getrefs.png

Romans-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm

Romans-table.tex: visualize.py quotations.sqlite3
	python3 visualize.py nt_latex > Romans-table.tex

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

Romans-Rplots.pdf: manual_Romans_length.csv manual_Romans_length.r
	R -q --save < manual_Romans_length.r

jaccard-Romans-Rplots.pdf: jaccard_Romans.csv jaccard_Romans.r
	R -q --save < jaccard_Romans.r

jaccard_Romans.csv: visualize.py quotations.sqlite3
	python3 visualize.py nt_jaccard

jaccard_Romans.txt: visualize.py quotations.sqlite3
	python3 visualize.py nt_jaccard

jaccard_Romans-sorted.txt: jaccard_Romans.txt
	sort jaccard_Romans.txt > jaccard_Romans-sorted.txt

jaccard-Psalms-Rplots.pdf: jaccard_Psalms.csv jaccard_Psalms.r
	R -q --save < jaccard_Psalms.r

jaccard_Psalms.csv: visualize.py quotations.sqlite3
	python3 visualize.py ot_jaccard

jaccard_Psalms.txt: visualize.py quotations.sqlite3
	python3 visualize.py ot_jaccard

jaccard_Psalms-sorted.txt: jaccard_Psalms.txt
	sort jaccard_Psalms.txt > jaccard_Psalms-sorted.txt

Romans-table.pdf: Romans-table.tex
	pdflatex Romans-table

nt_frequencies.csv: visualize.py quotations.sqlite3
	python3 visualize.py nt_freq_csv

ot_frequencies.csv: visualize.py quotations.sqlite3
	python3 visualize.py ot_freq_csv

selftest:
	./selftest.py

clean:
	rm -f quotations.sqlite3 authors.tex manual_nt_length.tex getrefs.tex authors.aux manual_nt_length.aux getrefs.aux \
 authors.log manual_nt_length.log getrefs.log

fullclean: clean
	rm -f authors.pdf getrefs.pdf manual_nt_length.pdf Rplots.pdf

.PHONY: clean fullclean all selftest
