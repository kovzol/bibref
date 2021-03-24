all: getrefs.pdf authors.pdf manual_nt_length.pdf Rplots.pdf \
 jaccard-Psalms-Rplots.pdf jaccard_Psalms-sorted.txt \
 Romans-getrefs.png Romans-table.pdf Romans-Rplots.pdf jaccard-Romans-Rplots.pdf jaccard_Romans-sorted.txt \
 Hebrews-getrefs.png Hebrews-table.pdf Hebrews-Rplots.pdf jaccard-Hebrews-Rplots.pdf jaccard_Hebrews-sorted.txt \
 Matthew-getrefs.png Matthew-table.pdf Matthew-Rplots.pdf jaccard-Matthew-Rplots.pdf jaccard_Matthew-sorted.txt \
 nt_frequencies.csv ot_frequencies.csv \
 selftest

authors.pdf: authors.tex
	pdflatex authors

manual_nt_length.pdf: manual_nt_length.tex
	pdflatex manual_nt_length

getrefs.pdf: getrefs.tex
	pdflatex getrefs

# Romans
Romans-getrefs.png: Romans-getrefs.ppm
	convert Romans-getrefs.ppm png:Romans-getrefs.png

Romans-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm

Romans-table.tex: visualize.py quotations.sqlite3
	python3 visualize.py nt_latex > Romans-table.tex

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

Romans-table.pdf: Romans-table.tex
	pdflatex Romans-table

# Hebrews
Hebrews-getrefs.png: Hebrews-getrefs.ppm
	convert Hebrews-getrefs.ppm png:Hebrews-getrefs.png

Hebrews-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Hebrews 26307 165

Hebrews-table.tex: visualize.py quotations.sqlite3
	python3 visualize.py nt_latex Hebrews > Hebrews-table.tex

Hebrews-Rplots.pdf: manual_Hebrews_length.csv manual_Hebrews_length.r
	R -q --save < manual_Hebrews_length.r

jaccard-Hebrews-Rplots.pdf: jaccard_Hebrews.csv jaccard_Hebrews.r
	R -q --save < jaccard_Hebrews.r

jaccard_Hebrews.csv: visualize.py quotations.sqlite3
	python3 visualize.py nt_jaccard Hebrews

jaccard_Hebrews.txt: visualize.py quotations.sqlite3
	python3 visualize.py nt_jaccard Hebrews

jaccard_Hebrews-sorted.txt: jaccard_Hebrews.txt
	sort jaccard_Hebrews.txt > jaccard_Hebrews-sorted.txt

Hebrews-table.pdf: Hebrews-table.tex
	pdflatex Hebrews-table

# Matthew
Matthew-getrefs.png: Matthew-getrefs.ppm
	convert Matthew-getrefs.ppm png:Matthew-getrefs.png

Matthew-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Matthew 90007 356

Matthew-table.tex: visualize.py quotations.sqlite3
	python3 visualize.py nt_latex Matthew > Matthew-table.tex

Matthew-Rplots.pdf: manual_Matthew_length.csv manual_Matthew_length.r
	R -q --save < manual_Matthew_length.r

jaccard-Matthew-Rplots.pdf: jaccard_Matthew.csv jaccard_Matthew.r
	R -q --save < jaccard_Matthew.r

jaccard_Matthew.csv: visualize.py quotations.sqlite3
	python3 visualize.py nt_jaccard Matthew

jaccard_Matthew.txt: visualize.py quotations.sqlite3
	python3 visualize.py nt_jaccard Matthew

jaccard_Matthew-sorted.txt: jaccard_Matthew.txt
	sort jaccard_Matthew.txt > jaccard_Matthew-sorted.txt

Matthew-table.pdf: Matthew-table.tex
	pdflatex Matthew-table

# Other tasks
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

jaccard-Psalms-Rplots.pdf: jaccard_Psalms.csv jaccard_Psalms.r
	R -q --save < jaccard_Psalms.r

jaccard_Psalms.csv: visualize.py quotations.sqlite3
	python3 visualize.py ot_jaccard

jaccard_Psalms.txt: visualize.py quotations.sqlite3
	python3 visualize.py ot_jaccard

jaccard_Psalms-sorted.txt: jaccard_Psalms.txt
	sort jaccard_Psalms.txt > jaccard_Psalms-sorted.txt

nt_frequencies.csv: visualize.py quotations.sqlite3
	python3 visualize.py nt_freq_csv

ot_frequencies.csv: visualize.py quotations.sqlite3
	python3 visualize.py ot_freq_csv

selftest:
	./selftest.py

clean:
	rm -f quotations.sqlite3 authors.tex manual_nt_length.tex getrefs.tex \
 authors.aux manual_nt_length.aux getrefs.aux \
 authors.log manual_nt_length.log getrefs.log

fullclean: clean
	rm -f authors.pdf getrefs.pdf manual_nt_length.pdf Rplots.pdf

.PHONY: clean fullclean all selftest
