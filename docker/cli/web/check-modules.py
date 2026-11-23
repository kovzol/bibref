#!/usr/bin/env python3
"""Fail the web build if SWORD cannot read the added or existing modules."""
import subprocess
import sys
import unicodedata

# Text fragments distinguish real verse content from echoed input/module names.
CHECKS = (
    ('HunRUF Matthew 1:1', 'Jézus'),
    ('Aleppo Isaiah 11:1', 'ויצא'),
    ('LXX Genesis 1:1', 'ἀρχῇ'),
    ('SBLGNT Matthew 1:23', 'παρθένος'),
    ('StatResGNT Matthew 1:23', 'παρθένος'),
    ('KJV Matthew 12:18', 'servant'),
)

def unaccented(text):
    return "".join(c for c in unicodedata.normalize("NFD", text)
                   if not unicodedata.combining(c))


for reference, fragment in CHECKS:
    result = subprocess.run([sys.argv[1]], input=f'lookup {reference}\nquit\n',
                            text=True, capture_output=True, timeout=180, check=True)
    if unaccented(fragment) not in unaccented(result.stdout + result.stderr):
        raise RuntimeError(f'Lookup failed: {reference}\n{result.stdout}\n{result.stderr}')
    print(f'Lookup OK: {reference}')
