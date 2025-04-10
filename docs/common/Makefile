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

nt-passage-info.tex: visualize.py quotations.sqlite3
	python3 visualize.py nt_passage_info all > $@
nt-passage-info.pdf: nt-passage-info.tex
	pdflatex $<

ot-passage-info.tex: visualize.py quotations.sqlite3
	python3 visualize.py ot_passage_info all > $@
ot-passage-info.pdf: ot-passage-info.tex
	pdflatex $<

nt-passage-info-content.tex: visualize.py quotations.sqlite3
	python3 visualize.py nt_passage_info_content all 2 > $@
nt-passage-info-content.pdf: nt-passage-info-content.tex
	pdflatex $<

ot-passage-info-content.tex: visualize.py quotations.sqlite3
	python3 visualize.py ot_passage_info_content all 2 > $@
ot-passage-info-content.pdf: ot-passage-info-content.tex
	pdflatex $<

jaccard: \
 $(ot-jaccard-Rplots-pdfs) $(ot-jaccard-sorted-txts) \
 $(nt-jaccard-Rplots-pdfs) $(nt-jaccard-sorted-txts) \
 nt-jaccard-multi-Rplots.pdf \
 nt-passage-info.pdf ot-passage-info.pdf \
 nt-passage-info-content.pdf ot-passage-info-content.pdf \
 svgs cl-svgs cg-svgs
# ot-jaccard-multi-Rplots.pdf

# SVG outputs:
# Romans: literal \n fuzzy1 (introduction) \n fuzzy3 (rest) \n fuzzy2 (explanation) \n Matthew 4:7 and Luke 4:12)
verified-quotations = 181 1033 20021 20031 20041 20051 20061 21011 13011 1051 14011 1091 131 24021 21031 22025 281 24051 1161 1171 \
 10011 251 51 20011 231 11011 21021 1041 \
 1061 22011 24011 1081 1101 1111 42011 42021 1121 291 1131 1031 24041 31011 1151 121 \
 441 \
 24081 24082
# Psalms
verified-quotations += 401 402 403 404 405 411 \
 221 \
 11 21 22 71 81 51 111 121 131 142 151 161 181 201 211 231 241 251 261 271 281 291 301 311 481 321 511 341 342 \
  351 361 371 381 391 421 431 441 451 461 462 463 464 501
# Isaiah
verified-quotations += 1011 1231 1092 1261 1362 1363 1365 1181 1371 1372 1242 1244 1301 1431 1321 1271 1101 1111 1421 \
 1241 1031 1032 1251 1222 1221 1161 1131 1451 1281 1151 1311 1312 \
1243 \
1121 1364 1361 91361 \
1061 1041 91041 1201 \
1073 1351 21111 13062 \
1392 1411 \
1441 1313 1401
# Acts 7
verified-quotations += 20171 20191 920181 20211 21181 21191 21201 21134 24201 16011 1421
# Matthew
verified-quotations += 15011

svgs: $(verified-quotations:%=svg/%.svg)
svg/%.svg: svg/%.tex
	cd svg && pdflatex -shell-escape $*
svg/%.tex: visualize.py quotations.sqlite3
	mkdir -p svg
	python3 visualize.py nt_passage_info $* svg > $@

verified-quotations-content = 1121 1364 1361 91361 1061 1041 91041 1201 1073 1351 21111 13062 1363 311 \
 1081 1033 1392 1411 1441 1313 1401 \
 20171 20191 920181 20211 21181 21191 21201 21134 24201 16011 1421 \
 1181
verified-quotations-content += 15011


cl-svgs: $(verified-quotations-content:%=cl-svg/%.svg)
cl-svg/%.svg: cl-svg/%.tex
	cd cl-svg && pdflatex -shell-escape $*
cl-svg/%.tex: visualize.py quotations.sqlite3
	mkdir -p cl-svg
	python3 visualize.py nt_passage_info_content $* svg 1 > $@

cg-svgs: $(verified-quotations-content:%=cg-svg/%.svg)
cg-svg/%.svg: cg-svg/%.tex
	cd cg-svg && pdflatex -shell-escape $*
cg-svg/%.tex: visualize.py quotations.sqlite3
	mkdir -p cg-svg
	python3 visualize.py nt_passage_info_content $* svg 2 > $@

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

graphviz: ot_nt.png

ot_nt.dot: visualize.py quotations.sqlite3
	python3 visualize.py ot_nt_graphviz

ot_nt.png: ot_nt.dot
	dot -Kneato -Tpng $< > $@

ot_nt.gif: ot_nt.dot
	./ot_nt_gif

graphviz_hu: ot_nt-hu.png

ot_nt-hu.dot: visualize.py quotations.sqlite3
	python3 visualize.py ot_nt_graphviz hu

ot_nt-hu.png: ot_nt-hu.dot
	dot -Kneato -Tpng $< > $@

ot_nt-hu.gif: ot_nt-hu.dot
	./ot_nt_gif hu

graphviz_en: ot_nt-en.png

ot_nt-en.dot: visualize.py quotations.sqlite3
	python3 visualize.py ot_nt_graphviz en

ot_nt-en.png: ot_nt-en.dot
	dot -Kneato -Tpng $< > $@

ot_nt-en.gif: ot_nt-en.dot
	./ot_nt_gif en

selftest:
	./selftest.py

nojaccard: getrefs.pdf authors.pdf manual_nt_length.pdf Rplots.pdf \
 $(getrefs-pngs) $(nt-table-pdfs) $(nt-Rplots-pdfs) \
 $(ot-table-pdfs) $(ot-Rplots-pdfs) \
 multi-Rplots.pdf \
 nt_frequencies.csv ot_frequencies.csv

statements.brst: visualize.py quotations.sqlite3
	python3 visualize.py statements > statements.brst

statements.brst.html: statements.brst
	highlight --config-file=brst.lang statements.brst -u utf8 -o statements.brst.html

statements-files: visualize.py quotations.sqlite3
	python3 visualize.py statements-files

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

.PHONY: clean fullclean all selftest statements-files
.PRECIOUS: $(ot-table-texs) $(nt-table-texs)
