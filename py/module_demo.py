#!/usr/bin/python3

from bibref.tools import *

print(getrefs_maxlength("SBLGNT LXX Psalms 2"))

text_n(1, "υιος μου ει συ εγω σημερον γεγεννηκα σε")
print(find_n(1, "LXX"))
print(find_n(1, "StatResGNT"))
