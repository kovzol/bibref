# Statements in **bibref**

In this folder an implementation of statement checks is provided. The statements were exported
from the [SQL quotation database](../docs/common/quotations.sql) via `make statements-files`
in that directory and further processed with various (automatic and manual) steps. Now
the SQL quotation database is no longer used by the mainstream research.

The checks are described in the **.y** file. They are currently:

* syntactical parsing
* check if the passages are mentioned with their correct raw positions (including length) and a-y form
* check if introductional passages indeed contain the declarations and sources mentioned
* check fragment matches and Jaccard differences
* overall cover check (percentual)
* check if NT introductions overlap NT fragments (they should not)
* check if NT headline interval is well-chosen
* check if OT headlines are well-chosen
* check if OT parts of fragments are unique

These checks are integrated in the **bibref** program as well if
**bibref** is compiled with PBRST support (see the **cmake** machinery
for details). Any **.brst** example can be entered in the command line interface.
This feature is also included in the Qt version (if it is compiled with PBRST support).

The **.brst** entries can be visually graphed in the Qt version, or a GraphViz file
can be exported via the command line tool **pbrst-cli**.

It is planned that a user-maintained subset or extension of the **.brst** files could
be analyzed as a whole, for example, to be informed if two quotations are mentioned
consecutively. In fact, introductions of different quotations may overlap, because
the same introduction can indicate the author for different quotations, for example.
In addition, the user may want to do minor changes in the **.brst** files
to use StatResGNT instead of SBLGNT, for example. Also, a newer version of the LXX module
can be interesting, since it contains deuterocanonical books.
