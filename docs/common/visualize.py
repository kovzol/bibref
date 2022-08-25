#!/usr/bin/python3
# Several pieces of this code were taken from https://www.sqlitetutorial.net/sqlite-python/sqlite-python-select/

import sqlite3, sys, pexpect, os, re
from sqlite3 import Error

bibref = None

def create_connection(db_file):
    """
    Create a database connection to the SQLite database specified by the db_file
    :param db_file: database file
    :return: Connection object or None
    """
    conn = None
    try:
        conn = sqlite3.connect(db_file)
    except Error as e:
        print(e)

    return conn

def latin_to_greek(latin):
    greek = latin
    # First, an utf-8 conversion:
    greek = greek.replace("a", "α");
    greek = greek.replace("b", "β");
    greek = greek.replace("c", "ψ");
    greek = greek.replace("d", "δ");
    greek = greek.replace("e", "ε");
    greek = greek.replace("f", "φ");
    greek = greek.replace("g", "γ");
    greek = greek.replace("h", "η");
    greek = greek.replace("i", "ι");
    greek = greek.replace("j", "ξ");
    greek = greek.replace("k", "κ");
    greek = greek.replace("l", "λ");
    greek = greek.replace("m", "μ");
    greek = greek.replace("n", "ν");
    greek = greek.replace("o", "ο");
    greek = greek.replace("p", "π");
    greek = greek.replace("q", "ζ");
    greek = greek.replace("r", "ρ");
    greek = greek.replace("s", "σ");
    greek = greek.replace("t", "τ");
    greek = greek.replace("u", "θ");
    greek = greek.replace("v", "ω");
    greek = greek.replace("w", "ς"); # unused
    greek = greek.replace("x", "χ");
    greek = greek.replace("y", "υ");
    return "\selectlanguage{greek}" + greek + "\selectlanguage{english}"

    # This part is not used, because the Greek letters in math mode
    # will be italicized automatically and that's too wide.
    # ...Then, each utf-8 character will be converted into plain latex:
    greek = greek.replace("α", "\\alpha ")
    greek = greek.replace("β", "\\beta ")
    greek = greek.replace("ψ", "\psi ")
    greek = greek.replace("δ", "\delta ")
    greek = greek.replace("ε", "\\varepsilon ")
    greek = greek.replace("φ", "\phi ")
    greek = greek.replace("γ", "\gamma ")
    greek = greek.replace("η", "\eta ")
    greek = greek.replace("ι", "\iota ")
    greek = greek.replace("ξ", "\\xi ")
    greek = greek.replace("κ", "\kappa ")
    greek = greek.replace("λ", "\lambda ")
    greek = greek.replace("μ", "\mu ")
    greek = greek.replace("ν", "\\nu ")
    greek = greek.replace("ο", "o")
    greek = greek.replace("π", "\pi ")
    greek = greek.replace("ζ", "\zeta ")
    greek = greek.replace("ρ", "\\rho ")
    greek = greek.replace("σ", "\sigma ")
    greek = greek.replace("τ", "\\tau ")
    greek = greek.replace("θ", "\\theta ")
    greek = greek.replace("ω", "\\omega ")
    greek = greek.replace("ς", "c") # unused
    greek = greek.replace("χ", "\chi ")
    greek = greek.replace("υ", "\\upsilon ")
    return "$" + greek + "$"

def psalms_report_latex(conn, method, data):
    """
    Query all entries in the Psalms database rows and show them as a LaTeX table on stdout
    :param conn: the Connection object
    :param method: traditional, getrefs
    :param data: authors or manual_nt_length (for traditional), pieces (for getrefs)
    """
    cur = conn.cursor()

    print ("\\documentclass{article}")
    if method == "traditional" and data == "authors":
        print ("\\usepackage{mathtools}")
        print ("\\usepackage[dvipsnames]{xcolor}")
        print ("\\newcommand\\Luke{{\color{Lavender}\\bullet}\mathllap{\color{Lavender}\circ}}")
        print ("\\newcommand\\Paul{{\color{YellowGreen}\\bullet}\mathllap{\color{YellowGreen}\circ}}")
        print ("\\newcommand\\Unknown{{\color{Orchid}\\bullet}\mathllap{\color{Orchid}\circ}}")
        print ("\\newcommand\\Matthew{{\color{Red}\\bullet}\mathllap{\color{Red}\circ}}")
        print ("\\newcommand\\Mark{{\color{Cyan}\\bullet}\mathllap{\color{Cyan}\circ}}")
        print ("\\newcommand\\John{{\color{GreenYellow}\\bullet}\mathllap{\color{GreenYellow}\circ}}")
        print ("\\newcommand\\Peter{{\color{NavyBlue}\\bullet}\mathllap{\color{NavyBlue}\circ}}")
    if method == "traditional" and data == "manual_nt_length":
        print ("\\usepackage{graphicx}")
        f = open("manual_nt_length.csv", "w")
    print ("\\begin{document}")
    print ("\\centering")
    print ("\\begin{table}")
    if method == "traditional" and data == "manual_nt_length":
        print ("\\scriptsize")
    print ("\\begin{tabular}{r|cccccccccc}")
    for i in range(0,10):
        print ("&{\\bf", i+1, "}", end = '', sep = '')
    print ("\\\\")
    print ("\\hline")
    quotations = 0
    psalms = 0
    for psalm in range(1,151):
        if psalm % 10 == 1:
            print ("{\\bf ", round(psalm/10), "}&", end = '', sep = '')
        if method == "bibref":
            global bibref
            spawn_bibref()
            bibref.timeout = 180
            command = "getrefs SBLGNT LXX Psalms " + str(psalm)
            bibref.sendline(command)
            bibref.expect("Finished")
            lines = bibref.before.decode('utf-8').splitlines()
            no_lines = len(lines)
            length_regex = re.compile(r'length=([0-9]+),')
            # print(lines[no_lines - 1])
            found = length_regex.search(lines[no_lines - 1])
            maxlength0 = found.group()
            maxlength1 = maxlength0.split("=")
            maxlength2 = maxlength1[1]
            maxlength3 = maxlength2.split(",")
            maxlength = maxlength3[0]
            bibref.timeout = 5
            print ("\n", "% Psalm ", psalm, sep = '')
            print (maxlength)
        else:
            cur.execute("SELECT q.ot_id, q.nt_id, q.nt_book, a.name" +
                " FROM quotations_with_introduction q, authors a, books b " +
                " WHERE q.psalm = " + str(psalm) +
                " AND q.found_method = '" + method + "'" +
                " AND a.name = b.author" +
                " AND b.name = q.nt_book" +
                " GROUP BY q.ot_id, q.nt_id" +
                " ORDER BY q.ot_startpos, q.ot_id, b.number")
            rows = cur.fetchall()
            if len(rows) > 0:
                print
                print ("\n", "% Psalm ", psalm, sep = '')

                old_ot_id = 0
                for row in rows:
                    author = row[3]
                    ot_id = row[0]
                    nt_id = row[1]
                    if method == "getrefs" and data == 'pieces':
                        cur.execute("SELECT COUNT(*) FROM quotations q" +
                            " WHERE ot_id = " + str(ot_id) +
                            " AND nt_id = " + str(nt_id) +
                            " AND q.found_method = '" + method + "'");
                        info = cur.fetchall()
                        info = info[0][0]
                    if method == "traditional" and data == "manual_nt_length":
                        cur.execute("SELECT nt_length FROM quotations q" +
                            " WHERE ot_id = " + str(ot_id) +
                            " AND nt_id = " + str(nt_id) +
                            " AND q.found_method = 'manual'");
                        info = cur.fetchall()
                        number_str = str(info[0][0])
                        f.write(number_str + "\n")
                        info = "\scalebox{.6}[1.0]{" + number_str + "}"
                    if old_ot_id > 0 and ot_id != old_ot_id:
                        print(",", sep = '', end = '')
                    else:
                        if method == "traditional" and data == "manual_nt_length":
                            if old_ot_id != 0:
                                info = "\," + info
                    if data != 'authors':
                        print (info, sep='', end='')
                    else:
                        print ("$\\", author, "$", sep = '', end = '')
                    old_ot_id = ot_id
                    print("%", row)
                    quotations += 1
            psalms += 1
        if psalm % 10 == 0:
            print ("\\\\")
        else:
            print ("&", end = '', sep = '')
    print ("%", quotations, "quotations in", psalms, "psalms")
    print ("\\end{tabular}")
    print ("\\end{table}")
    print ("\\end{document}")
    if method == "traditional" and data == "manual_nt_length":
        f.close()

def nt_report_ppm(conn, book, book_length, ppm_rows, ppm_columns, mode):
    """
    Query all entries from a New Testament book and show them as PPM data in the file book-mode.ppm
    :param conn: the Connection object
    :param book: NT book name
    :param book_length: NT book length in characters
    :param ppm_rows: number of pixel rows in PPM output
    :param ppm_columns: number of pixel columns in PPM output
    """
    f = open(book + "-" + mode + ".ppm", "w")
    cur = conn.cursor()
    book_letters = [0] * book_length
    cur.execute("SELECT q.nt_startpos, q.nt_length, q.ot_book, q.ot_passage, q.nt_passage" +
        " FROM quotations q, quotations_classifications qc " +
        " WHERE qc.classification = 'quotation'" +
        " AND qc.quotation_ot_id = q.ot_id" +
        " AND qc.quotation_nt_id = q.nt_id" +
        " AND q.found_method = 'manual'" +
        " AND q.nt_book = '" + book + "'" +
        " ORDER BY q.nt_startpos")
    rows = cur.fetchall()
    q = 0

    f.write("P3\n")
    f.write(f"# Report on {book}, mode {mode}\n")

    # Meaning of entries for the various modes:

    # manual: 0: no quotation, 1: one quotation, 2: two quotations

    # getrefs:
    # 0: no quotation
    # 1: first quotation without getrefs-match
    # 2: second quotation without getrefs-match
    # 3: getrefs incorrectly identified some characters
    # 4: first quotation with getrefs-match
    # 5: second quotation with getrefs-match
    # 7: first quotation with two getrefs-matches
    # TODO: add repetition

    # FIXME: This system should be improved. Instead of numbers, flags should be used first.

    for row in rows:
        start = row[0]
        length = row[1]
        ot_book = row[2]
        ot_passage = row[3]
        nt_passage = row[4]
        print("start =", start, "length =", length, f"({ot_passage} -> {nt_passage})")
        for l in range(length):
            book_letters[start+l] += 1
        q += 1

    if mode == "getrefs":
        cur.execute("SELECT q.nt_startpos, q.nt_length, q.ot_book, q.ot_passage, q.nt_passage" +
            " FROM quotations_with_introduction q " +
            " WHERE q.found_method = 'getrefs'" +
            " AND q.nt_book = '" + book + "'" +
            " ORDER BY q.nt_startpos")
        rows2 = cur.fetchall()
        for row2 in rows2:
            start = row2[0]
            length = row2[1]
            for l in range(length):
                book_letters[start+l] += 3

    r = 0
    f.write(f"{ppm_columns} {ppm_rows}\n15\n")

    for l in range(book_length):
        info = book_letters[l]
        if info == 0:
            f.write("7 7 7\n") # no quotation at that position
        else:
            r += 1
        if info == 1:
            f.write("7 0 0\n") # 1. quotation
        if info == 2:
            f.write("0 7 0\n") # 2. quotation
        if info == 3:
            f.write("0 0 0\n") # false identification
            r -= 1
        if info == 4:
            f.write("15 0 0\n") # 1. quotation with getrefs-match
        if info == 5:
            f.write("0 15 0\n") # 2. quotation with getrefs-match
        if info == 7:
            f.write("15 0 15\n") # 1. quotation with two getrefs-matches
        if info == 6 or info >= 8:
            print("Warning, ambiguous situation: position",l,"modesum",info)
            f.write("15 15 0\n") # TODO: investigate this situation
            # exit(1)
    for l in range(ppm_rows*ppm_columns-book_length):
        f.write("15 15 15\n") # empty cell
    print(r, "characters of", q, "manually verified quotations out of", book_length, f"({100*r/book_length:.3g}%)")
    f.close()

def nt_report_latex(conn, book):
    """
    Query all entries from a New Testament book and show them as a LaTeX table on stdout
    :param conn: the Connection object
    :param book: NT book name
    """

    print ("\\documentclass{article}")
    print ("\\usepackage{geometry}")
    print ("\\geometry{a4paper,margin=1.5cm}")
    print ("\\begin{document}")
    print ("\\thispagestyle{empty}")
    print ("\\begin{table}")
    print ("\\centering")
    print ("\\begin{tabular}{rrlc}")
    print (f"&&&{{\\bf getrefs}}\\\\")
    print (f"{{\\bf No.}}&{{\\bf {book} passage}}&{{\\bf OT passage}}&{{\\bf chunks}}\\\\")
    print ("\\hline")

    cur = conn.cursor()
    cur.execute("SELECT q.nt_startpos, q.nt_length, q.ot_book, q.ot_passage, q.nt_passage, q.ot_id, q.nt_id" +
        " FROM quotations_with_introduction q" +
        " WHERE q.found_method = 'manual'" +
        " AND q.ot_startpos IS NOT NULL" +
        " AND q.nt_book = '" + book + "'" +
        " ORDER BY q.nt_startpos")
    rows = cur.fetchall()
    q = 1
    f = open("nt-manual_" + book + "_length.csv", "w")

    for row in rows:
        start = row[0]
        length = row[1]
        f.write(str(length) + "\n")
        ot_book = row[2]
        ot_passage = row[3].replace("_", " ")
        nt_passage = row[4]
        # Remove book name from the beginning:
        nt_passage = nt_passage[(nt_passage.find(book) + len(book)):]
        ot_id = row[5]
        nt_id = row[6]
        cur.execute("SELECT COUNT(*) from quotations q" +
            " WHERE q.ot_id = " + str(ot_id) +
            " AND q.nt_id = " + str(nt_id) +
            " AND q.found_method = 'getrefs'")
        rows2 = cur.fetchall()
        chunks = rows2[0][0]
        print(f"{q}&{nt_passage}&{ot_passage}&{chunks}\\\\")
        q = q + 1
    print ("\\end{tabular}")
    print ("\\end{table}")
    print ("\\end{document}")
    f.close()

def ot_report_latex(conn, book):
    """
    Query all entries from an Old Testament book and show them as a LaTeX table on stdout
    :param conn: the Connection object
    :param book: OT book name
    """

    print ("\\documentclass{article}")
    print ("\\usepackage{geometry}")
    print ("\\geometry{a4paper,margin=1.5cm}")
    print ("\\begin{document}")
    print ("\\thispagestyle{empty}")
    print ("\\begin{table}")
    print ("\\centering")
    print ("\\begin{tabular}{rrlc}")
    print (f"&&&{{\\bf getrefs}}\\\\")
    print (f"{{\\bf No.}}&{{\\bf {book} passage}}&{{\\bf NT passage}}&{{\\bf chunks}}\\\\")
    print ("\\hline")

    cur = conn.cursor()
    cur.execute("SELECT q.ot_startpos, q.ot_length, q.nt_book, q.nt_passage, q.ot_passage, q.ot_id, q.nt_id" +
        " FROM quotations_with_introduction q" +
        " WHERE q.found_method = 'manual'" +
        " AND q.ot_startpos IS NOT NULL" +
        " AND q.ot_book = '" + book + "'" +
        " ORDER BY q.ot_startpos")
    rows = cur.fetchall()
    q = 1
    f = open("ot-manual_" + book + "_length.csv", "w")

    for row in rows:
        start = row[0]
        length = row[1]
        f.write(str(length) + "\n")
        nt_book = row[2]
        nt_passage = row[3].replace("_", " ")
        ot_passage = row[4]
        # Remove book name from the beginning:
        ot_passage = ot_passage[(ot_passage.find(book) + len(book)):]
        ot_id = row[5]
        nt_id = row[6]
        cur.execute("SELECT COUNT(*) from quotations q" +
            " WHERE q.ot_id = " + str(ot_id) +
            " AND q.nt_id = " + str(nt_id) +
            " AND q.found_method = 'getrefs'")
        rows2 = cur.fetchall()
        chunks = rows2[0][0]
        print(f"{q}&{ot_passage}&{nt_passage}&{chunks}\\\\")
        q = q + 1
    print ("\\end{tabular}")
    print ("\\end{table}")
    print ("\\end{document}")
    f.close()

def nt_frequencies_csv(conn):
    """
    Query all New Testament books and show them as a CSV table
    :param conn: the Connection object
    """

    f = open("nt_frequencies.csv", "w")
    f.write("Book,No. of quotations\n")

    cur = conn.cursor()
    cur.execute("SELECT name, COUNT(*) FROM" +
        " (SELECT b.number as number, b.name as name" +
        " FROM quotations_with_introduction q, books b " +
        " WHERE q.nt_book = b.name" +
        " GROUP BY b.number, q.ot_id, q.nt_id" +
        " ORDER BY b.number)" +
        " GROUP BY name ORDER BY number")
    rows = cur.fetchall()
    total = 0

    for row in rows:
        book = row[0]
        frequency = row[1]
        f.write(book + "," + str(frequency) + "\n")
        total += frequency
    f.write("Total," + str(total) + "\n")
    f.close()

def ot_frequencies_csv(conn):
    """
    Query all Old Testament books and show them as a CSV table
    :param conn: the Connection object
    """

    f = open("ot_frequencies.csv", "w")
    f.write("Book,No. of quotations\n")

    cur = conn.cursor()
    cur.execute("SELECT name, COUNT(*) FROM" +
        " (SELECT b.number as number, b.name as name" +
        " FROM quotations_with_introduction q, books b " +
        " WHERE q.ot_book = b.name" +
        " GROUP BY b.number, q.ot_id" +
        " ORDER BY b.number)" +
        " GROUP BY name ORDER BY number")
    rows = cur.fetchall()
    total = 0

    for row in rows:
        book = row[0]
        frequency = row[1]
        f.write(book + "," + str(frequency) + "\n")
        total += frequency
    f.write("Total," + str(total) + "\n")
    f.close()

def ot_nt_graphviz(conn, lang=None):
    """
    Show all connections in a GraphViz diagram
    :param conn: the Connection object
    :param lang: use language lang
    """

    fontsize = 24
    if lang == "hu":
        f = open("ot_nt-hu.dot", "w")
    else:
        if lang == "en":
            f = open("ot_nt-en.dot", "w")
        else:
            f = open("ot_nt.dot", "w")
            fontsize = 14
    f.write("digraph G {\n")
    f.write(" start=\"random1\";\n") # ensure deterministic output
    f.write(" outputorder=\"edgesfirst\";\n")
    f.write(f" node [style=filled, color=cyan, fontsize=\"{fontsize}pt\"];\n")

    cur = conn.cursor()
    # NT books that contain quotations:
    cur.execute("SELECT DISTINCT q.nt_book " +
        " FROM quotations_with_introduction q, books b" +
        " WHERE q.nt_book = b.name" +
        " ORDER BY b.number")
    rows = cur.fetchall()
    for row in rows:
        # The following lines are the same in all 4 cases, TODO: unify
        book = row[0]
        pos = graphviz_positions[book]
        label = book
        if lang == "hu":
            label = books_translated_hu[book]
        if lang == "en":
            label = books_translated_en[book]
        f.write(f" {book} [label=\"{label}\", pos=\"{pos}\"];\n")
    # NT books that do not contain quotations:
    cur.execute("SELECT name, number FROM books WHERE number > 100 EXCEPT SELECT DISTINCT q.nt_book, b.number" +
        " FROM quotations_with_introduction_manual q, books b" +
        " WHERE q.nt_book = b.name" +
        " ORDER BY number")
    rows = cur.fetchall()
    for row in rows:
        book = row[0]
        pos = graphviz_positions[book]
        label = book
        if lang == "hu":
            label = books_translated_hu[book]
        if lang == "en":
            label = books_translated_en[book]
        f.write(f" {book} [label=\"{label}\", style=filled, color=cyan3, pos=\"{pos}\"];\n")

    # OT books that contain quotations:
    cur.execute("SELECT DISTINCT q.ot_book " +
        " FROM quotations_with_introduction_manual q, books b" +
        " WHERE q.ot_book = b.name" +
        " ORDER BY b.number")
    rows = cur.fetchall()
    for row in rows:
        book = row[0]
        pos = graphviz_positions[book]
        label = book
        if lang == "hu":
            label = books_translated_hu[book]
        if lang == "en":
            label = books_translated_en[book]
        f.write(f" {book} [label=\"{label}\", style=filled, color=yellow, pos=\"{pos}\"];\n")
    # OT books that do not contain quotations:
    cur.execute("SELECT name, number FROM books WHERE number < 100 EXCEPT SELECT DISTINCT q.ot_book, b.number" +
        " FROM quotations_with_introduction_manual q, books b" +
        " WHERE q.ot_book = b.name" +
        " ORDER BY number")
    rows = cur.fetchall()
    for row in rows:
        book = row[0]
        pos = graphviz_positions[book]
        label = book
        if lang == "hu":
            label = books_translated_hu[book]
        if lang == "en":
            label = books_translated_en[book]
        f.write(f" {book} [label=\"{label}\", style=filled, color=yellow3, pos=\"{pos}\"];\n")

    cur.execute("SELECT q.ot_book, q.nt_book, COUNT(*), b1.number, b2.number " +
        " FROM quotations_with_introduction_manual q, books b1, books b2" +
        " WHERE b1.name = q.ot_book AND b2.name = q.nt_book"
        " GROUP BY q.ot_book, q.nt_book" +
        " ORDER BY b2.number, b1.number")
    rows = cur.fetchall()
    for row in rows:
        ot_book, nt_book, c = row[0],row[1],row[2]
        if c == 1:
            c = " " # do not label single connections
        f.write(f" {ot_book}->{nt_book} [labeljust=\"r\", label=\"{c}\", style=\"dotted\"];\n")

    f.write("}\n")
    f.close()

def spawn_bibref():
    global bibref
    if bibref is not None:
        return
    sys.stderr.write("Waiting for bibref's full startup...\n")

    for subdir, dirs, files in os.walk('../..'):
        for file in files:
            fullpath = os.path.join(subdir, file)
            if os.access(fullpath, os.X_OK) and file == "bibref":
                sys.stderr.write(f"Spawning {fullpath}...\n");
                bibref = pexpect.spawn(fullpath + " -a")
                bibref.expect("Done loading books of SBLGNT.")
                bibref.timeout = 5
                return

    sys.stderr.write("Unsuccessful\n");
    exit(1)

def nt_jaccard_csv(conn, nt_book):
    """
    Collect all quotations from an NT book that are obtained manually and
    determine the Jaccard distances to the OT passages in a CSV file
    :param conn: the Connection object
    :param nt_book: NT book name
    """

    global bibref
    cur = conn.cursor()
    cur.execute("SELECT q.ot_passage, q.nt_passage" +
        " FROM quotations_with_introduction q" +
        " WHERE q.found_method = 'manual'" +
        " AND q.nt_book = '" + nt_book + "'" +
        " AND INSTR(q.ot_passage, 'LXX') > 0" +
        " ORDER BY q.nt_startpos")
    rows = cur.fetchall()

    spawn_bibref()

    f = open("nt-jaccard_" + nt_book + ".csv", "w")
    g = open("nt-jaccard_" + nt_book + ".txt", "w")
    r = 0
    for row in rows:
        ot_passage = row[0]
        nt_passage = row[1]
        command1 = "lookup1 " + ot_passage
        bibref.sendline(command1)
        bibref.expect("Stored internally as \w.")
        command2 = "lookup2 " + nt_passage
        bibref.sendline(command2)
        bibref.expect("Stored internally as \w.")
        # command3 = "compare12"
        command3 = "jaccard12"
        bibref.sendline(command3)
        # bibref.expect("difference = ([0-9]+\.[0-9]+).")
        bibref.expect("Jaccard distance is ([0-9]+\.[0-9]+).")
        jaccard12 = bibref.match.groups()
        jaccard = float(jaccard12[0])
        percent = int(r/len(rows)*100)
        print(f"{percent}% done\u001b[{0}K\r", end='')
        f.write(f"{jaccard}\n")
        g.write(f"{jaccard:.6f}\t{ot_passage}\t{nt_passage}\n")
        r += 1
    print(f"Done\u001b[{0}K")
    f.close()
    g.close()

def ot_jaccard_csv(conn, ot_book):
    """
    Collect all quotations from an OT book that are obtained manually and
    determine the Jaccard distances to the NT passages in a CSV file
    :param conn: the Connection object
    :param ot_book: OT book name
    """

    global bibref
    cur = conn.cursor()
    cur.execute("SELECT q.ot_passage, q.nt_passage" +
        " FROM quotations_with_introduction q" +
        " WHERE q.found_method = 'manual'" +
        " AND q.ot_startpos IS NOT NULL" +
        " AND q.ot_book = '" + ot_book + "'" +
        " AND INSTR(q.nt_passage, 'SBLGNT') > 0" +
        " ORDER BY q.ot_startpos")
    rows = cur.fetchall()

    spawn_bibref()

    f = open("ot-jaccard_" + ot_book + ".csv", "w")
    g = open("ot-jaccard_" + ot_book + ".txt", "w")
    r = 0
    for row in rows:
        ot_passage = row[0]
        nt_passage = row[1]
        command1 = "lookup1 " + ot_passage
        bibref.sendline(command1)
        bibref.expect("Stored internally as \w.")
        command2 = "lookup2 " + nt_passage
        bibref.sendline(command2)
        bibref.expect("Stored internally as \w.")
        # command3 = "compare12"
        command3 = "jaccard12"
        bibref.sendline(command3)
        # bibref.expect("difference = ([0-9]+\.[0-9]+).")
        bibref.expect("Jaccard distance is ([0-9]+\.[0-9]+).")
        jaccard12 = bibref.match.groups()
        jaccard = float(jaccard12[0])
        percent = int(r/len(rows)*100)
        print(f"{percent}% done\u001b[{0}K\r", end='')
        f.write(f"{jaccard}\n")
        g.write(f"{jaccard:.6f}\t{ot_passage}\t{nt_passage}\n")
        r += 1
    print(f"Done\u001b[{0}K")
    f.close()
    g.close()

def sort_positions():
    global nt_positions, nt_positions_info, nt_passages, ot_positions, ot_positions_info, ot_passages
    # Order the NT positions (bubble sort)
    s = 0
    for k in range(len(nt_positions)):
        for l in range(k):
            # print(k,l,nt_positions[l],nt_positions[k])
            if nt_positions[l] > nt_positions[k]:
                # swap them
                d = nt_positions[l]
                di = nt_positions_info[l]
                dp = nt_passages[l]
                nt_positions[l] = nt_positions[k]
                nt_positions_info[l] = nt_positions_info[k]
                nt_passages[l] = nt_passages[k]
                nt_positions[k] = d
                nt_positions_info[k] = di
                nt_passages[k] = dp
                s += 1

    # Order the OT positions (bubble sort)
    for m in ot_positions.keys():
        for k in range(len(ot_positions[m])):
            for l in range(k):
            # print(k,l,nt_positions[l],nt_positions[k])
                if ot_positions[m][l] > ot_positions[m][k]:
                    # swap them
                    d = ot_positions[m][l]
                    di = ot_positions_info[m][l]
                    dp = ot_passages[m][l]
                    ot_positions[m][l] = ot_positions[m][k]
                    ot_positions_info[m][l] = ot_positions_info[m][k]
                    ot_passages[m][l] = ot_passages[m][k]
                    ot_positions[m][k] = d
                    ot_positions_info[m][k] = di
                    ot_passages[m][k] = dp
                    s += 1

    # print('#', s, 'swaps')

def comment(text, format):
    """
    Print a comment to stdout according to the given format
    :param text: the text of comment
    :param format: expected format (latex, text, html, svg)
    """
    threshold = 2000 # this is needed for LaTeX since it cannot handle too long lines
    output = str(text)
    if len(output) > threshold and (format == "latex" or format == "svg"):
        output = str(output[0:threshold]) + "..."
    if format == "latex" or format == "svg":
        print("%", output)
    if format == "html":
        print("<!--", output, "-->")
    if format == "text":
        print("#", output)

def print_passage_header():
        print ("\\usepackage[utf8]{inputenc}")
        print ("\\usepackage[greek,english]{babel}")
        print ("\\usetikzlibrary{positioning}")
        print ("\\renewcommand{\\familydefault}{\\sfdefault}")
        print ("\\tikzstyle{nt_passage}=[rectangle,left color=cyan!50,right color=white,minimum size=6mm]")
        print ("\\tikzstyle{ot_passage}=[rectangle,left color=yellow!50,right color=white,minimum size=6mm]")
        print ("\\tikzstyle{intro}=[rectangle,draw=blue!50,fill=blue!20,thick,inner sep=1mm,minimum size=6mm]")
        print ("\\tikzstyle{clasp}=[rectangle,draw=blue!50,fill=ForestGreen!20,thick,inner sep=1mm,minimum size=6mm]")
        print ("\\tikzstyle{overlap}=[rectangle,draw=blue!50,fill=OliveGreen,thick,inner sep=1mm,minimum size=6mm]")
        print ("\\tikzstyle{unidentified}=[rectangle,draw=blue!20,fill=black!5,thick,inner sep=1mm,minimum size=6mm]")
        print ("\\tikzstyle{unquoted}=[rectangle,draw=blue!20,fill=black!5,thick,inner sep=1mm,minimum size=6mm]")
        print ("\\begin{document}")

def nt_passage_info(conn, nt_quotation_id, format, texts=0):
    """
    Show all relevant information on a given NT quotation
    :param conn: the Connection object
    :param nt_quotation_id: NT quotation identifier
    :param format: latex, svg, html, text
    :texts: 0 if the length is used, 1 for Latin text, 2 for Greek text
    """

    global bibref
    spawn_bibref()

    if format == "svg":
        print ("\\PassOptionsToPackage{dvipsnames}{xcolor}")
        print ("\\documentclass[tikz,convert=pdf2svg]{standalone}")
        print_passage_header()

    cur = conn.cursor()

    cur.execute("SELECT qi.nt_book, qi.nt_passage, qi.nt_startpos, qi.nt_endpos" +
        " FROM nt_quotation_introductions qi" +
        " WHERE qi.nt_quotation_id = " + str(nt_quotation_id) +
        " ORDER BY qi.nt_startpos")
    rows = cur.fetchall()
    comment("Introduction(s):", format)

    global nt_positions, nt_positions_info, nt_passages
    nt_positions = [] # relevant positions in the text, two positions for each piece of text
    nt_positions_info = [] # descriptions for each relevant position
    nt_passages = [] # passage start for the starting position (empty for ending position)
    i = 1
    # Register introductions:
    for row in rows:
        nt_book, nt_passage, nt_startpos, nt_endpos = row
        nt_positions.append(nt_startpos)
        nt_positions_info.append("intro-start " + str(i))
        nt_positions.append(nt_endpos)
        nt_positions_info.append("intro-end " + str(i))
        nt_passages.append(nt_passage)
        nt_passages.append(0) # technical, empty for ending position
        comment(f"{nt_passage} (book position: {nt_startpos}-{nt_endpos})", format)
        i += 1

    cur.execute("SELECT c.ot_book, c.ot_passage, c.nt_passage, c.ot_startpos, c.ot_length, c.nt_startpos, c.nt_length, c.ot_id, c.nt_id" +
        " FROM clasps c, quotations_classifications qc" +
        " WHERE c.nt_quotation_id = " + str(nt_quotation_id) +
        " AND c.ot_id = qc.quotation_ot_id AND c.nt_id = qc.quotation_nt_id AND qc.classification = 'quotation'" # ignore clasps that belong to repeated quotations
        " ORDER BY c.nt_startpos")
    rows2 = cur.fetchall()
    comment("Clasp(s):", format)

    global ot_positions, ot_positions_info, ot_passages
    # for each OT book a different array is created, but the concept is same as for the nt_* arrays above
    ot_positions = dict()
    ot_positions_info = dict()
    ot_passages = dict()
    ot_contents = dict()
    ot_begin = dict()
    ot_begin_pos = dict()
    j = 1 # clasp id
    clasp_ot_book = []
    clasp_jaccard = []
    clasp_nt_content = [] # Latin text
    clasp_ot_content = [] # Latin text
    jaccards = ""
    source_given = False
    # Register clasps:
    for row2 in rows2:
        ot_book, ot_passage, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, ot_id, nt_id = row2

        # We use a different color if the source is given in the quotation (this affect one of the claps now, FIXME: database issue)
        cur.execute(f"SELECT COUNT(source_given) FROM quotations_properties WHERE quotation_ot_id = {ot_id} AND quotation_nt_id = {nt_id}")
        rows3 = cur.fetchall()
        if int(rows3[0][0]) > 0:
            source_given = True

        ot_endpos = ot_startpos + ot_length - 1
        nt_endpos = nt_startpos + nt_length - 1
        if not ot_book in ot_positions:
           ot_positions[ot_book] = []
           ot_positions_info[ot_book] = []
           ot_passages[ot_book] = []
        ot_positions[ot_book].append(ot_startpos)
        ot_positions_info[ot_book].append("clasp-start " + str(j))
        ot_positions[ot_book].append(ot_endpos)
        ot_positions_info[ot_book].append("clasp-end " + str(j))
        nt_positions.append(nt_startpos)
        nt_positions_info.append("clasp-start " + str(j))
        nt_positions.append(nt_endpos)
        nt_positions_info.append("clasp-end " + str(j))
        nt_passages.append(nt_passage)
        nt_passages.append(0) # technical
        ot_passages[ot_book].append(ot_passage)
        ot_passages[ot_book].append(0) # technical
        # Read off difference:
        command1 = "lookup1 " + ot_passage
        bibref.sendline(command1)
        bibref.expect("Stored internally as \w.")
        command2 = "lookup2 " + nt_passage
        bibref.sendline(command2)
        bibref.expect("Stored internally as \w.")
        command3 = "jaccard12"
        bibref.sendline(command3)
        bibref.expect("Jaccard distance is ([0-9]+\.[0-9]+).")
        jaccard12 = bibref.match.groups()
        jaccard = float(jaccard12[0])
        command4 = "compare12"
        bibref.sendline(command4)
        # Comparing 'enarxhepoihsenoueostonoyranonkaithnghn' ~ 'kaisynetelesuhsanooyranoskaihghkaipasokosmosaytvn' = 61
        bibref.expect("Comparing '([a-z]+)' ~ '([a-z]+)' = [0-9]+.")
        ot_content_array = bibref.match.groups()
        ot_content = ot_content_array[0].decode('utf-8')
        nt_content = ot_content_array[1].decode('utf-8')
        comment(f"{ot_passage} \"{ot_content}\" -> {nt_passage} \"{nt_content}\" (book positions: {ot_startpos}-{ot_endpos} -> {nt_startpos}-{nt_endpos}, jaccard={jaccard:.6f})", format)
        clasp_ot_book.append(ot_book)
        clasp_jaccard.append(jaccard)
        clasp_ot_content.append(ot_content)
        clasp_nt_content.append(nt_content)

        jnum = (1 - jaccard) * 100
        jaccard = str(round(jaccard * 100))
        if jaccard == "0":
            jaccard = ""
        else:
            jaccard += "\%"
        found = False
        y = 1
        for m in ot_passages.keys():
            if m == ot_book:
                ot_bookindex = y
                break
            y += 1 # for a different OT book there is a different display position needed
        lwidth = str(ot_bookindex * 0.5) + "pt"
        lpos = 0.7
        if ot_bookindex == 2:
           lpos = 0.85

        jaccards += f"\\draw [->,ForestGreen!{jnum},line width={lwidth}] (clasp {j}.south) -- ({ot_book} clasp {j}.north) node [right,pos={lpos},font=\\footnotesize] {{\\textcolor{{red!{jnum}}}{{{jaccard}}}}};\n"
        j += 1 # next clasp

    sort_positions()

    # Create array to describe each letter of the texts
    nt_pos_start = nt_positions[0]
    nt_pos_end = nt_positions[-1]
    comment(f"NT: {nt_pos_start}-{nt_pos_end}", format)
    nt_len = nt_pos_end - nt_pos_start + 1
    nt_text = [""] * nt_len
    i = 1
    for row in rows:
        nt_book, nt_passage, nt_startpos, nt_endpos = row
        for k in range(nt_endpos - nt_startpos + 1):
            nt_text[nt_startpos - nt_pos_start + k] += "i" + str(i) + ","
        i += 1
    j = 1
    ot_text = dict()
    ot_pos_start = dict()
    ot_len = dict()
    for m in ot_positions.keys():
        ot_pos_start[m] = ot_positions[m][0]
        ot_pos_end = ot_positions[m][-1]
        ot_len[m] = ot_pos_end - ot_pos_start[m] + 1
        ot_text[m] = [""] * ot_len[m]
    overlapping_nt = False
    overlapping_ot = False
    overlappings = []
    overlappings_length = []

    for row2 in rows2: # for each clasp
        ot_book, ot_passage, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, ot_id, nt_id = row2
        ot_endpos = ot_startpos + ot_length - 1
        nt_endpos = nt_startpos + nt_length - 1
        ol = False
        for k in range(nt_endpos - nt_startpos + 1):
            ol_len = len(nt_text[nt_startpos - nt_pos_start + k])
            if ol_len > 0: # there is an overlap with a former entry
                if not ol: # if not registered yet
                    ol_begin = k # register start
                    ol_end = 0 # pre-register end
                    ol = True # local for this clasp
                    overlapping_nt = True # global for this passage
            else: # there is no overlap anymore
                if ol and ol_end == 0: # the former characters were in an overlapping
                    ol_end = k # register end
            nt_text[nt_startpos - nt_pos_start + k] += "c" + str(j) + "," # overlappings look like "c1,c2,"
        if ol:
            if ol_end == 0: # the end was not determined
                ol_end = k+1 # register final end at last
            overlappings.append(j-1) # hopefully (j-1) and j overlap... FIXME
            overlappings_length.append(ol_end - ol_begin)
        for k in range(ot_endpos - ot_startpos + 1):
            if len(ot_text[ot_book][ot_startpos - ot_pos_start[ot_book] + k]) > 0:
                overlapping_ot = True
            ot_text[ot_book][ot_startpos - ot_pos_start[ot_book] + k] += "c" + str(j) + ","
        j += 1
    p = 0
    u = 1
    while p < nt_len:
        if nt_text[p] == "":
            nt_positions.append(nt_pos_start + p)
            nt_positions_info.append("unidentified-start " + str(u))
            while nt_text[p] == "":
                nt_text[p] = "u" + str(u)
                p += 1
            nt_positions.append(nt_pos_start + p - 1)
            nt_positions_info.append("unidentified-end " + str(u))
            nt_passages.append(0)
            nt_passages.append(0) # technical
            u += 1
        p += 1
    for m in ot_positions.keys():
        p = 0
        while p < ot_len[m]:
            if ot_text[m][p] == "":
                ot_positions[m].append(ot_pos_start[m] + p)
                ot_positions_info[m].append("unquoted-start " + str(u))
                while ot_text[m][p] == "":
                    ot_text[m][p] = "u" + str(u)
                    p += 1
                ot_positions[m].append(ot_pos_start[m] + p - 1)
                ot_positions_info[m].append("unquoted-end " + str(u))
                ot_passages[m].append(0) # technical
                ot_passages[m].append(0) # technical
                u += 1
            p += 1

    sort_positions()

    comment(nt_text, format)
    comment(ot_text, format)
    comment(f"{nt_positions} {nt_positions_info}", format)
    comment(f"{ot_positions} {ot_positions_info}", format)
    comment(f"{clasp_ot_book} {clasp_jaccard}", format)

    if overlapping_ot:
        comment("Warning: OT overlapping", format)
        return

    found = False
    p = 0
    while p < len(nt_positions) and not found:
        if nt_positions_info[p].startswith("clasp"):
            found = True
            nt_begin_pos = nt_positions[p]
            nt_begin = nt_passages[p].split(" ")[0:3]
            nt_begin = f"{nt_begin[1]} {nt_begin[2]}"
        p += 1
    if not found:
        comment("Warning: missing first clasp (NT)", format)
        return

    for m in ot_positions.keys():
        found = False
        p = 0
        while p < len(ot_positions[m]) and not found:
            if ot_positions_info[m][p].startswith("clasp"):
                found = True
                ot_begin_pos[m] = ot_positions[m][p]
                ot_begin[m] = ot_passages[m][p].split(" ")[0:3]
                ot_begin[m] = f"{ot_begin[m][1]} {ot_begin[m][2]}"
            p += 1
        if not found:
            comment(f"Warning: missing first clasp (OT/{m})", format)
            return

    # Print graphs
    if format == "latex" or format == "svg":
        nt_passage_formatted = nt_begin.replace("_", " ")
        print ("\\noindent\\begin{tikzpicture}[node distance=8mm]")
        print(f"\\node[nt_passage] (nt_passage) at (0,0) {{{nt_passage_formatted}}};")

    start_with_intro = nt_text[0][0] == "i"
    p = 0
    nt_out = ""
    latex_lastnode_nt = "nt_passage"
    nt_latex = ""
    next_ot_shorter = 0
    connect_nodes = "\\draw "
    overlapping_text = ""
    while p < len(nt_positions):
        words = nt_positions_info[p].split(" ")
        cl = words[0].split("-")
        chunk = int(words[1])
        if words[0] == "intro-start":
            nt_out += "[intro"
            nt_latex += "\\node[intro] (intro " + str(chunk) + ") ["
            node_content = ""
            nt_latex += ",right=0.2 cm of " + latex_lastnode_nt
            if latex_lastnode_nt == "nt_passage":
                nt_latex += ",node distance=3cm"
            else:
                connect_nodes += " --"
            if not start_with_intro or chunk > 1:
                q = p
                found = False
                while not found:
                    q += 1
                    found = nt_positions_info[q] == "intro-end " + str(chunk)
                intro_length = nt_positions[q] - nt_positions[p] + 1
                nt_out += f" ({intro_length})"
                node_content = str(intro_length)
            if source_given:
                nt_latex += ",fill=blue!40"
            nt_out += "]"
            nt_latex += "] {" + node_content+ "};\n"
            latex_lastnode_nt = "intro " + str(chunk)
            connect_nodes += " (" + latex_lastnode_nt + ")"
        else:
            if cl[1] == "start":
                nt_out += "[" + cl[0]
                q = p
                found = False
                while not found:
                    q += 1
                    found = nt_positions_info[q] == cl[0] + "-end " + str(chunk)
                class_length = nt_positions[q] - nt_positions[p] + 1
                if cl[0] == "clasp":
                    nt_out += f" {chunk}"
                nt_out += f" ({class_length})"
                nt_out += "]"

                nt_latex += "\\node[" + cl[0]+ "] (" + cl[0] + " " + str(chunk) + ")"
                nt_latex += "[right="
                if cl[0] == "clasp" and (chunk - 1) in overlappings:
                    nt_latex += "0 cm"
                else:
                    nt_latex += "0.2 cm"
                nt_latex += " of " + latex_lastnode_nt
                if latex_lastnode_nt == "nt_passage":
                    nt_latex += ",node distance=3cm"
                else:
                    connect_nodes += " --"
                textcolor = "black"
                if cl[0] == "clasp":
                    jnum = (1 - clasp_jaccard[chunk - 1]) * 100
                    nt_latex += ",fill=ForestGreen!" + str(jnum)
                    textcolor = "white"
                nt_latex += "]"
                nt_latex += " {\\textcolor{" + textcolor + "}"
                latex_lastnode_nt = cl[0] + " " + str(chunk)
                connect_nodes += " (" + latex_lastnode_nt + ")"
                # Handle overlappings:
                nt_latex_overlap = ""
                ol_found = False
                if cl[0] == "clasp" and chunk in overlappings:
                    ol_found = True
                    ol_pos = overlappings.index(chunk)

                    length1 = len(clasp_nt_content[chunk - 1]) # length of this chunk
                    ol_length = overlappings_length[ol_pos]
                    overlapping_text = clasp_nt_content[chunk - 1][length1-ol_length:] # store the overlapping text
                    clasp_nt_content[chunk - 1] = clasp_nt_content[chunk - 1][:length1-ol_length] # trim its end
                    clasp_nt_content[chunk] = clasp_nt_content[chunk][ol_length:] # trim the 3rd part

                    connect_nodes += "-- (overlap " + str(chunk) + ")"
                    nt_latex_overlap = "\\node[overlap] (overlap " + str(chunk) + ")[right=0 cm of " + latex_lastnode_nt + "]"
                    nt_latex_overlap += "{\\textcolor{yellow}"
                    if texts > 0:
                        if texts == 2:
                            overlapping_text = latin_to_greek(overlapping_text)
                        nt_latex_overlap += "{\\tiny " + overlapping_text + "}};\n"
                    else:
                        nt_latex_overlap += "{ " + str(ol_length) + "}};\n"
                    latex_lastnode_nt = "overlap " + str(chunk)
                    next_ot_shorter = ol_length # indicate shorter clasps for this and the next node
                class_length -= next_ot_shorter
                if texts > 0 and cl[0] == "clasp":
                    displayed_text = clasp_nt_content[chunk - 1]
                    if texts == 2:
                        displayed_text = latin_to_greek(displayed_text)
                    nt_latex += "{\\tiny " + displayed_text + "}};\n" # display clasp content
                else:
                    nt_latex += "{" + str(class_length) + "}};\n" # display clasp length
                nt_latex += nt_latex_overlap
                if not ol_found:
                    next_ot_shorter = 0 # reset indicator

        p += 1
    connect_nodes += ";"
    comment(f"NT: {nt_out}", format)

    if format == "latex" or format == "svg":
        print (nt_latex)
        print (connect_nodes)

    ot_out = dict()

    y = 0
    for m in ot_positions.keys():
        y += 1
        ot_latex = ""
        connect_nodes = "\\draw "
        p = 0
        ot_out[m] = ""
        latex_lastnode_ot = "ot_passage " + m
        if format == "latex" or format == "svg":
            ot_passage_formatted = ot_begin[m].replace("_", " ")
            print(f"\\node[ot_passage] (ot_passage {m}) at (0,{-y}) {{{ot_passage_formatted}}};")

        while p < len(ot_positions[m]):
            words = ot_positions_info[m][p].split(" ")
            cl = words[0].split("-")
            chunk = int(words[1])
            if cl[1] == "start":
                ot_out[m] += "[" + cl[0]
                q = p
                found = False
                while not found:
                    q += 1
                    found = ot_positions_info[m][q] == cl[0] + "-end " + str(chunk)
                class_length = ot_positions[m][q] - ot_positions[m][p] + 1
                if cl[0] == "clasp":
                    ot_out[m] += f" {chunk}"
                ot_out[m] += f" ({class_length})"
                ot_out[m] += "]"

                ot_latex += "\\node[" + cl[0]+ "] (" + m + " " + cl[0] + " " + str(chunk) + ") ["
                if latex_lastnode_ot.startswith("ot_passage"):
                    ot_latex += "below of=clasp " + str(chunk) + ",node distance=" + str(y) + "cm"
                else:
                    ot_latex += "right=0.2 cm of " + latex_lastnode_ot
                    connect_nodes += " --"
                textcolor = "black"
                if cl[0] == "clasp":
                    jnum = (1 - clasp_jaccard[chunk - 1]) * 100
                    textcolor = "white"
                    ot_latex += ",fill=ForestGreen!" + str(jnum)
                ot_latex += "]"
                ot_latex += " {\\textcolor{" + textcolor + "}"
                if texts > 0:
                    if cl[0] == "clasp":
                        displayed_text = clasp_ot_content[chunk - 1]
                        if texts == 2:
                            displayed_text = latin_to_greek(displayed_text)
                        ot_latex += "{\\tiny " + displayed_text + "}};\n" # display clasp content
                    else:
                        ot_latex += "{" + str(class_length) + "}};\n" # display clasp length
                else:
                    ot_latex += "{" + str(class_length) + "}};\n" # display clasp length
                latex_lastnode_ot = m + " " + cl[0] + " " + str(chunk)
                connect_nodes += " (" + latex_lastnode_ot + ")"

            p += 1
        connect_nodes += ";"
        comment(f"OT/{m}: {ot_out[m]}", format)
        if format == "latex" or format == "svg":
            print (ot_latex)
            print (connect_nodes)

    if format == "latex" or format == "svg":
        print (jaccards)
        print ("\\end{tikzpicture}")
    if format == "latex":
        print ("\\par\\noindent\\rule{\\textwidth}{0.4pt}\\vspace{10pt}")
    if format == "svg":
        print ("\\end{document}")

def nt_passage_info_all(conn, format, order="", texts=0):
    """
    Show all relevant information on all NT quotations
    :param conn: the Connection object
    """

    global bibref
    spawn_bibref()

    cur = conn.cursor()

    if format == "latex":
        print ("\\documentclass{article}")
        print ("\\usepackage[a4paper,margin=2cm]{geometry}")
        print ("\\usepackage[dvipsnames]{xcolor}")
        print ("\\usepackage{tikz}")
        print_passage_header()

    if order == "ot":
        cur.execute("SELECT DISTINCT qi.nt_quotation_id" +
            " FROM nt_quotation_introductions qi, books bo, books bn, clasps c" +
            " WHERE bo.name = c.ot_book AND bn.name = c.nt_book "
            " AND qi.nt_quotation_id = c.nt_quotation_id"
            " ORDER BY bo.number, c.ot_startpos, bn.number")
    else:
        cur.execute("SELECT DISTINCT qi.nt_quotation_id" +
            " FROM nt_quotation_introductions qi, books b" +
            " WHERE b.name = qi.nt_book"
            " ORDER BY b.number, qi.nt_startpos")
    rows = cur.fetchall()
    i = 1
    for row in rows:
        nt_quotation_id = row[0]
        comment("", format)
        comment(f"{i}. nt_quotation_id={nt_quotation_id}", format)
        nt_passage_info(conn, nt_quotation_id, format, texts)
        i += 1
    if format == "latex":
        print ("\\end{document}")

def main():
    database = r"quotations.sqlite3"
    conn = create_connection(database)
    if len(sys.argv) > 1:
        result_type = sys.argv[1]
    else:
        result_type = "traditional"
    if result_type == "traditional":
        data = 'authors'
    if result_type == "getrefs":
        data = "pieces"
    if result_type == "nt_ppm":
        data = "Romans"
        data2 = 34176
        data3 = 225
        data4 = 160
        data5 = "getrefs"
    if result_type == "nt_latex":
        data = "Romans"
    if result_type == "nt_latex":
        data = "Isaiah"
    if result_type == "nt_jaccard":
        data = "Romans"
    if result_type == "ot_jaccard":
        data = "Psalms"
    if result_type == "nt_passage_info":
        data = "all"
        data2 = "text"
    if result_type == "ot_passage_info":
        data = "all"
    if result_type == "nt_passage_info_content":
        data = "all"
        data2 = "text"
    if result_type == "ot_passage_info_content":
        data = "all"

    if len(sys.argv) > 2:
        data = sys.argv[2]
    if len(sys.argv) > 3:
        data2 = sys.argv[3]
    if len(sys.argv) > 4:
        data3 = sys.argv[4]
    if len(sys.argv) > 5:
        data4 = sys.argv[5]
    if len(sys.argv) > 6:
        data5 = sys.argv[6]
    with conn:
        if result_type == "nt_freq_csv":
            nt_frequencies_csv(conn)
        elif result_type == "ot_freq_csv":
            ot_frequencies_csv(conn)
        elif result_type == "nt_ppm":
            nt_report_ppm(conn, data, int(data2), int(data3), int(data4), data5)
        elif result_type == "nt_latex":
            nt_report_latex(conn, data)
        elif result_type == "ot_latex":
            ot_report_latex(conn, data)
        elif result_type == "nt_jaccard":
            nt_jaccard_csv(conn, data)
        elif result_type == "ot_jaccard":
            ot_jaccard_csv(conn, data)
        elif result_type == "nt_passage_info":
            if data == "all":
                nt_passage_info_all(conn, "latex")
            else:
                nt_passage_info(conn, int(data), data2)
        elif result_type == "ot_passage_info":
            nt_passage_info_all(conn, "latex", "ot")
        elif result_type == "nt_passage_info_content":
            if data == "all":
                nt_passage_info_all(conn, "latex", "nt", int(data2))
            else:
                nt_passage_info(conn, int(data), data2, int(data3))
        elif result_type == "ot_passage_info_content":
            nt_passage_info_all(conn, "latex", "ot", int(data2))
        elif result_type == "ot_nt_graphviz":
            ot_nt_graphviz(conn, data)
        else:
            psalms_report_latex(conn, result_type, data)


graphviz_positions = {
    'Genesis': "-4,3!",
    'Exodus': "-4,1!",
    'Leviticus': "-4,-1!",
    'Numbers': "-4,-3!",
    'Deuteronomy': "-4,-5!",
    'Joshua': "1,4!",
    'Judges': "3,4!",
    'Ruth': "5,4!",
    'I_Samuel': "7,4!",
    'II_Samuel': "9,4!",
    'I_Kings': "11,4!",
    'II_Kings': "13,4!",
    'I_Chronicles': "15,4!",
    'II_Chronicles': "17,4!",
    'Ezra': "19,4!",
    'Nehemiah': "21,4!",
    'Esther': "23,4!",
    'Job': "28,3!",
    'Psalms': "28,1!",
    'Proverbs': "28,-1!",
    'Ecclesiastes': "28,-3!",
    'Song_of_Solomon': "28,-5!",
    'Isaiah': "-4,-10!",
    'Jeremiah': "-2,-10!",
    'Lamentations': "0,-10!",
    'Ezekiel': "2,-10!",
    'Daniel': "4,-10!",
    'Hosea': "6,-10!",
    'Joel': "8,-10!",
    'Amos': "10,-10!",
    'Obadiah': "12,-10!",
    'Jonah': "14,-10!",
    'Micah': "16,-10!",
    'Nahum': "18,-10!",
    'Habakkuk': "20,-10!",
    'Zephaniah': "22,-10!",
    'Haggai': "24,-10!",
    'Zechariah': "26,-10!",
    'Malachi': "28,-10!",
    'Matthew': "7,0!",
    'Mark': "9,0!",
    'Luke': "11,0!",
    'John': "13,0!",
    'Acts': "17,0!",
    'Romans': "0,-2!",
    'I_Corinthians': "2,-2!",
    'II_Corinthians': "4,-2!",
    'Galatians': "6,-2!",
    'Ephesians': "8,-2!",
    'Philippians': "10,-2!",
    'Colossians': "12,-2!",
    'I_Thessalonians': "14,-2!",
    'II_Thessalonians': "16,-2!",
    'I_Timothy': "18,-2!",
    'II_Timothy': "20,-2!",
    'Titus': "22,-2!",
    'Philemon': "24,-2!",
    'Hebrews': "5,-4!",
    'James': "7,-4!",
    'I_Peter': "9,-4!",
    'II_Peter': "11,-4!",
    'I_John': "13,-4!",
    'II_John': "15,-4!",
    'III_John': "17,-4!",
    'Jude': "19,-4!",
    'Revelation_of_John': "12,-6!"
    }

books_translated_hu = {
    'Genesis': "1Móz",
    'Exodus': "2Móz",
    'Leviticus': "3Móz",
    'Numbers': "4Móz",
    'Deuteronomy': "5Móz",
    'Joshua': "Józs",
    'Judges': "Bír",
    'Ruth': "Ruth",
    'I_Samuel': "1Sám",
    'II_Samuel': "2Sám",
    'I_Kings': "1Kir",
    'II_Kings': "2Kir",
    'I_Chronicles': "1Krón",
    'II_Chronicles': "2Krón",
    'Ezra': "Ezsd",
    'Nehemiah': "Neh",
    'Esther': "Esz",
    'Job': "Jób",
    'Psalms': "Zsolt",
    'Proverbs': "Péld",
    'Ecclesiastes': "Préd",
    'Song_of_Solomon': "Énekek",
    'Isaiah': "Ézs",
    'Jeremiah': "Jer",
    'Lamentations': "JSir",
    'Ezekiel': "Ez",
    'Daniel': "Dán",
    'Hosea': "Hós",
    'Joel': "Jóel",
    'Amos': "Ám",
    'Obadiah': "Abd",
    'Jonah': "Jón",
    'Micah': "Mik",
    'Nahum': "Náh",
    'Habakkuk': "Hab",
    'Zephaniah': "Zof",
    'Haggai': "Hagg",
    'Zechariah': "Zak",
    'Malachi': "Mal",
    'Matthew': "Mt",
    'Mark': "Mk",
    'Luke': "Lk",
    'John': "Jn",
    'Acts': "ApCsel",
    'Romans': "Róm",
    'I_Corinthians': "1Kor",
    'II_Corinthians': "2Kor",
    'Galatians': "Gal",
    'Ephesians': "Ef",
    'Philippians': "Fil",
    'Colossians': "Kol",
    'I_Thessalonians': "1Thessz",
    'II_Thessalonians': "2Thessz",
    'I_Timothy': "1Tim",
    'II_Timothy': "2Tim",
    'Titus': "Tit",
    'Philemon': "Filem",
    'Hebrews': "Zsid",
    'James': "Jak",
    'I_Peter': "1Pt",
    'II_Peter': "2Pt",
    'I_John': "1Ján",
    'II_John': "2Ján",
    'III_John': "3Ján",
    'Jude': "Júd",
    'Revelation_of_John': "Jel"
    }

books_translated_en = {
    'Genesis': "Gen",
    'Exodus': "Ex",
    'Leviticus': "Lev",
    'Numbers': "Num",
    'Deuteronomy': "Deut",
    'Joshua': "Josh",
    'Judges': "Judg",
    'Ruth': "Ruth",
    'I_Samuel': "1 Sam",
    'II_Samuel': "2 Sam",
    'I_Kings': "1 Kings",
    'II_Kings': "2 Kings",
    'I_Chronicles': "1 Chron",
    'II_Chronicles': "2 Chron",
    'Ezra': "Ezra",
    'Nehemiah': "Neh",
    'Esther': "Est",
    'Job': "Job",
    'Psalms': "Ps",
    'Proverbs': "Prov",
    'Ecclesiastes': "Eccles",
    'Song_of_Solomon': "Song",
    'Isaiah': "Isa",
    'Jeremiah': "Jer",
    'Lamentations': "Lam",
    'Ezekiel': "Ezek",
    'Daniel': "Dan",
    'Hosea': "Hos",
    'Joel': "Joel",
    'Amos': "Amos",
    'Obadiah': "Obad",
    'Jonah': "Jonah",
    'Micah': "Mic",
    'Nahum': "Nah",
    'Habakkuk': "Hab",
    'Zephaniah': "Zeph",
    'Haggai': "Hag",
    'Zechariah': "Zech",
    'Malachi': "Mal",
    'Matthew': "Matt",
    'Mark': "Mark",
    'Luke': "Luke",
    'John': "John",
    'Acts': "Acts",
    'Romans': "Rom",
    'I_Corinthians': "1 Cor",
    'II_Corinthians': "2 Cor",
    'Galatians': "Gal",
    'Ephesians': "Eph",
    'Philippians': "Phil",
    'Colossians': "Col",
    'I_Thessalonians': "1 Thess",
    'II_Thessalonians': "2 Thess",
    'I_Timothy': "1 Tim",
    'II_Timothy': "2 Tim",
    'Titus': "Titus",
    'Philemon': "Philem",
    'Hebrews': "Heb",
    'James': "James",
    'I_Peter': "1 Pet",
    'II_Peter': "2 Pet",
    'I_John': "1 John",
    'II_John': "2 John",
    'III_John': "3 John",
    'Jude': "Jude",
    'Revelation_of_John': "Rev"
    }

if __name__ == '__main__':
    main()
