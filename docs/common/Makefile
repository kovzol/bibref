all: jaccard nojaccard

authors.pdf: authors.tex
	pdflatex authors

manual_nt_length.pdf: manual_nt_length.tex
	pdflatex manual_nt_length

getrefs.pdf: getrefs.tex
	pdflatex getrefs

nt_inputs = Matthew Romans Acts Hebrews

# Jaccard (NT)
nt-jaccard-Rplots-pdfs = $(nt_inputs:%=nt-jaccard-%-Rplots.pdf)
nt-jaccard-sorted-txts = $(nt_inputs:%=nt-jaccard_%-sorted.txt)
nt-jaccard-csvs = $(nt_inputs:%=nt-jaccard_%.csv)
# For removal:
nt-jaccard-txts = $(nt_inputs:%=nt-jaccard_%.txt)

nt-jaccard-%-Rplots.pdf: nt-jaccard_%.csv nt-jaccard_%.r
	R -q --save < nt-jaccard_$*.r
nt-jaccard_%.csv nt-jaccard_%.txt: visualize.py quotations.sqlite3
	python3 visualize.py nt_jaccard $*
nt-jaccard_%-sorted.txt: nt-jaccard_%.txt
	sort $< > $@
nt-jaccard-multi-Rplots.pdf: $(jaccard-csvs) nt-jaccard_multi.r
	R -q --save < nt-jaccard_multi.r

ot_inputs = Psalms Isaiah

# Jaccard (OT)
ot-jaccard-Rplots-pdfs = $(ot_inputs:%=ot-jaccard-%-Rplots.pdf)
ot-jaccard-sorted-txts = $(ot_inputs:%=ot-jaccard_%-sorted.txt)
ot-jaccard-csvs = $(ot_inputs:%=ot-jaccard_%.csv)
# For removal:
ot-jaccard-txts = $(ot_inputs:%=ot-jaccard_%.txt)

ot-jaccard-%-Rplots.pdf: ot-jaccard_%.csv ot-jaccard_%.r
	R -q --save < ot-jaccard_$*.r
ot-jaccard_%.csv ot-jaccard_%.txt: visualize.py quotations.sqlite3
	python3 visualize.py ot_jaccard $*
ot-jaccard_%-sorted.txt: ot-jaccard_%.txt
	sort $< > $@

jaccard: \
 $(ot-jaccard-Rplots-pdfs) $(ot-jaccard-sorted-txts) \
 $(nt-jaccard-Rplots-pdfs) $(nt-jaccard-sorted-txts) \
 nt-jaccard-multi-Rplots.pdf
# ot-jaccard-multi-Rplots.pdf


# No-Jaccard
getrefs-pngs = $(nt_inputs:%=%-getrefs.png)
getrefs-ppms = $(nt_inputs:%=%-getrefs.ppm)
table-texs = $(nt_inputs:%=%-table.tex)
Rplots-pdfs = $(nt_inputs:%=%-Rplots.pdf)
table-pdfs = $(nt_inputs:%=%-table.pdf)
# For removal
table-auxs = $(nt_inputs:%=%-table.aux)
table-logs = $(nt_inputs:%=%-table.log)
nt-manual_length-csvs = $(nt_inputs:%=manual_%_length.csv)
ot-manual_length-csvs = $(ot_inputs:%=manual_%_length.csv)

%-getrefs.png: %-getrefs.ppm
	convert $< png:$@
%-table.tex manual_%_length.csv: visualize.py quotations.sqlite3
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
	rm -f quotations.sqlite3  authors.aux manual_nt_length.aux getrefs.aux \
         authors.log manual_nt_length.log getrefs.log .RData 
	rm -f $(table-auxs) $(table-logs)

fullclean: clean
	rm -f authors.tex manual_nt_length.tex getrefs.tex
	rm -f authors.pdf getrefs.pdf manual_nt_length.pdf Rplots.pdf
	rm -f $(ot-jaccard-Rplots-pdfs) $(ot-jaccard-txts) $(ot-jaccard-sorted-txts) $(ot-jaccard-csvs)
	rm -f $(nt-jaccard-Rplots-pdfs) $(nt-jaccard-txts) $(nt-jaccard-sorted-txts) $(nt-jaccard-csvs)
	rm -f $(getrefs-pngs) $(getrefs-ppms) $(table-texs) $(Rplots-pdfs) $(table-pdfs)
	rm -f $(nt-manual_length-csvs) $(ot-manual-length-csvs) manual_nt_length.csv multi-Rplots.pdf nt_frequencies.csv ot_frequencies.csv

.PHONY: clean fullclean all selftest
.PRECIOUS: $(table-texs)
