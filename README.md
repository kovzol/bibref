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
...
and Malachi contains 7250 characters.
Done loading books of LXX.
Loading SBLGNT...
Matthew contains 89148 characters,
...
Jude contains 2550 characters,
and Revelation of John contains 45581 characters.
Done loading books of SBLGNT.
>> getrefs SBLGNT LXX Psalms 2:1
LXX Psalms 2:1 2:2-8 = SBLGNT Acts 4:25+54 4:26 (length=131, pos1=11491)
>> quit
Goodbye.
```

### Available commands

For most commands two clipboards can be used. They are numbered with 1 and 2.
These clipboards store the Latin transcription of the Greek texts to work with.
Typically clipboard 1 is used to store a passage from the LXX and clipboard 2
for the SBLGNT. Therefore some commands can work only with one of the clipboards.

In all commands where *passage* is given as a parameter, it can be either one
verse with the classic notation (e.g. `1:2`), or it can be fine tuned by entering
two positions: a *verseStart* and a *verseEnd*. These can be also given
with the classic notation or a modifier can be appended:

* If *verseStart* is appended by a `+M` modifier (where M is a non-negative integer)
  then the first M characters will be removed from the passage.
* If *verseEnd* is appended by a `-M` modifier (where M is a non-negative integer)
  then the last M characters will be removed from the passage.

For example, `Genesis 1:1`, `Genesis 1:1+0 1:1-0`, `Genesis 1:1+0 1:1`, `Genesis 1:1 1:1-0` define the same first verse
of Genesis. On the other hand, `Genesis 1:1+2 1:1-3` defines the first verse of Genesis without the first two and the last three letters.

The available commands are:

* `addbooks`: Load the books of LXX and SBLGNT.
* `textN` *text*: Define a Greek *text* and put its Latin transcription in clipboard N.
* `latintextN` *text*: Put the Latin transcription *text* in clipboard N.
* `findN` *Bible*: Search for the text of clipboard N in the given *Bible*.
* `lengthN`: Compute the length of the text in clipboard N.
* `lookupN` *Bible* *book* *passage*: Search for the given *passage* in the given *book* in the given *Bible*.
* `minunique1` *Bible*: Search for minimal unique passages in clipboard 1 in the given *Bible*.
* `extend` *Bible1* *Bible2* *book2* *passage2*: Extend the given passage in *Bible2* according to the longest possible citation from *Bible1*, based on the text of *book2* in *passage2*. In most cases `LXX` is used for *Bible1* and `SBLGNT` for *Bible2*.
* `getrefs` *Bible2* *Bible1* *book1* *passage1*: Search for references in *Bible2* on the passage in *Bible1* in book *book1* in *passage1*. Usually `SBLGNT` stands for *Bible2* and `LXX` for *Bible1*.
* `quit`: Exit program.
* `help`: Show some hints on usage.

The *Bible* parameter can be either `LXX` or `SBLGNT`.

There may be other commands available that are not documented yet.

Some [examples](/examples) are also available.
