all: getrefs.pdf traditional.pdf

traditional.pdf: traditional.tex
	pdflatex traditional

getrefs.pdf: getrefs.tex
	pdflatex getrefs

traditional.tex: visualize.py psalms.sqlite3
	python3 visualize.py traditional > traditional.tex

getrefs.tex: visualize.py psalms.sqlite3
	python3 visualize.py getrefs > getrefs.tex

psalms.sqlite3: psalms.sql
	./dropdb
	./createdb

clean:
	rm -f psalms.sqlite3 traditional.tex getrefs.tex traditional.aux getrefs.aux traditional.log getrefs.log

fullclean: clean
	rm -f traditional.pdf getrefs.pdf

.PHONY: clean fullclean all
