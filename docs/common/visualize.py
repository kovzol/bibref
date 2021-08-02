#!/usr/bin/python3
# Several pieces of this code were taken from https://www.sqlitetutorial.net/sqlite-python/sqlite-python-select/

import sqlite3, sys
from sqlite3 import Error
import pexpect

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
    print ("\\begin{document}")
    print ("\\thispagestyle{empty}")
    print ("\\centering")
    print ("\\begin{table}")
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

def spawn_bibref():
    global bibref
    if bibref is not None:
        return
    print("Waiting for bibref's full startup...")
    bibref = pexpect.spawn("../../bibref -a") # FIXME: path is hardcoded now
    bibref.expect("Done loading books of SBLGNT.")
    bibref.timeout = 5

def nt_jaccard_csv(conn, nt_book):
    """
    Collect all quotations from an NT book that are obtained manually and
    determine the Jaccard distances to the OT passages in a CSV file
    :param conn: the Connection object
    :nt_book: NT book name
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
    :ot_book: OT book name
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
    global nt_positions, nt_positions_info, ot_positions, ot_positions_info
    # Order the NT positions (bubble sort)
    s = 0
    for k in range(len(nt_positions)):
        for l in range(k):
            # print(k,l,nt_positions[l],nt_positions[k])
            if nt_positions[l] > nt_positions[k]:
                # swap them
                d = nt_positions[l]
                di = nt_positions_info[l]
                nt_positions[l] = nt_positions[k]
                nt_positions_info[l] = nt_positions_info[k]
                nt_positions[k] = d
                nt_positions_info[k] = di
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
                    ot_positions[m][l] = ot_positions[m][k]
                    ot_positions_info[m][l] = ot_positions_info[m][k]
                    ot_positions[m][k] = d
                    ot_positions_info[m][k] = di
                    s += 1

    # print('#', s, 'swaps')


def nt_passage_info(conn, nt_quotation_id):
    """
    Show all relevant information on a given NT quotation
    :param conn: the Connection object
    :nt_quotation_id: NT quotation identifier
    """

    global bibref
    spawn_bibref()

    cur = conn.cursor()

    cur.execute("SELECT qi.nt_book, qi.nt_passage, qi.nt_startpos, qi.nt_endpos" +
        " FROM nt_quotation_introductions qi" +
        " WHERE qi.nt_quotation_id = " + str(nt_quotation_id) +
        " ORDER BY qi.nt_startpos")
    rows = cur.fetchall()
    print ("Introduction(s):")

    global nt_positions, nt_positions_info
    nt_positions = []
    nt_positions_info = []
    i = 1
    for row in rows:
        nt_book, nt_passage, nt_startpos, nt_endpos = row
        nt_positions.append(nt_startpos)
        nt_positions_info.append("intro-start " + str(i))
        nt_positions.append(nt_endpos)
        nt_positions_info.append("intro-end " + str(i))
        print(f"{nt_passage} (book position: {nt_startpos}-{nt_endpos})")
        i += 1

    cur.execute("SELECT c.ot_book, c.ot_passage, c.nt_passage, c.ot_startpos, c.ot_length, c.nt_startpos, c.nt_length" +
        " FROM clasps c" +
        " WHERE c.nt_quotation_id = " + str(nt_quotation_id) +
        " ORDER BY c.nt_startpos")
    rows2 = cur.fetchall()
    print ("Clasp(s):")

    global ot_positions, ot_positions_info
    ot_positions = dict()
    ot_positions_info = dict()
    j = 1
    clasp_ot_book = []
    clasp_jaccard = []
    for row2 in rows2:
        ot_book, ot_passage, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length = row2
        ot_endpos = ot_startpos + ot_length - 1
        nt_endpos = nt_startpos + nt_length - 1
        if not ot_book in ot_positions:
           ot_positions[ot_book] = []
           ot_positions_info[ot_book] = []
        ot_positions[ot_book].append(ot_startpos)
        ot_positions_info[ot_book].append("clasp-start " + str(j))
        ot_positions[ot_book].append(ot_endpos)
        ot_positions_info[ot_book].append("clasp-end " + str(j))
        nt_positions.append(nt_startpos)
        nt_positions_info.append("clasp-start " + str(j))
        nt_positions.append(nt_endpos)
        nt_positions_info.append("clasp-end " + str(j))

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
        print(f"{ot_passage} -> {nt_passage} (book positions: {ot_startpos}-{ot_endpos} -> {nt_startpos}-{nt_endpos}, jaccard={jaccard:.6f})")
        clasp_ot_book.append(ot_book)
        clasp_jaccard.append(jaccard)
        j += 1

    sort_positions()

    # Create array to describe each letter of the texts
    nt_pos_start = nt_positions[0]
    nt_pos_end = nt_positions[-1]
    print('# NT: ', nt_pos_start, '-', nt_pos_end)
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
    for row2 in rows2:
        ot_book, ot_passage, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length = row2
        ot_endpos = ot_startpos + ot_length - 1
        nt_endpos = nt_startpos + nt_length - 1
        for k in range(nt_endpos - nt_startpos + 1):
            nt_text[nt_startpos - nt_pos_start + k] += "c" + str(j) + ","
        for k in range(ot_endpos - ot_startpos + 1):
            ot_text[ot_book][ot_startpos - ot_pos_start[ot_book] + k] += "c" + str(j) + ","
        j += 1
    # start_with_intro = nt_text[0][0] == "i"
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
            u += 1
        p += 1
    for m in ot_positions.keys():
        p = 0
        while p < ot_len[m]:
            if ot_text[m][p] == "":
                ot_positions[m].append(ot_pos_start[m] + p)
                ot_positions_info[m].append("unidentified-start " + str(u))
                while ot_text[m][p] == "":
                    ot_text[m][p] = "u" + str(u)
                    p += 1
                ot_positions[m].append(ot_pos_start[m] + p - 1)
                ot_positions_info[m].append("unidentified-end " + str(u))
                u += 1
            p += 1

    sort_positions()

    print('#', nt_text)
    print('#', ot_text)
    print('#', nt_positions, nt_positions_info)
    print('#', ot_positions, ot_positions_info)
    print('#', clasp_ot_book, clasp_jaccard)

    # Print graphs

def nt_passage_info_all(conn):
    """
    Show all relevant information on all NT quotations
    :param conn: the Connection object
    """

    global bibref
    spawn_bibref()

    cur = conn.cursor()

    cur.execute("SELECT DISTINCT qi.nt_quotation_id" +
        " FROM nt_quotation_introductions qi, books b" +
        " WHERE b.name = qi.nt_book"
        " ORDER BY b.number, qi.nt_startpos")
    rows = cur.fetchall()
    i = 1
    for row in rows:
        nt_quotation_id = row[0]
        print()
        print(f"{i}. nt_quotation_id={nt_quotation_id}")
        nt_passage_info(conn, nt_quotation_id)
        i += 1

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
                nt_passage_info_all(conn)
            else:
                nt_passage_info(conn, int(data))
        else:
            psalms_report_latex(conn, result_type, data)

if __name__ == '__main__':
    main()
