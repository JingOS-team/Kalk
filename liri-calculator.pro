TEMPLATE = app
TARGET = liri-calculator

CONFIG += c++11
QT += qml quick svg quickcontrols2

ICON += src/icons/liri-calculator.icns

# Install to /usr/local by default
# Set the PREFIX environment variable to define
# a custom installation location
prefix = $$(PREFIX)
isEmpty(prefix) {
    prefix = /usr/local
}
target.path = $${prefix}/bin
INSTALLS += target

# Enable High DPI scaling if Qt >= 5.6
greaterThan(QT_MAJOR_VERSION, 4) {
    greaterThan(QT_MINOR_VERSION, 5) {
        DEFINES += ENABLE_HIGH_DPI_SCALING
        message("Using high-dpi scaling")
    }
}

# Include sub project include files
include(src/engine/engine.pri)
include(src/main/main.pri)
include(src/ui/ui.pri)

# Include default rules for deployment
include(deployment/deployment.pri)
