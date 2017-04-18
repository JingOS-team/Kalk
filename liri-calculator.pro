load(liri_deployment)

TEMPLATE = app
TARGET = liri-calculator

CONFIG += c++11
QT += qml quick svg quickcontrols2 widgets

ICON += $$PWD/src/icons/liri-calculator.icns

RESOURCES += \
    $$PWD/src/engine/engine.qrc \
    $$PWD/src/ui/ui.qrc \
    $$PWD/src/icons/icons.qrc

unix:!android {
    target.path = $$LIRI_INSTALL_BINDIR
    INSTALLS += target
}

unix:!android:!mac {
    ICONS_SIZES = 16 32 64 128 192 256 512 1024 2048
    for(size, ICONS_SIZES) {
        eval(icon$${size}.files = data/icons/$${size}x$${size}/io.liri.Calculator.png)
        eval(icon$${size}.path = $$LIRI_INSTALL_PREFIX/share/icons/hicolor/$${size}x$${size}/apps)
        INSTALLS += icon$${size}
    }

    desktop.files = data/io.liri.Calculator.desktop
    desktop.path = $$LIRI_INSTALL_APPLICATIONSDIR
    INSTALLS += desktop

    appdata.files = data/io.liri.Calculator.appdata.xml
    appdata.path = $$LIRI_INSTALL_APPDATADIR
    INSTALLS += appdata
}

include(src/main/main.pri)
include(src/filehandler/filehandler.pri)
