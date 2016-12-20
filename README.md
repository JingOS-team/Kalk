Liri Calculator
===============

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/lirios/calculator.svg)](https://github.com/lirios/calculator)
[![Build Status](https://travis-ci.org/lirios/calculator.svg?branch=master)](https://travis-ci.org/lirios/calculator)
[![GitHub issues](https://img.shields.io/github/issues/lirios/calculator.svg)](https://github.com/lirios/calculator/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2016.svg)](https://github.com/lirios/calculator/commits/develop)

A cross-platform material design web calculator

## Dependencies
* Qt >= 5.7.0 with at least the following modules is required:
 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
 * [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git)

The following modules and their dependencies are required:
* [fluid](https://github.com/lirios/fluid)

## Build

From the root of the repository, run:
```sh
mkdir build && cd build
qmake ..
make
```

Use `make distclean` from inside your `build` directory to clean up.
You need to do this before rerunning `qmake` with different options.

## Install

From your build directory, run:
```sh
sudo make install
```
The calculator will be installed to `/usr/local` by default. To specify a custom installation prefix,
set the `PREFIX` environment variable when running `qmake`. For example:
```sh
PREFIX=/opt qmake ..
```

## Licensing
Licensed under the terms of the GNU General Public License version 3 or, at your option, any later version.
