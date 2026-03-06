# Examples

The `.txt` files in this folder show example uses of **bibref**'s commands.
Most of them have been created in an early development stage of the program.
This means that either the underlying databases or the indexing routines
were that time incomplete or erroneous. Therefore, the outputs of the
input commands may be different when using a recent version of the program.

In a future version of **bibref**, these examples will be revisited and
updated to the current state-of-the-art of the program. Please stay tuned.

To check these files quickly, open a terminal and issue `bibref < example.txt`
by using the desired test file name instead of **example.txt**.

## TeXmacs interface

The `.tm` files in this folder have been created with the TeXmacs plugin.
You can load them with the TeXmacs application. If you want to edit the
files (by re-running the **bibref** code eventually), you need to
connect TeXmacs and **bibref** with a simple plugin.

To create a simple TeXmacs plugin for **bibref**, set up the following
folder structure in your `~/.TeXmacs` folder:
```
.TeXmacs
└── plugins
    └── bibref
        └── progs
            └── init-bibref.scm
```
The file **init-bibref.scm** should contain something like this:
```
(plugin-configure bibref
  (:require (url-exists-in-path? "bibref"))
  (:launch "bibref -t -a -c")
  (:tab-completion #t)
  (:session "bibref"))
```
It is assumed that the **bibref** binary is in your path. If you install
**bibref** via Snapcraft, then this should work automatically.

The TeXmacs interface allows the user to use tab completion, colored
outputs, automatic folding of long passages for the output of **bibref**.
The statement diagrams can be retrieved and inserted as postscript
images after issuing the command `diagram ps`.
