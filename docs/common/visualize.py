#!/usr/bin/python3
# Several pieces of this code was taken from https://www.sqlitetutorial.net/sqlite-python/sqlite-python-select/

import sqlite3, sys
from sqlite3 import Error

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
        cur.execute("SELECT q.ot_id, q.nt_id, q.nt_book, a.name" +
            " FROM quotations_classifications qc, quotations q, authors a, books b " +
            " WHERE qc.classification = 'quotation'" +
            " AND qc.quotation_ot_id = q.ot_id" +
            " AND qc.quotation_nt_id = q.nt_id" +
            " AND q.psalm = " + str(psalm) +
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
            " FROM quotations q, quotations_classifications qc " +
            " WHERE qc.classification = 'quotation'" +
            " AND qc.quotation_ot_id = q.ot_id" +
            " AND qc.quotation_nt_id = q.nt_id" +
            " AND q.found_method = 'getrefs'" +
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
    print ("\\begin{document}")
    print ("\\thispagestyle{empty}")
    print ("\\centering")
    print ("\\begin{table}")
    print ("\\begin{tabular}{rrlc}")
    print (f"&&&{{\\bf getrefs}}\\\\")
    print (f"{{\\bf No.}}&{{\\bf {book} passage}}&{{\\bf OT passage}}&{{\\bf chunks}}\\\\")
    print ("\\hline")

    cur = conn.cursor()
    cur.execute("SELECT q.nt_startpos, q.nt_length, q.ot_book, q.ot_passage, q.nt_passage, q.ot_id, q.nt_id" +
        " FROM quotations q, quotations_classifications qc " +
        " WHERE qc.classification = 'quotation'" +
        " AND qc.quotation_ot_id = q.ot_id" +
        " AND qc.quotation_nt_id = q.nt_id" +
        " AND q.found_method = 'manual'" +
        " AND q.nt_book = '" + book + "'" +
        " ORDER BY q.nt_startpos")
    rows = cur.fetchall()
    q = 1
    f = open("manual_" + book + "_length.csv", "w")

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
        " FROM quotations q, quotations_classifications qc, books b " +
        " WHERE qc.classification = 'quotation'" +
        " AND qc.quotation_ot_id = q.ot_id" +
        " AND qc.quotation_nt_id = q.nt_id" +
        " AND q.nt_book = b.name" +
        " GROUP BY b.number, q.ot_id, q.nt_id" +
        " ORDER BY b.number)" +
        " GROUP BY name ORDER BY number")
    rows = cur.fetchall()

    for row in rows:
        book = row[0]
        frequency = row[1]
        f.write(book + "," + str(frequency) + "\n")
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
        " FROM quotations q, quotations_classifications qc, books b " +
        " WHERE qc.classification = 'quotation'" +
        " AND qc.quotation_ot_id = q.ot_id" +
        " AND q.ot_book = b.name" +
        " GROUP BY b.number, q.ot_id" +
        " ORDER BY b.number)" +
        " GROUP BY name ORDER BY number")
    rows = cur.fetchall()

    for row in rows:
        book = row[0]
        frequency = row[1]
        f.write(book + "," + str(frequency) + "\n")
    f.close()

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
            nt_report_ppm(conn, data, data2, data3, data4, data5)
        elif result_type == "nt_latex":
            nt_report_latex(conn, data)
        else:
            psalms_report_latex(conn, result_type, data)

if __name__ == '__main__':
    main()
