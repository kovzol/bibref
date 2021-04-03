all: jaccard nojaccard

authors.pdf: authors.tex
	pdflatex authors

manual_nt_length.pdf: manual_nt_length.tex
	pdflatex manual_nt_length

getrefs.pdf: getrefs.tex
	pdflatex getrefs

nt_inputs = Matthew Romans Hebrews

# Jaccard
jaccard-Rplots-pdfs = $(nt_inputs:%=jaccard-%-Rplots.pdf)
jaccard-sorted-txts = $(nt_inputs:%=jaccard_%-sorted.txt)
jaccard-csvs = $(nt_inputs:%=jaccard_%.csv)

jaccard-%-Rplots.pdf: jaccard_%.csv jaccard_%.r
	R -q --save < jaccard_$*.r
jaccard_%.csv jaccard_%.txt:  visualize.py quotations.sqlite3
	python3 visualize.py nt_jaccard $*
jaccard_%-sorted.txt: jaccard_%.txt
	sort $< > $@
jaccard-multi-Rplots.pdf: $(jaccard-csvs) jaccard_multi.r
	R -q --save < jaccard_multi.r

jaccard: jaccard-Psalms-Rplots.pdf jaccard_Psalms-sorted.txt \
 $(jaccard-Rplots-pdfs) $(jaccard-sorted-txts) \
 jaccard-multi-Rplots.pdf

# No-Jaccard
nojaccard: getrefs.pdf authors.pdf manual_nt_length.pdf Rplots.pdf \
 $(getrefs-pngs) $(table-pdfs) $(Rplots-pdfs) \
 multi-Rplots.pdf \
 nt_frequencies.csv ot_frequencies.csv \
 selftest

getrefs-pngs = $(nt_inputs:%=%-getrefs.png)
getrefs-ppms = $(nt_inputs:%=%-getrefs.ppm)
table-texs = $(nt_inputs:%=%-table.tex)
Rplots-pdfs = $(nt_inputs:%=%-Rplots.pdf)
table-pdfs = $(nt_inputs:%=%-table.pdf)

jaccard-%-Rplots.pdf: jaccard_%.csv jaccard_%.r
	R -q --save < jaccard_$*.r

%-getrefs.png: %-getrefs.ppm
	convert $< png:$@
%-table.tex: visualize.py quotations.sqlite3
	python3 visualize.py nt_latex $* > $@
%-Rplots.pdf: manual_%_length.csv manual_%_length.r
	R -q --save < manual_$*_length.r
%-table.pdf: %-table.tex
	pdflatex $<

Hebrews-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Hebrews 26307 165 160
Romans-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm
Matthew-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Matthew 90007 356 253

# Multiple plots

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
