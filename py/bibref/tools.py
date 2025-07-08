import sys, pexpect, os, re

bibref_default_timeout = 5
bibref_default_timeout_max = 180

bibref = None

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
                bibref.timeout = bibref_default_timeout
                return

    raise Exception("Unsuccessful attempt to run bibref")

def getrefs_maxlength(getrefs_input):
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
