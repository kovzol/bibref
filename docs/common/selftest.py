#!/usr/bin/python3

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

def book_entries(conn):
    """
    Check if all book entries correspond to a correct passage.
    :param conn: the Connection object
    """
    cur = conn.cursor()

    cur.execute("SELECT *, INSTR(q.ot_passage, q.ot_book) position" +
        " FROM quotations q" +
        " WHERE position = 0")
    rows = cur.fetchall()
    if len(rows) > 0:
        print("Book name is not present in passage (OT)",rows)
        sys.exit(1)

    cur.execute("SELECT *, INSTR(q.nt_passage, q.nt_book) position" +
        " FROM quotations q" +
        " WHERE position = 0")
    rows = cur.fetchall()
    if len(rows) > 0:
        print("Book name is not present in passage (NT)",rows)
        sys.exit(1)

def main():
    database = r"quotations.sqlite3"
    conn = create_connection(database)
    book_entries(conn)
    print("All tests passed")

if __name__ == '__main__':
    main()
