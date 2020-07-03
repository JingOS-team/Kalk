Kalk
====
Kalk is a powerful cross-platfrom calculator application built with the [Kirigami framework](https://kde.org/products/kirigami/).

Kalk is targeted towards the use with Plasma Mobile, but can also be used on desktop platforms.

Kalk is in a very early stage of development and very work in progress. See issue in gitlab for things to be done.

Kalk is a fork of [Liri calculator](https://github.com/lirios/calculator)


## Dependencies
Qt5, cmake, KI18n, KUnitConversion, Kirigami , KConfig
## Build, Install

```sh
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/path/to/prefix -G Ninja..
ninja install # use sudo if necessary
```

Replace `/path/to/prefix` to your installation prefix.
Default is `/usr/local`.

## Licensing
Kalk is a fork of [Liri calculator](https://github.com/lirios/calculator). This branch was forked from [cahfofpai's fork](https://invent.kde.org/cahfofpai/kalk)

I don't know how to licensing this.
