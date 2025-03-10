![A bibref version based on the Qt graphical framework](bibref-qt.png)

# bibref

*bibref* is a tool that helps discovering internal references in the Bible.
It aims at finding citations of the
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
the New Testament cited a Greek translation of
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
The work is based on [The SWORD Project](https://www.crosswire.org/sword/index.jsp).

The *bibref* package offers several tools that help in comparing
the verses of the Septuagint with the verses of the Greek New Testament.
The tools consider the texts of full books of the Bible as one unit instead
of considering just separated verses.
The texts are provided by the SWORD project
from the modules [LXX](http://www.crosswire.org/sword/modules/ModInfo.jsp?modName=LXX) and
[SBLGNT](http://www.crosswire.org/sword/modules/ModInfo.jsp?modName=SBLGNT). In the newest versions
the module [StatResGNT](http://www.crosswire.org/sword/modules/ModInfo.jsp?modName=StatResGNT) is also supported.

This project is a work in progress.

## Using the software tool

### Qt version

Since March 2024 *bibref* comes with a graphical user interface that is based on [Qt](https://qt.io).
You can find information on how to install the program on your machine
on the [Releases](https://github.com/kovzol/bibref/releases) page.

### Terminal based versions

![A bibref version based on jquery.terminal](jt-demo.png)

You need a Linux system (preferred) or a web browser (fallback) to use the terminal
based interface.

At the moment this interface was tested on
Ubuntu Linux 18.04, 19.10, 20.04 and 22.04 but it should work
on many other systems.

#### Snap store installation (preferred)

[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-white.svg)](https://snapcraft.io/bibref)

After installation you need to use the command `bibref` via command line.
In the snap version only the LXX, SBLGNT, StatResGNT and [KJV](http://www.crosswire.org/sword/modules/ModInfo.jsp?modName=KJV) modules are present.
If you want to use additional modules, please try installing the tool from source code (see below).

#### Web version (fallback)

Currently there is an online web version of *bibref* available: [a simple version](https://matek.hu/zoltan/bibref/)
that is based on [jquery.terminal](https://terminal.jcubic.pl/). It is somewhat slower than the installable version, but works immediately
in a web browser (you may need to wait a couple of seconds before the start). In the web versions the modules LXX, SBLGNT, StatResGNT and KJV are available.

### Installation from source code (for developers)

![build](https://github.com/kovzol/bibref/workflows/build/badge.svg)

#### Qt version

We provide some [hints](qt/README.md) to help you build the graphical user interface.

#### Terminal based versions

The following commands
should be entered on command line:
```commandline
sudo apt install libsword-common libsword-dev libreadline-dev libboost-dev libboost-filesystem-dev git cmake build-essential pkg-config
git clone https://github.com/kovzol/bibref.git
cd bibref
mkdir build
cd build
cmake ..
make
make install || true
```

Finally enter the command
```commandline
build/bibref -c
```
to start the program with a user friendly command line interface (with colors).

(If you want to compile the web version, please have a look on
the corresponding [GitHub action](https://github.com/kovzol/bibref/blob/master/.github/workflows/build.yml).)

### Example use case

We follow the syntax of the terminal based version, but the similar steps can be used
on the graphical interface as well.
The following session finds the corresponding citation of the LXX text of Psalm 2:1 in the SBLGNT:
```commandline
This is bibref 2025Feb04, nice to meet you.
>> addbooks
Loading LXX...
Genesis contains 150801 characters,
...
and Odes contains 1550 characters.
Done loading books of LXX.
Loading SBLGNT...
Matthew contains 89148 characters,
...
Jude contains 2550 characters,
and Revelation of John contains 45581 characters.
Done loading books of SBLGNT.
>> getrefs SBLGNT LXX Psalms 2:1
LXX Psalms 2:1 2:2-8 = SBLGNT Acts 4:25+58 4:26 (length=131, pos1=502, pos2=11601)
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

In all commands the *Bible* parameter can be either `LXX`, `SBLGNT`, `StatResGNT`, except for the command `lookup`.

The available commands are:

* `addbooks`: Load the books of LXX, SBLGNT and StatResGNT (if any of these are available). Most commands require that these books are already loaded. After using this command for the first time (it takes a couple of seconds), a folder named `bibref-addbooks-cache` will be created in the current working directory to speed up the next startup of this command.
* `textN` *text*: Define a Greek *text* and put its Latin transcription in clipboard N.
* `latintextN` *text*: Put the Latin transcription *text* in clipboard N.
* `findN` *Bible*: Search for the text of clipboard N in the given *Bible*.
* `lengthN`: Compute the length of the text in clipboard N.
* `printN`: Show the Greek text in clipboard N (without punctuation and spaces).
* `lookup` *Bible* *book* *verse*: Search for the given *verse* in the given *book* in the given *Bible*. Here *Bible* can be any translation that is already [installed as a module](https://www.crosswire.org/sword/modules/ModDisp.jsp?modType=Bibles) on the computer.
* `lookupN` *Bible* *book* *passage*: Search for the given *passage* in the given *book* in the given *Bible* and put its Latin transcription in clipboard N.
* `search` *Bible* *token1* *token2* ... *tokenN* *maxlength*: Search for the given set of tokens on a maximal length of *maxlength* in the given *Bible*.
* `raw` *Bible* *book* *start* *length*: Show the raw Latin transcription of a passage in the given *book* in the given *Bible*, beginning with the *start* position on *length* characters.
* `rawN` *Bible* *book* *start* *length*: Put a passage in the given *book* in the given *Bible*, beginning with the *start* position on *length* characters, in clipboard N.
* `minunique1` *Bible*: Search for minimal unique passages in clipboard 1 in the given *Bible*.
* `extend` *Bible1* *Bible2* *book2* *passage2*: Extend the given passage in *Bible2* according to the longest possible citation from *Bible1*, based on the text of *book2* in *passage2*. In most cases `LXX` is used for *Bible1* and `SBLGNT` for *Bible2*.
* `psalminfo` *Bible* *number*: Show the number of verses in Psalm *number* in the given *Bible*.
* `getrefs` *Bible2* *Bible1* *book1* *passage1*: Search for references in *Bible2* on the passage in *Bible1* in book *book1* in *passage1*. Usually `SBLGNT` stands for *Bible2* and `LXX` for *Bible1*. If *book1* is `Psalms`, the passage can also be its number only.
* `maxresults` *number*: Set the maximal amount of results to be shown to *number*.
* `compare12`: Compare the two clipboards with a 2-long substring-fingerprint (2-shingles) check, best match is reached at 1/(length1+length2).
* `jaccard12`: Compare the two clipboards the same way how `compare12` does but use the "Jaccard similarity for bags" algorithm, best match is reached at 0.
* `sql` *switch*: Set some outputs to be shown also as an SQL query if *switch* is `on`.
* `colors` *switch*: Show some outputs colored if *switch* is `on`.
* `tokens` *Bible* *book* *verse*: Search for the given *verse* in the given *book* in the given *Bible* (see command `lookup`), but the output is shown in a tokenized form. Tokenization is done via Strong's numbers.
* `statement` ...: Analyze the given statement, see [a blog entry](https://matek.hu/zoltan/blog-20240805.php) for some explanations.
* `help` *command*: Show some hints on usage of *command*, or get general help if no parameter is given.
* `quit`: Exit program.

There may be other commands available that are not documented yet. Some commands, including `statement`, may be
unavailable in some builds (e.g., in the web version).

Some [examples](/examples) are provided. See also [an incomplete draft (in Hungarian)](docs/hu/bibref.pdf) on the purpose of the commands.
Also, a work-in-progress database can be found in [docs/common](/docs/common) which aims at collecting all quotations.
As of January 2025, this database has been obsoleted and the statements in the [statements/SBLGNT](/statements/SBLGNT) folder
are considered official.

You may be interested in some [blog entries](https://matek.hu/zoltan/blog-topics.php?t=b) that extensively use the web version of *bibref*.

### Command line options in the terminal based version on Linux

Issue `bibref -h` to learn about the available command line options.
