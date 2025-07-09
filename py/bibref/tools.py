import sys, pexpect, os, re

bibref_default_timeout = 5
bibref_default_timeout_max = 180
bibref_fullpath = ""

bibref = None

def set_bibref_path(fullpath = ""):
    global bibref_fullpath
    bibref_fullpath = fullpath

def spawn_bibref():
    global bibref
    if bibref is not None:
        return
    sys.stderr.write("Waiting for bibref's full startup...\n")

    if bibref_fullpath != "":
        bibref = pexpect.spawn(bibref_fullpath + " -a")
        bibref.expect("Done loading books of SBLGNT.")
        bibref.timeout = bibref_default_timeout
        return

    for subdir, dirs, files in os.walk('../..'):
        for file in files:
            fullpath = os.path.join(subdir, file)
            if os.access(fullpath, os.X_OK) and file == "bibref":
                sys.stderr.write(f"Spawning {fullpath}...\n");
                bibref = pexpect.spawn(fullpath + " -a")
                bibref.expect("Done loading books of SBLGNT.")
                bibref.timeout = bibref_default_timeout
                return

    raise Exception("Unsuccessful attempt to run bibref")

def getrefs_maxlength(getrefs_input):
    """
    Returns the length of the longest match.
    :param getrefs_input: All parameters of getref as string
    :return: The length of the longest match
    """
    global bibref
    spawn_bibref()
    bibref.timeout = bibref_default_timeout_max
    command = "getrefs " + getrefs_input
    bibref.sendline(command)
    bibref.expect("Finished")
    lines = bibref.before.decode('utf-8').splitlines()
    no_lines = len(lines)
    length_regex = re.compile(r'length=([0-9]+),')
    found = length_regex.search(lines[no_lines - 1])
    maxlength0 = found.group()
    maxlength1 = maxlength0.split("=")
    maxlength2 = maxlength1[1]
    maxlength3 = maxlength2.split(",")
    maxlength = maxlength3[0]
    bibref.timeout = bibref_default_timeout
    return maxlength

def text_n(c, greektext):
    """
    Stores the Greek input in the selected clipboard.
    :param c: Clipboard number (1 or 2)
    :param greektext: Greek input as string
    :return: the input converted to Latin notation
    """
    global bibref
    spawn_bibref()
    bibref.timeout = bibref_default_timeout
    command = "text" + str(c) + " " + greektext
    bibref.sendline(command)
    bibref.expect("Stored internally as (\\w+).")
    form = bibref.match.groups()
    return form[0].decode('utf-8')

def lookup_n(c, passage):
    """
    Looks up the passage and stores it in the selected clipboard.
    :param c: Clipboard number (1 or 2)
    :param passage: The passage to look up
    :return: the passage converted to Latin notation
    """
    global bibref
    spawn_bibref()
    bibref.timeout = bibref_default_timeout
    command = "lookup" + str(c) + " " + passage
    bibref.sendline(command)
    bibref.expect("Stored internally as (\\w+).")
    form = bibref.match.groups()
    return form[0].decode('utf-8')

def find_n(c, bible):
    """
    Finds the clipboard text in a Bible edition.
    :param c: Clipboard number (1 or 2)
    :param bible: Bible edition
    :return: list of strings that explain the matches (in bibref format: passage, raw_start, raw_end)
    """
    global bibref
    spawn_bibref()
    bibref.timeout = bibref_default_timeout
    command = "find" + str(c) + " " + bible
    bibref.sendline(command)
    ret = []
    finished = False
    # Found in Acts 13:33+88 13:33 (book position 43840-43871)
    # Found in Hebrews 1:5+26 1:5-53 (book position 420-451)
    # Found in Hebrews 5:5+70 5:5 (book position 6271-6302)
    # 3 occurrences.
    while not finished:
        index = bibref.expect([r'Found in (.*?) \(book position ([0-9]+)\-([0-9]+)\)',r'([0-9]+) occurrences.'])
        if index == 0:
            passage, raw1, raw2 = bibref.match.groups()
            ret.append([passage.decode('utf-8'), int(raw1), int(raw2)])
        if index == 1:
            finished = True
    return ret
