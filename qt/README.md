# Qt interface

This folder contains files to provide *bibref* with a [Qt](https://qt.io) interface. It is known to work with Qt 6.6 and 6.7.

## Translation steps

`lupdate -tr-function-alias QT_TRANSLATE_NOOP=TR mainwindow.cpp -ts hu.ts` creates or updates the skeleton for the Hungarian translation.
