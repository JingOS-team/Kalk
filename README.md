Liri Calculator
===============

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/lirios/calculator.svg)](https://github.com/lirios/calculator)
[![Build Status](https://travis-ci.org/lirios/calculator.svg?branch=master)](https://travis-ci.org/lirios/calculator)
[![Snap Status](https://build.snapcraft.io/badge/lirios/calculator.svg)](https://build.snapcraft.io/user/lirios/calculator)
[![GitHub issues](https://img.shields.io/github/issues/lirios/calculator.svg)](https://github.com/lirios/calculator/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2017.svg)](https://github.com/lirios/calculator/commits/master)

A cross-platform material design calculator.

## Dependencies

Qt >= 5.8.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
 * [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git)

The following modules and their dependencies are required:

 * [qbs-shared](https://github.com/lirios/qbs-shared.git)
 * [fluid](https://github.com/lirios/fluid.git)

## Build

Liri Calculator uses [Qbs](http://doc.qt.io/qbs/) as build system.

If you haven't already, start by setting up a `qt5` profile for `qbs`:

```sh
qbs setup-toolchains --type gcc /usr/bin/g++ gcc
qbs setup-qt $(which qmake) qt5 # make sure that qmake is in PATH
qbs config profiles.qt5.baseProfile gcc
```

Then, from the root of the repository, run:

```sh
qbs -d build -j $(nproc) profile:qt5 # use sudo if necessary
```

To the `qbs` call above you can append additional configuration parameters:

 * `project.withFluid:true`: use git submodule for Fluid
 * `qbs.installRoot:/install/root`: e.g. /
 * `qbs.installPrefix:path/to/install`: e.g. opt/liri or usr

## Licensing

Licensed under the terms of the GNU General Public License version 3 or, at your option, any later version.
