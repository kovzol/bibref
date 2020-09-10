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
    Query all entries in the Psalms database rows and show them as a LaTeX table
    :param conn: the Connection object
    :return:
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

def main():
    database = r"psalms.sqlite3"
    conn = create_connection(database)
    if len(sys.argv) > 1:
        result_type = sys.argv[1]
    else:
        result_type = "traditional"
    data = 'authors'
    if len(sys.argv) > 2:
        data = sys.argv[2]
    with conn:
        if result_type == "getrefs":
            data = "pieces"
        psalms_report_latex(conn, result_type, data)

if __name__ == '__main__':
    main()
