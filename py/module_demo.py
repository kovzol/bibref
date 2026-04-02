#!/usr/bin/python3

from bibref.tools import *

print(getrefs_maxlength("SBLGNT LXX Psalms 2"))

text1("υιος μου ει συ εγω σημερον γεγεννηκα σε")
print(find1("LXX"))
print(find1("StatResGNT"))

raw1("LXX","Genesis",1,-1)
print(find1("LXX"))
