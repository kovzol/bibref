all: getrefs.pdf authors.pdf manual_nt_length.pdf

authors.pdf: authors.tex
	pdflatex authors

manual_nt_length.pdf: manual_nt_length.tex
	pdflatex manual_nt_length

getrefs.pdf: getrefs.tex
	pdflatex getrefs

authors.tex: visualize.py psalms.sqlite3
	python3 visualize.py traditional > authors.tex

manual_nt_length.tex: visualize.py psalms.sqlite3
	python3 visualize.py traditional manual_nt_length > manual_nt_length.tex

getrefs.tex: visualize.py psalms.sqlite3
	python3 visualize.py getrefs > getrefs.tex

psalms.sqlite3: psalms.sql
	./dropdb
	./createdb

clean:
	rm -f psalms.sqlite3 authors.tex manual_nt_length.tex getrefs.tex authors.aux manual_nt_length.aux getrefs.aux authors.log manual_nt_length.log getrefs.log

fullclean: clean
	rm -f authors.pdf getrefs.pdf manual_nt_length.pdf

.PHONY: clean fullclean all
