TEMPLATE = app
TARGET = liri-calculator

CONFIG += c++11
QT += qml quick

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
