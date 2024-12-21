# Statements in **bibref**

In this folder there is experimental code that checks statements that can be exported
from the [quotation database](../docs/common/quotations.sql) via `make statements-files`
in that directory. The exported files have already been copied to the [tests](tests) folder.
In some cases they have been tailored or fine-tuned if the database cannot describe
some features.

The scenario is to move all database entries into **.brst** files and
make it possible to parse them syntactically and in content. The
syntactical check is already working via a flex/bison machinery. It is
extensible if further information needs to be added. The old database
should be obsoleted someday.

The checks are described in the **.y** file. They are currently:

* syntactical parsing
* check if the passages are mentioned with their correct raw positions (including length)
* check if introductional passages indeed contain the declarations and sources mentioned
* check fragment matches and Jaccard differences
* overall cover check

To be written (that is, these checks are not yet implemented):

* check if NT introductions overlap NT fragments (they should not, e.g. q97 is erroneous)
* check if OT parts of fragments are unique, if not, allow to mention that in the .brst language

As a next step, these checks are planned to be integrated in the **bibref** program as well.
Currently, **bibref** can be compiled to give it a try (see the **cmake** machinery
for details). Any **.brst** example can entered in the command line interface (by using
a lowercased `statement`). This is, however, in an experimental phase and not well-tested yet.
Later, this feature is planned to be included in the Qt version as well.

The **.brst** entries could then be visually graphed, similarly to the SVG outputs of the
old database. Also, a user-maintained subset or extension of the **.brst** files could
be analyzed as a whole, for example, to be informed if two quotations are mentioned
consecutively. In fact, introductions of different quotations may overlap, because
the same introduction can indicate the author for different quotations, for example.
In addition, the user may want to do minor changes in the **.brst** files
to use StatResGNT instead of SBLGNT, for example. Also, a newer version of the LXX module
can be interesting, since it contains deuterocanonical books.
