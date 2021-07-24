PDFLATEX = pdflatex -interaction batchmode
R = R -q --save -f

all: jaccard nojaccard selftest

authors.pdf: authors.tex
	$(PDFLATEX) authors

manual_nt_length.pdf: manual_nt_length.tex
	$(PDFLATEX) manual_nt_length

getrefs.pdf: getrefs.tex
	$(PDFLATEX) getrefs

nt_inputs = Matthew Romans Acts Hebrews

# Jaccard (NT)
nt-jaccard-Rplots-pdfs = $(nt_inputs:%=nt-jaccard-%-Rplots.pdf)
nt-jaccard-sorted-txts = $(nt_inputs:%=nt-jaccard_%-sorted.txt)
nt-jaccard-csvs = $(nt_inputs:%=nt-jaccard_%.csv)
# For removal:
nt-jaccard-txts = $(nt_inputs:%=nt-jaccard_%.txt)

nt-jaccard-%-Rplots.pdf: nt-jaccard_%.csv nt-jaccard_%.r
	$(R) nt-jaccard_$*.r
nt-jaccard_%.csv nt-jaccard_%.txt: visualize.py quotations.sqlite3
	python3 visualize.py nt_jaccard $*
nt-jaccard_%-sorted.txt: nt-jaccard_%.txt
	sort $< > $@
nt-jaccard-multi-Rplots.pdf: $(jaccard-csvs) nt-jaccard_multi.r
	$(R) nt-jaccard_multi.r

ot_inputs = Psalms Isaiah

# Jaccard (OT)
ot-jaccard-Rplots-pdfs = $(ot_inputs:%=ot-jaccard-%-Rplots.pdf)
ot-jaccard-sorted-txts = $(ot_inputs:%=ot-jaccard_%-sorted.txt)
ot-jaccard-csvs = $(ot_inputs:%=ot-jaccard_%.csv)
# For removal:
ot-jaccard-txts = $(ot_inputs:%=ot-jaccard_%.txt)

ot-jaccard-%-Rplots.pdf: ot-jaccard_%.csv ot-jaccard_%.r
	$(R) ot-jaccard_$*.r
ot-jaccard_%.csv ot-jaccard_%.txt: visualize.py quotations.sqlite3
	python3 visualize.py ot_jaccard $*
ot-jaccard_%-sorted.txt: ot-jaccard_%.txt
	sort $< > $@

nt-passage-info.txt: visualize.py quotations.sqlite3
	python3 visualize.py nt_passage_info all > nt-passage-info.txt


jaccard: \
 $(ot-jaccard-Rplots-pdfs) $(ot-jaccard-sorted-txts) \
 $(nt-jaccard-Rplots-pdfs) $(nt-jaccard-sorted-txts) \
 nt-jaccard-multi-Rplots.pdf \
 nt-passage-info.txt
# ot-jaccard-multi-Rplots.pdf


# No-Jaccard (NT)
getrefs-pngs = $(nt_inputs:%=%-getrefs.png)
getrefs-ppms = $(nt_inputs:%=%-getrefs.ppm)
nt-table-texs = $(nt_inputs:%=nt-%-table.tex)
nt-Rplots-pdfs = $(nt_inputs:%=nt-%-Rplots.pdf)
nt-table-pdfs = $(nt_inputs:%=nt-%-table.pdf)
# For removal
nt-table-auxs = $(nt_inputs:%=nt-%-table.aux)
nt-table-logs = $(nt_inputs:%=nt-%-table.log)
nt-manual_length-csvs = $(nt_inputs:%=nt-manual_%_length.csv)

%-getrefs.png: %-getrefs.ppm
	convert $< png:$@
nt-%-table.tex nt-manual_%_length.csv: visualize.py quotations.sqlite3
	python3 visualize.py nt_latex $* > $@
nt-%-Rplots.pdf: nt-manual_%_length.csv nt-manual_%_length.r
	$(R) nt-manual_$*_length.r
nt-%-table.pdf: nt-%-table.tex
	$(PDFLATEX) $<


# No-Jaccard (OT)
ot-table-texs = $(ot_inputs:%=ot-%-table.tex)
ot-Rplots-pdfs = $(ot_inputs:%=ot-%-Rplots.pdf)
ot-table-pdfs = $(ot_inputs:%=ot-%-table.pdf)
# For removal
ot-table-auxs = $(ot_inputs:%=ot-%-table.aux)
ot-table-logs = $(ot_inputs:%=ot-%-table.log)
ot-manual_length-csvs = $(ot_inputs:%=ot-manual_%_length.csv)

ot-%-table.tex ot-manual_%_length.csv: visualize.py quotations.sqlite3
	python3 visualize.py ot_latex $* > $@
ot-%-Rplots.pdf: ot-manual_%_length.csv ot-manual_%_length.r
	$(R) ot-manual_$*_length.r
ot-%-table.pdf: ot-%-table.tex
	$(PDFLATEX) $<


Matthew-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Matthew 90007 356 253
Acts-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Acts 95651 368 260
Romans-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm
Hebrews-getrefs.ppm: visualize.py quotations.sqlite3
	python3 visualize.py nt_ppm Hebrews 26307 165 160

# Multiple plots

multi-Rplots.pdf: nt-manual_Matthew_length.csv nt-manual_Romans_length.csv nt-manual_Hebrews_length.csv manual_multi_length.r
	$(R) manual_multi_length.r

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
	$(R) manual_nt_length.r

nt_frequencies.csv: visualize.py quotations.sqlite3
	python3 visualize.py nt_freq_csv

ot_frequencies.csv: visualize.py quotations.sqlite3
	python3 visualize.py ot_freq_csv

selftest:
	./selftest.py

nojaccard: getrefs.pdf authors.pdf manual_nt_length.pdf Rplots.pdf \
 $(getrefs-pngs) $(nt-table-pdfs) $(nt-Rplots-pdfs) \
 $(ot-table-pdfs) $(ot-Rplots-pdfs) \
 multi-Rplots.pdf \
 nt_frequencies.csv ot_frequencies.csv

clean:
	rm -f quotations.sqlite3  authors.aux manual_nt_length.aux getrefs.aux \
         authors.log manual_nt_length.log getrefs.log .RData 
	rm -f $(nt-table-auxs) $(nt-table-logs)
	rm -f $(ot-table-auxs) $(ot-table-logs)

fullclean: clean
	rm -f authors.tex manual_nt_length.tex getrefs.tex
	rm -f authors.pdf getrefs.pdf manual_nt_length.pdf Rplots.pdf
	rm -f $(ot-jaccard-Rplots-pdfs) $(ot-jaccard-txts) $(ot-jaccard-sorted-txts) $(ot-jaccard-csvs)
	rm -f $(nt-jaccard-Rplots-pdfs) $(nt-jaccard-txts) $(nt-jaccard-sorted-txts) $(nt-jaccard-csvs)
	rm -f $(getrefs-pngs) $(getrefs-ppms) $(nt-table-texs) $(nt-Rplots-pdfs) $(nt-table-pdfs)
	rm -f $(ot-table-texs) $(ot-Rplots-pdfs) $(ot-table-pdfs)
	rm -f $(nt-manual_length-csvs) $(ot-manual-length-csvs) manual_nt_length.csv multi-Rplots.pdf nt_frequencies.csv ot_frequencies.csv

.PHONY: clean fullclean all selftest
.PRECIOUS: $(ot-table-texs) $(nt-table-texs)
