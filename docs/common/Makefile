all: visualized.pdf

visualized.pdf: visualized.tex
	pdflatex visualized

visualized.tex: visualize.py psalms.sqlite3
	python3 visualize.py > visualized.tex

psalms.sqlite3: psalms.sql
	./dropdb
	./createdb

clean:
	rm -f psalms.sqlite3 visualized.tex visualized.aux visualized.log

fullclean: clean
	rm -f visualized.pdf

.PHONY: clean fullclean all

