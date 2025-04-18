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

## Documentation

See the [bibref wiki](https://github.com/kovzol/bibref/wiki) for further information.

## Download

The tool can be freely downloaded at the [Releases](https://github.com/kovzol/bibref/releases) page.
