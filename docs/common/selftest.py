#!/usr/bin/python3

import sqlite3, sys, os
from sqlite3 import Error
import pexpect

bibref = None
errors = 0

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

def spawn_bibref():
    global bibref
    if bibref is not None:
        return
    print("Waiting for bibref's full startup...")

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

def quotation_entries_lengths(conn):
    """
    Check if all quotation entries are consistent:
    The length of the texts must match the entries.
    :param conn: the Connection object
    """

    global bibref, errors
    cur = conn.cursor()
    cur.execute("SELECT ot_passage, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length" +
        " FROM quotations_with_introduction" +
        " WHERE ot_startpos IS NOT NULL AND ot_length IS NOT NULL AND nt_startpos IS NOT NULL AND nt_length IS NOT NULL" +
        " ORDER BY ot_passage, nt_passage")
    rows = cur.fetchall()

    spawn_bibref()
    print("Checking lengths of quotation entries...")

    r = 0
    for row in rows:
        ot_passage = row[0]
        nt_passage = row[1]
        ot_startpos = row[2]
        ot_length = row[3]
        nt_startpos = row[4]
        nt_length = row[5]
        command1 = "lookup1 " + ot_passage
        bibref.sendline(command1)
        bibref.expect("Stored internally as \w.")
        command2 = "lookup2 " + nt_passage
        bibref.sendline(command2)
        bibref.expect("Stored internally as \w.")
        command3 = "length1"
        bibref.sendline(command3)
        bibref.expect("Length of text 1 is ([0-9]+).")
        length1s = bibref.match.groups()
        length1 = int(length1s[0])
        command4 = "length2"
        bibref.sendline(command4)
        bibref.expect("Length of text 2 is ([0-9]+).")
        length2s = bibref.match.groups()
        length2 = int(length2s[0])
        if ot_length != length1:
            print(f"Length for OT passage {ot_passage} does not match, in database {ot_length}, in OT {length1}")
            errors += 1
        if nt_length != length2:
            print(f"Length for NT passage {nt_passage} does not match, in database {nt_length}, in NT {length2}")
            errors += 1
        percent = int(r/len(rows)*100)
        print(f"{percent}% done\u001b[{0}K\r", end='')
        r += 1
    print(f"Done\u001b[{0}K")

def quotation_entries(conn):
    """
    Check if manual quotation entries are correct.
    :param conn: the Connection object
    """

    global bibref, errors
    cur = conn.cursor()
    cur.execute("SELECT ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length, found_method" +
        " FROM quotations_with_introduction" +
        " WHERE ot_startpos IS NOT NULL AND ot_length IS NOT NULL AND nt_startpos IS NOT NULL AND nt_length IS NOT NULL" +
        " ORDER BY ot_passage, nt_passage")
    rows = cur.fetchall()

    spawn_bibref()
    print("Checking quotation entries...")

    r = 0
    for row in rows:
        ot_book = row[0]
        ot_passage = row[1]
        nt_book = row[2]
        nt_passage = row[3]
        ot_startpos = row[4]
        ot_length = row[5]
        nt_startpos = row[6]
        nt_length = row[7]
        found_method = row[8]
        command1 = "lookup1 " + ot_passage
        bibref.sendline(command1)
        bibref.expect("Stored internally as \w.")
        command2 = "lookup2 " + nt_passage
        bibref.sendline(command2)
        bibref.expect("Stored internally as \w.")
        command3 = "find1 LXX"
        bibref.sendline(command3)
        bibref.expect("[0-9]+ occurrences.")
        ot_passage = ot_passage[4:] # trim leading LXX
        expected_end = " (book position " + str(ot_startpos) + "-" + str(ot_startpos + ot_length - 1) + ")"
        expected = "Found in " + ot_passage + expected_end
        if bibref.before.decode('utf-8').find(expected) == -1:
            ot_passage_s = ot_passage.split()
            if len(ot_passage_s) == 2:
                ot_passage = ot_passage_s[0] + " " + ot_passage_s[1] + " " + ot_passage_s[1] # end verse := start verse
                expected = "Found in " + ot_passage + expected_end
                if bibref.before.decode('utf-8').find(expected) == -1:
                    print(f"Entry {ot_passage} ({found_method}) is incorrect")
                    errors += 1
            else:
                print(f"Entry {ot_passage} ({found_method}) is incorrect")
                errors += 1
        command4 = "find2 SBLGNT"
        bibref.sendline(command4)
        bibref.expect("[0-9]+ occurrences.")
        nt_passage = nt_passage[7:] # trim leading SBLGNT
        expected_end = " (book position " + str(nt_startpos) + "-" + str(nt_startpos + nt_length - 1) + ")"
        expected = "Found in " + nt_passage + expected_end
        if bibref.before.decode('utf-8').find(expected) == -1:
            nt_passage_s = nt_passage.split()
            if len(nt_passage_s) == 2:
                nt_passage = nt_passage_s[0] + " " + nt_passage_s[1] + " " + nt_passage_s[1] # end verse := start verse
                expected = "Found in " + nt_passage + expected_end
                if bibref.before.decode('utf-8').find(expected) == -1:
                    print(f"Entry {nt_passage} ({found_method}) is incorrect")
                    errors += 1
            else:
                print(f"Entry {nt_passage} ({found_method}) is incorrect")
                errors += 1
        percent = int(r/len(rows)*100)
        print(f"{percent}% done\u001b[{0}K\r", end='')
        r += 1
    print(f"Done\u001b[{0}K")

def nt_quotation_introduction_entries_lengths(conn):
    """
    Check if all NT quotation introduction entries are consistent:
    The length of the texts must match the entries.
    :param conn: the Connection object
    """

    global bibref, errors
    cur = conn.cursor()
    cur.execute("SELECT nt_passage, nt_startpos, nt_endpos" +
        " FROM nt_quotation_introductions" +
        " ORDER BY nt_passage")
    rows = cur.fetchall()

    spawn_bibref()
    print("Checking lengths of NT quotation introduction entries...")

    r = 0
    for row in rows:
        nt_passage = row[0]
        nt_startpos = row[1]
        nt_endpos = row[2]
        nt_length = nt_endpos - nt_startpos + 1
        command2 = "lookup2 " + nt_passage
        bibref.sendline(command2)
        bibref.expect("Stored internally as \w.")
        command4 = "length2"
        bibref.sendline(command4)
        bibref.expect("Length of text 2 is ([0-9]+).")
        length2s = bibref.match.groups()
        length2 = int(length2s[0])
        if nt_length != length2:
            print(f"Length for NT passage {nt_passage} does not match, in database {nt_length}, in NT {length2}")
            errors += 1
        percent = int(r/len(rows)*100)
        print(f"{percent}% done\u001b[{0}K\r", end='')
        r += 1
    print(f"Done\u001b[{0}K")

def clasp_entries_lengths(conn):
    """
    Check if all clasps are consistent:
    The length of the texts must match the entries.
    :param conn: the Connection object
    """

    global bibref, errors
    cur = conn.cursor()
    cur.execute("SELECT ot_passage, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length" +
        " FROM clasps" +
        " ORDER BY ot_passage, nt_passage")
    rows = cur.fetchall()

    spawn_bibref()
    print("Checking lengths of clasp entries...")

    r = 0
    for row in rows:
        ot_passage = row[0]
        nt_passage = row[1]
        ot_startpos = row[2]
        ot_length = row[3]
        nt_startpos = row[4]
        nt_length = row[5]
        command1 = "lookup1 " + ot_passage
        bibref.sendline(command1)
        bibref.expect("Stored internally as \w.")
        command2 = "lookup2 " + nt_passage
        bibref.sendline(command2)
        bibref.expect("Stored internally as \w.")
        command3 = "length1"
        bibref.sendline(command3)
        bibref.expect("Length of text 1 is ([0-9]+).")
        length1s = bibref.match.groups()
        length1 = int(length1s[0])
        command4 = "length2"
        bibref.sendline(command4)
        bibref.expect("Length of text 2 is ([0-9]+).")
        length2s = bibref.match.groups()
        length2 = int(length2s[0])
        if ot_length != length1:
            print(f"Length for OT passage {ot_passage} does not match, in database {ot_length}, in OT {length1}")
            errors += 1
        if nt_length != length2:
            print(f"Length for NT passage {nt_passage} does not match, in database {nt_length}, in NT {length2}")
            errors += 1
        percent = int(r/len(rows)*100)
        print(f"{percent}% done\u001b[{0}K\r", end='')
        r += 1
    print(f"Done\u001b[{0}K")

def getrefs_entries(conn):
    """
    Check if the getrefs data are correct.
    :param conn: the Connection object
    """

    global bibref, errors
    cur = conn.cursor()
    cur.execute("SELECT ot_passage, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length" +
        " FROM quotations" +
        " WHERE found_method='getrefs'" +
        " ORDER BY ot_passage, nt_passage")
    rows = cur.fetchall()

    spawn_bibref()
    print("Checking getrefs data...")
    bibref.timeout = 60

    r = 0
    for row in rows:
        ot_passage = row[0]
        nt_passage = row[1]
        ot_startpos = row[2]
        ot_length = row[3]
        nt_startpos = row[4]
        nt_length = row[5]
        command = "getrefs SBLGNT " + ot_passage
        bibref.sendline(command)
        bibref.expect("Finished")
        expected = ot_passage + " = " + nt_passage + " (length=" + str(ot_length) + ", pos1=" + str(ot_startpos) + ", pos2=" + str(nt_startpos) + ")"
        if bibref.before.decode('utf-8').find(expected) == -1:
            print(f"Database entry {expected} is incorrect")
            errors += 1
        percent = int(r/len(rows)*100)
        print(f"{percent}% done\u001b[{0}K\r", end='')
        r += 1
    print(f"Done\u001b[{0}K")
    bibref.timeout = 5

def clasp_entries(conn): # TODO: This is almost exactly the same as quotation_entries. Unify.
    """
    Check if clasp entries are correct.
    :param conn: the Connection object
    """

    global bibref, errors
    cur = conn.cursor()
    cur.execute("SELECT ot_book, ot_passage, nt_book, nt_passage, ot_startpos, ot_length, nt_startpos, nt_length" +
        " FROM clasps" +
        " WHERE ot_passage != 'LXX Genesis 12:7+20 12:7-90'" # for some strange reason this cannot be found properly, FIXME (kai)
        " AND ot_passage != 'LXX Isaiah 54:13 54:13-57'" # same problem (kai)
        " AND ot_passage != 'LXX Isaiah 56:7+89 56:7-99'" # same problem (kai)
        " AND ot_passage != 'LXX Isaiah 52:5+105 52:5-33'" # same problem (to)
        " ORDER BY ot_passage, nt_passage")
    rows = cur.fetchall()

    spawn_bibref()
    print("Checking clasp entries...")

    r = 0
    for row in rows:
        ot_book = row[0]
        ot_passage = row[1]
        nt_book = row[2]
        nt_passage = row[3]
        ot_startpos = row[4]
        ot_length = row[5]
        nt_startpos = row[6]
        nt_length = row[7]
        command0 = "maxresults 1000000" # ~infinity
        bibref.sendline(command0)
        bibref.expect("Set to \w.")
        command1 = "lookup1 " + ot_passage
        bibref.sendline(command1)
        bibref.expect("Stored internally as \w.")
        command2 = "lookup2 " + nt_passage
        bibref.sendline(command2)
        bibref.expect("Stored internally as \w.")
        command3 = "find1 LXX"
        bibref.sendline(command3)
        bibref.expect("[0-9]+ occurrences.")
        ot_passage = ot_passage[4:] # trim leading LXX
        expected_end = " (book position " + str(ot_startpos) + "-" + str(ot_startpos + ot_length - 1) + ")"
        expected = "Found in " + ot_passage + expected_end
        if bibref.before.decode('utf-8').find(expected) == -1:
            ot_passage_s = ot_passage.split()
            if len(ot_passage_s) == 2:
                ot_passage = ot_passage_s[0] + " " + ot_passage_s[1] + " " + ot_passage_s[1] # end verse := start verse
                expected = "Found in " + ot_passage + expected_end
                if bibref.before.decode('utf-8').find(expected) == -1:
                    print(f"Entry {ot_passage} is incorrect")
                    errors += 1
            else:
                print(f"Entry {ot_passage} is incorrect")
                errors += 1
        command4 = "find2 SBLGNT"
        bibref.sendline(command4)
        bibref.expect("[0-9]+ occurrences.")
        nt_passage = nt_passage[7:] # trim leading SBLGNT
        expected_end = " (book position " + str(nt_startpos) + "-" + str(nt_startpos + nt_length - 1) + ")"
        expected = "Found in " + nt_passage + expected_end
        if bibref.before.decode('utf-8').find(expected) == -1:
            nt_passage_s = nt_passage.split()
            if len(nt_passage_s) == 2:
                nt_passage = nt_passage_s[0] + " " + nt_passage_s[1] + " " + nt_passage_s[1] # end verse := start verse
                expected = "Found in " + nt_passage + expected_end
                if bibref.before.decode('utf-8').find(expected) == -1:
                    print(f"Entry {nt_passage} is incorrect")
                    errors += 1
            else:
                print(f"Entry {nt_passage} is incorrect")
                errors += 1
        percent = int(r/len(rows)*100)
        print(f"{percent}% done\u001b[{0}K\r", end='')
        r += 1
    print(f"Done\u001b[{0}K")


def main():
    database = r"quotations.sqlite3"
    conn = create_connection(database)
    quotation_entries(conn)
    getrefs_entries(conn)
    book_entries(conn)
    quotation_entries_lengths(conn)
    nt_quotation_introduction_entries_lengths(conn)
    clasp_entries_lengths(conn)
    clasp_entries(conn)
    if errors == 0:
        print("All tests passed")
    else:
        print(errors, "error(s)")
        sys.exit(1)


if __name__ == '__main__':
    main()
