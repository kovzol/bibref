# bibref

*bibref* is a tool that helps discovering internal references in the Bible.
It aims to find citations of the
[Septuagint](https://en.wikipedia.org/wiki/Septuagint) in the
[Greek New Testament](https://en.wikipedia.org/wiki/New_Testament)
in a mechanical way.

## Background

The [Bible](https://en.wikipedia.org/wiki/Bible),
a book that has been translated into [many languages](https://en.wikipedia.org/wiki/Bible_translations),
is maybe the most important book has ever existed. Believers
have evidence that it is God's word, written by
various people being inspired by God himself.

The Bible has many internal references. Many of them
connect the two parts of the Bible: the Old Testament
and the New Testament. The books of the Old Testament are
usually written in Hebrew, while the books of the New Testament
are Greek. A natural question can arise: How can Hebrew
texts be cited in the Greek text?

There are several research projects on this,
and today it seems to be clear that many authors of
the New Testament cite a Greek translation of
the Hebrew text, namely the Septuagint, that
was widely popular in the first centuries, and still popular
in some Christian churches. Many
Bible translations, however, mostly use only the
Hebrew text as a basis of the Old Testament,
because the importance of the Septuagint is
not yet widely identified.

## This project

This software project attempts to support finding citations
of the Septuagint in the New Testament automatically.
The work is based on The SWORD Project.

The *bibref* package offers several tools that help in comparing
the verses of the Septuagint with the verses of the Greek New Testament.
The tools consider the texts of full books of the Bible as one unit instead
of considering just separated verses.
The texts are provided by the SWORD project
from the modules LXX and SBLGNT.

This project is a work in progress.

## Using the software tool

At the moment the project was tested on
Ubuntu Linux 18.04 but it should work
on many other systems.

### Installation

The following commands
should be entered on command line:
```commandline
sudo apt install libsword-common libsword-dev libreadline-dev libboost-dev git cmake build-essential
git clone https://github.com/kovzol/bibref.git
cd bibref
cmake .
make
```
Then the modules LXX and SBLGNT need to be downloaded from
[The SWORD Project](https://www.crosswire.org/sword/modules/ModDisp.jsp?modType=Bibles).
Finally the steps at the [For Linux](https://www.crosswire.org/sword/docs/moduleinstall.jsp)
section on the website of The SWORD Project should be followed.

### Running

Enter the command
```commandline
./bibref
```

### Example

The following session finds the corresponding citation of the LXX text of Psalm 82:6 in the SBLGNT:
```commandline
This is bibref-cli 2020Apr16, nice to meet you.
>> addbooks
Loading LXX...
Genesis contains 150801 characters,
Exodus contains 120175 characters,
Leviticus contains 91277 characters,
Numbers contains 124091 characters,
Deuteronomy contains 108557 characters,
Joshua contains 72453 characters,
Judges contains 77028 characters,
Ruth contains 9726 characters,
I Samuel contains 95731 characters,
II Samuel contains 85020 characters,
I Kings contains 92493 characters,
II Kings contains 91602 characters,
I Chronicles contains 78325 characters,
II Chronicles contains 104678 characters,
Ezra contains 27920 characters,
Nehemiah contains 37955 characters,
Esther contains 20224 characters,
Job contains 66243 characters,
Psalms contains 171874 characters,
Proverbs contains 59753 characters,
Ecclesiastes contains 21570 characters,
Song of Solomon contains 10129 characters,
Isaiah contains 133267 characters,
Jeremiah contains 143763 characters,
Lamentations contains 12859 characters,
Ezekiel contains 142524 characters,
Daniel contains 45876 characters,
Hosea contains 19882 characters,
Joel contains 7986 characters,
Amos contains 16132 characters,
Obadiah contains 2332 characters,
Jonah contains 5097 characters,
Micah contains 11806 characters,
Nahum contains 4904 characters,
Habakkuk contains 5557 characters,
Zephaniah contains 6192 characters,
Haggai contains 4518 characters,
Zechariah contains 24831 characters,
and Malachi contains 7250 characters.
Done loading books of LXX.
Loading SBLGNT...
Matthew contains 89148 characters,
Mark contains 55157 characters,
Luke contains 94627 characters,
John contains 69675 characters,
Acts contains 94673 characters,
Romans contains 33946 characters,
I Corinthians contains 32357 characters,
II Corinthians contains 22139 characters,
Galatians contains 10990 characters,
Ephesians contains 11894 characters,
Philippians contains 7914 characters,
Colossians contains 7856 characters,
I Thessalonians contains 7389 characters,
II Thessalonians contains 4034 characters,
I Timothy contains 8808 characters,
II Timothy contains 6484 characters,
Titus contains 3712 characters,
Philemon contains 1558 characters,
Hebrews contains 26187 characters,
James contains 8741 characters,
I Peter contains 9001 characters,
II Peter contains 6039 characters,
I John contains 9418 characters,
II John contains 1125 characters,
III John contains 1107 characters,
Jude contains 2550 characters,
and Revelation of John contains 45581 characters.
Done loading books of SBLGNT.
>> lookup1 LXX Psalms 82:6
Stored internally as egveipaueoiestekaiyioiycistoypantes.
>> minunique1 LXX
Text eipau is minimal unique.
Text ipaue is minimal unique.
Text paueo is minimal unique.
Text aueoie is minimal unique.
Text yioiyc is minimal unique.
Text stekaiy is minimal unique.
Text aiyioiy is minimal unique.
Text eoiestek is minimal unique.
Text stoypant is minimal unique.
Text iycistoyp is minimal unique.
Text cistoypan is minimal unique.
>> latintext2 eipaueo
Stored.
>> find2 SBLGNT 
Found in John 10:34+58 10:34-5 (book position 35754-35760)
1 occurrences.
>> quit
Goodbye.
```

### Available commands

For most commands two clipboards can be used. They are numbered with 1 and 2.
These clipboards store the Latin transcription of the Greek texts to work with.
Typically clipboard 1 is used to store a passage from the LXX and clipboard 2
for the SBLGNT. Therefore some commands can work only with one of the clipboards.

* `addbooks`: Load the books of LXX and SBLGNT.
* `textN` *text*: Define a Greek *text* and puts its Latin transcription in clipboard N.
* `latintextN` *text*: Put the Latin transcription *text* in clipboard N.
* `findN` *Bible*: Searches for the text of clipboard N in the given *Bible*.
* `lengthN`: Compute the length of the text in clipboard N.
* `lookupN` *Bible* *book* *verse*: Searches for the given *verse* in the given *book* in the given *Bible*.
* `lookupN` *Bible* *book* *verseStart* *verseEnd*: Searches for the given passage between *verseStart* and *verseEnd*
   in the given *book* in the given *Bible*.
   - If *verse1* contains a `+M` modifier (where M is a non-negative integer)
     then the first M characters will be removed from text.
   - If *verse2* contains a `-M` modifier (where M is a non-negative integer)
     then the last M characters will be removed from text.
* `minunique1` *Bible*: Searches for minimal unique passages in clipboard 1 in the given *Bible*.
* `extend` *Bible1* *Bible2* *book2* *verse2Start* *verse2End*: Extends the given passage in *Bible2* according to the longest possible citation from *Bible1*, based on the text of *book2* between *verse2Start* and *verse2End*. In most cases `LXX` is used for *Bible1* and `SBLGNT` for *Bible2*.
* `extend` *Bible1* *Bible2* *book2* *verse*: Extends the given passage in *Bible2* according to the longest possible citation from *Bible1*, based on the text of *book2* in *verse*. In most cases `LXX` is used for *Bible1* and `SBLGNT` for *Bible2*.
* `quit`: Exit program.
* `help`: Show some hints on usage.

The *Bible* parameter can be either `LXX` or `SBLGNT`.

There may be other commands available that are not documented yet.
