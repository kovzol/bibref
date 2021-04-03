all: jaccard nojaccard

jaccard: jaccard-Psalms-Rplots.pdf jaccard_Psalms-sorted.txt \
 jaccard-Romans-Rplots.pdf jaccard_Romans-sorted.txt \
 jaccard-Hebrews-Rplots.pdf jaccard_Hebrews-sorted.txt \
 jaccard-Matthew-Rplots.pdf jaccard_Matthew-sorted.txt \
 jaccard-multi-Rplots.pdf

nojaccard: getrefs.pdf authors.pdf manual_nt_length.pdf Rplots.pdf \
 Romans-getrefs.png Romans-table.pdf Romans-Rplots.pdf \
 Hebrews-getrefs.png Hebrews-table.pdf Hebrews-Rplots.pdf \
 Matthew-getrefs.png Matthew-table.pdf Matthew-Rplots.pdf \
 multi-Rplots.pdf \
 nt_frequencies.csv ot_frequencies.csv \
 selftest

authors.pdf: authors.tex
	pdflatex authors

manual_nt_length.pdf: manual_nt_length.tex
	pdflatex manual_nt_length

getrefs.pdf: getrefs.tex
	pdflatex getrefs

# Jaccard
nt_jaccard_inputs = Matthew Romans Hebrews
jaccard-Rplots = $(nt_jaccard_inputs:%=jaccard-%-Rplots.pdf)

jaccard-%-Rplots.pdf: jaccard_%.csv jaccard_%.r
	R -q --save < jaccard_$*.r
jaccard_%.csv jaccard_%.txt:  visualize.py quotations.sqlite3
	python3 visualize.py nt_jaccard $*
jaccard_%-sorted.txt: jaccard_%.txt
	sort jaccard_$*.txt > jaccard_$*-sorted.txt

# Romans
Romans-getrefs.png: Romans-getrefs.ppm
	convert Romans-getrefs.ppm png:Romans-getrefs.png

Romans-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm

Romans-table.tex: visualize.py quotations.sqlite3
	python3 visualize.py nt_latex > Romans-table.tex

Romans-table.pdf: Romans-table.tex
	pdflatex Romans-table

# Hebrews
Hebrews-getrefs.png: Hebrews-getrefs.ppm
	convert Hebrews-getrefs.ppm png:Hebrews-getrefs.png

Hebrews-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Hebrews 26307 165 160

Hebrews-table.tex: visualize.py quotations.sqlite3
	python3 visualize.py nt_latex Hebrews > Hebrews-table.tex

Hebrews-Rplots.pdf: manual_Hebrews_length.csv manual_Hebrews_length.r
	R -q --save < manual_Hebrews_length.r

Hebrews-table.pdf: Hebrews-table.tex
	pdflatex Hebrews-table

# Matthew
Matthew-getrefs.png: Matthew-getrefs.ppm
	convert Matthew-getrefs.ppm png:Matthew-getrefs.png

Matthew-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Matthew 90007 356 253

Matthew-table.tex: visualize.py quotations.sqlite3
	python3 visualize.py nt_latex Matthew > Matthew-table.tex

Matthew-Rplots.pdf: manual_Matthew_length.csv manual_Matthew_length.r
	R -q --save < manual_Matthew_length.r

Matthew-table.pdf: Matthew-table.tex
	pdflatex Matthew-table

# Multiple plots
jaccard-multi-Rplots.pdf: jaccard_Matthew.csv jaccard_Romans.csv jaccard_Hebrews.csv jaccard_multi.r
	R -q --save < jaccard_multi.r

multi-Rplots.pdf: manual_Matthew_length.csv manual_Romans_length.csv manual_Hebrews_length.csv manual_multi_length.r
	R -q --save < manual_multi_length.r

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
	echo ".read views.sql" | sqlite3 quotations.sqlite3

Rplots.pdf: manual_nt_length.csv manual_nt_length.r
	R -q --save < manual_nt_length.r

jaccard-Psalms-Rplots.pdf: jaccard_Psalms.csv jaccard_Psalms.r
	R -q --save < jaccard_Psalms.r

jaccard_Psalms.csv: visualize.py quotations.sqlite3
	python3 visualize.py ot_jaccard

jaccard_Psalms.txt: visualize.py quotations.sqlite3
	python3 visualize.py ot_jaccard

jaccard_%-sorted.txt: jaccard_Psalms.txt
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
