# Several pieces of this code was taken from https://www.sqlitetutorial.net/sqlite-python/sqlite-python-select/

import sqlite3
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

def psalms_report_latex(conn):
    """
    Query all entries in the Psalms database rows and show them as a LaTeX table
    :param conn: the Connection object
    :return:
    """
    cur = conn.cursor()

    print ("\\documentclass{article}")
    print ("\\usepackage{mathtools}")
    print ("\\usepackage[dvipsnames]{xcolor}")
    print ("\\newcommand\\Luke{{\color{Lavender}\\bullet}\mathllap{\color{Lavender}\circ}}")
    print ("\\newcommand\\Paul{{\color{YellowGreen}\\bullet}\mathllap{\color{YellowGreen}\circ}}")
    print ("\\newcommand\\Unknown{{\color{Orchid}\\bullet}\mathllap{\color{Orchid}\circ}}")
    print ("\\newcommand\\Matthew{{\color{Red}\\bullet}\mathllap{\color{Red}\circ}}")
    print ("\\newcommand\\Mark{{\color{Cyan}\\bullet}\mathllap{\color{Cyan}\circ}}")
    print ("\\newcommand\\John{{\color{GreenYellow}\\bullet}\mathllap{\color{GreenYellow}\circ}}")
    print ("\\newcommand\\Peter{{\color{NavyBlue}\\bullet}\mathllap{\color{NavyBlue}\circ}}")
    print ("\\begin{document}")
    print ("\\centering")
    print ("\\begin{table}")
    print ("\\begin{tabular}{rcccccccccc}")
    for i in range(0,10):
        print ("&{\\bf", i+1, "}", end = '', sep = '')
    print ("\\\\")
    for psalm in range(1,151):
        if psalm % 10 == 1:
            print ("{\\bf ", round(psalm/10), "}&", end = '', sep = '')
        cur.execute("SELECT q.ot_id, q.nt_id, q.nt_book, a.name" +
            " FROM quotations_classifications qc, quotations q, authors a, books b " +
            " WHERE qc.classification = 'quotation'" +
            " AND qc.quotation_ot_id = q.ot_id" +
            " AND qc.quotation_nt_id = q.nt_id" +
            " AND q.psalm = " + str(psalm) +
            " AND q.found_method = 'getrefs'" +
            " AND a.name = b.author" +
            " AND b.name = q.nt_book" +
            " GROUP BY q.ot_id, q.nt_id" +
            " ORDER BY b.number")
        rows = cur.fetchall()
        if len(rows) > 0:
            print
            print ("\n", "% Psalm ", psalm, sep = '')
            old_ot_id = 0
            for row in rows:
                print("%", row)
                author = row[3]
                ot_id = row[0]
                if old_ot_id > 0 and ot_id != old_ot_id:
                    print(",", sep = '', end = '')
                # if author == "Luke":
                #     print ("$\\Luke$", end = '')
                print ("$\\", author, "$", sep = '', end = '')
                old_ot_id = ot_id
        if psalm % 10 == 0:
            print ("\\\\")
        else:
            print ("&", end = '', sep = '')
    print ("\\end{tabular}")
    print ("\\end{table}")
    print ("\\end{document}")


def main():
    database = r"psalms.sqlite3"
    conn = create_connection(database)
    with conn:
        psalms_report_latex(conn)

if __name__ == '__main__':
    main()
