Kalk
====

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![Relative date](https://img.shields.io/date/1581807600?color=orange&label=forked)](https://github.com/lirios/calculator)
[![Ready for](https://img.shields.io/badge/Ready%20for-Plasma%20Mobile-3daee9)](https://plasma-mobile.org)

Kalk is a powerful cross-platfrom calculator application built with the [Kirigami framework](https://kde.org/products/kirigami/).

Kalk is targeted towards the use with Plasma Mobile, but can also be used on desktop platforms.

Kalk is in a very early stage of development and very work in progress. See todo list below for the things left to be done.

Kalk is a fork of [Liri calculator](https://github.com/lirios/calculator)

## Screenshots
<!-- TODO -->
<img width="200px" style="float: left" src="screenshots/screenshot 1.png"/>
<img width="200px" style="float: left" src="screenshots/screenshot 2.png"/>
<img width="200px" style="float: left" src="screenshots/screenshot 3.png"/>
<img width="200px" style="float: left" src="screenshots/screenshot 4.png"/>
<img width="200px" style="float: left" src="screenshots/screenshot 5.png"/>
<img width="200px" style="float: left" src="screenshots/screenshot 6.png"/>

<!-- ## Features -->
<!-- TODO -->

## Dependencies

Qt >= 5.10.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
 * [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git)

The following modules and their dependencies are required:

 * [cmake](https://gitlab.kitware.com/cmake/cmake) >= 3.10.0

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

You can also append the following options to the `cmake` command:

 * `-DCALCULATOR_WITH_FLUID:BOOL=ON`: Build with a local copy of the Fluid sources.

## Todo
* [ ]  clean up codebase and project
* [ ]  remove unnecessary dependencies like the Fluid framework (not needed any more)
* [ ]  clean up / rewrite cmake file
* [ ]  about page
* [ ]  add = sign to button panel
* [ ]  properly integrate history
* [ ]  proper navigation through global drawer
* [ ]  move advanced mode only actions from global drawer to page-specific main, left and right action
* [ ]  add app name and app icon to global drawer
* [ ]  find more appropriate icons for actions in global drawer
* [ ]  add visual indicator that global drawer is present
* [ ]  add visual indicator that side button panels with functions and more special signs are available
* [ ]  improve "Discard unsaved" alert in advanced mode
* [ ]  adjust overall UI in advanced mode
* [ ]  make button panel available in advanced mode
* [ ]  debug error "Segmentation fault (core dumped)"
* [ ]  adjust application name displaid in application menu
* [ ]  app icon not shown in window bar
* [ ]  solve button highlighting bug
* [ ]  turn hardcoded colors into colors derived from the theme
* [ ]  default window size
* [ ]  minimum window size?
* [ ]  own app icon
* [ ]  discuss the design with the VDG
* [ ]  make the UI and UX follow the Kirigami HIG

## Licensing

Licensed under the terms of the GNU General Public License version 3 or, at your option, any later version.

See the file LICENSE.GPLv3 for the full license text.

Kalk is a fork of [Liri calculator](https://github.com/lirios/calculator). It was forked at February the 16th.

See the licensing headers in the source files for the original authors and copyright holders.
