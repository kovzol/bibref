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

    for psalm in range(1,151):
        cur.execute("SELECT q.ot_id, q.nt_id, q.nt_book, a.name" +
            " FROM quotations_classifications qc, quotations q, authors a, books b " +
            " WHERE qc.classification = 'quotation'" +
            " AND qc.quotation_ot_id = q.ot_id" +
            " AND qc.quotation_nt_id = q.nt_id" +
            " AND q.psalm = " + str(psalm) +
            " AND q.found_method = 'getrefs'" +
            " AND a.name = b.author" +
            " AND b.name = q.nt_book" +
            " GROUP BY q.ot_id, q.nt_id")
        rows = cur.fetchall()
        if len(rows) > 0:
            print ("Psalm", psalm)
            for row in rows:
                print(row)

def main():
    database = r"psalms.sqlite3"
    conn = create_connection(database)
    with conn:
        psalms_report_latex(conn)

if __name__ == '__main__':
    main()
