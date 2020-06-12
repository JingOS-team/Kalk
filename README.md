Kalk
====

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![Relative date](https://img.shields.io/date/1581807600?color=orange&label=forked)](https://github.com/lirios/calculator)

Kalk is a powerful cross-platfrom calculator application built with the [Kirigami framework](https://kde.org/products/kirigami/).

Kalk is targeted towards the use with Plasma Mobile, but can also be used on desktop platforms.

Kalk is in a very early stage of development and very work in progress. See todo list below for the things left to be done.

Kalk is a fork of [Liri calculator](https://github.com/lirios/calculator)


## Dependencies
Qt5, cmake
## Build, Install

```sh
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/path/to/prefix ..
make
make install # use sudo if necessary
```

Replace `/path/to/prefix` to your installation prefix.
Default is `/usr/local`.

## Todo
* [ ]  about page
* [ ]  properly integrate history
* [ ]  add visual indicator that side button panels with functions and more special signs are available
* [ ]  debug error "Segmentation fault (core dumped)"
* [ ]  own app icon
* [ ]  discuss the design with the VDG
* [ ]  make the UI and UX follow the Kirigami HIG
* [ ]  write own math expression parser
## Licensing
Kalk is a fork of [Liri calculator](https://github.com/lirios/calculator). This branch was forked from [cahfofpai's fork](https://invent.kde.org/cahfofpai/kalk)

I don't know how to licensing this.
