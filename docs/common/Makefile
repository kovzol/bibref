all: jaccard nojaccard

authors.pdf: authors.tex
	pdflatex authors

manual_nt_length.pdf: manual_nt_length.tex
	pdflatex manual_nt_length

getrefs.pdf: getrefs.tex
	pdflatex getrefs

nt_inputs = Matthew Romans Acts Hebrews

# Jaccard
jaccard-Rplots-pdfs = $(nt_inputs:%=jaccard-%-Rplots.pdf)
jaccard-sorted-txts = $(nt_inputs:%=jaccard_%-sorted.txt)
jaccard-csvs = $(nt_inputs:%=jaccard_%.csv)
# For removal:
jaccard-txts = $(nt_inputs:%=jaccard_%.txt)

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
getrefs-pngs = $(nt_inputs:%=%-getrefs.png)
getrefs-ppms = $(nt_inputs:%=%-getrefs.ppm)
table-texs = $(nt_inputs:%=%-table.tex)
Rplots-pdfs = $(nt_inputs:%=%-Rplots.pdf)
table-pdfs = $(nt_inputs:%=%-table.pdf)
# For removal
table-auxs = $(nt_inputs:%=%-table.aux)
table-logs = $(nt_inputs:%=%-table.log)
manual_length-csvs = $(nt_inputs:%=manual_%_length.csv)

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

Matthew-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Matthew 90007 356 253
Acts-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Acts 95651 368 260
Romans-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm
Hebrews-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Hebrews 26307 165 160

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

nojaccard: getrefs.pdf authors.pdf manual_nt_length.pdf Rplots.pdf \
 $(getrefs-pngs) $(table-pdfs) $(Rplots-pdfs) \
 multi-Rplots.pdf \
 nt_frequencies.csv ot_frequencies.csv \
 selftest

clean:
	rm -f quotations.sqlite3 authors.tex manual_nt_length.tex getrefs.tex \
 authors.aux manual_nt_length.aux getrefs.aux \
 authors.log manual_nt_length.log getrefs.log \
 .RData 
	rm -f $(table-auxs) $(table-logs)
	rm -f jaccard_Psalms.txt

fullclean: clean
	rm -f authors.pdf getrefs.pdf manual_nt_length.pdf Rplots.pdf
	rm -f $(jaccard-Rplots-pdfs) $(jaccard-txts) $(jaccard-sorted-txts) $(jaccard-csvs)
	rm -f $(getrefs-pngs) $(getrefs-ppms) $(table-texs) $(Rplots-pdfs) $(table-pdfs)
	rm -f jaccard-Psalms-Rplots.pdf jaccard-multi-Rplots.pdf jaccard_Psalms-sorted.txt jaccard_Psalms.csv
	rm -f $(manual_length-csvs) manual_nt_length.csv multi-Rplots.pdf nt_frequencies.csv ot_frequencies.csv

.PHONY: clean fullclean all selftest
