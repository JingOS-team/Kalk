Liri Calculator
===============

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/lirios/calculator.svg)](https://github.com/lirios/calculator)
[![Build Status](https://travis-ci.org/lirios/calculator.svg?branch=master)](https://travis-ci.org/lirios/calculator)
[![GitHub issues](https://img.shields.io/github/issues/lirios/calculator.svg)](https://github.com/lirios/calculator/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2017.svg)](https://github.com/lirios/calculator/commits/master)

A cross-platform material design calculator.

## Dependencies

Qt >= 5.8.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
 * [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git)

The following modules and their dependencies are required:

 * [fluid](https://github.com/lirios/fluid.git)

## Build

From the root of the repository, run:

```sh
mkdir build; cd build
qmake ..
make
make install # use sudo if necessary
```

On the `qmake` line, you can specify additional configuration parameters:

 * `LIRI_INSTALL_PREFIX=/path/to/install` (for example `/opt/liri` or `/usr`)
 * `CONFIG+=debug` if you want a debug build

Use `make distclean` from inside your `build` directory to clean up.
You need to do this before rerunning `qmake` with different options.

## Licensing

Licensed under the terms of the GNU General Public License version 3 or, at your option, any later version.
