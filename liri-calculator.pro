load(liri_deployment)

TEMPLATE = app
TARGET = liri-calculator

CONFIG += c++11
QT += qml quick svg quickcontrols2

ICON += $$PWD/src/icons/liri-calculator.icns

# Enable High DPI scaling if Qt >= 5.6
greaterThan(QT_MAJOR_VERSION, 4) {
    greaterThan(QT_MINOR_VERSION, 5) {
        DEFINES += ENABLE_HIGH_DPI_SCALING
        message("Using high-dpi scaling")
    }
}

SOURCES += \
    $$PWD/src/main/main.cpp

RESOURCES += \
    $$PWD/src/engine/engine.qrc \
    $$PWD/src/ui/ui.qrc

unix:!android {
    target.path = $$LIRI_INSTALL_BINDIR
    INSTALLS += target
}
