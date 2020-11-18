import QtQuick 2.0

Loader {
    active: false
    source: "qrc:/qml/UnitTypeGrid.qml"
    onActiveChanged: {
        item["load"] = true;
    }
}
