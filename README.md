Kalk
====
### Kalk is a calculator application built with the [Kirigami framework](https://kde.org/products/kirigami/). Though mainly targeted to mobile platform, the UI/UX is also smooth on desktop.

### Starting as a fork of [Liri calculator](https://github.com/lirios/calculator), Kalk went through heavy development, and we current share no code with Liri calculator.

### features
* basic calculation
* history
* unit conversion 
* currency coversion

## Dependencies
* Qt5 
* Cmake
* KI18n
* KUnitConversion
* Kirigami
* KConfig
* GNU Bison
* Flex
## Build, Install

```sh
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/path/to/prefix -G Ninja ..
ninja install # use sudo if necessary
```

Replace `/path/to/prefix` to your installation prefix.
Default is `/usr/local`.

## Licensing
### GPL 3
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
