import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import ".."


Rectangle {
    id: buttonsView
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    visible: !root.advanced && root.expanded
    implicitHeight: grid.implicitHeight
    implicitWidth: grid.implicitWidth
    property var labels
    property var targets
    property var backgroundColor
    property int rowsCount: Math.ceil(buttonsView.labels.length / buttonsView.columnsCount)
    property int columnsCount: Math.floor(Math.sqrt(buttonsView.labels.length))
    property int fontSize: root.height / 9
    signal buttonClicked(string strToAppend)
    signal buttonLongPressed(string strToAppend)

    Grid {
        id: grid
        columns: columnsCount
        rows: rowsCount
        columnSpacing: 0

        Repeater {
            model: buttonsView.labels

            Label {
                text: modelData
                width: root.width / columnsCount
                height: root.height / (2*rowsCount)
                topPadding: smallSpacing
                bottomPadding: smallSpacing
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                color: 'white'
                font.pixelSize: buttonsView.fontSize
                background: Rectangle {
                    color: "0123456789.C".indexOf(modelData)!=-1 ? "#bdc3c7" : buttonsView.backgroundColor
                    anchors.fill: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: buttonsView.buttonClicked(targets[index])
                    onPressAndHold: buttonsView.buttonLongPressed(targets[index])
                    hoverEnabled: true
                    onEntered: parent.background.opacity=0.75
                    onExited: parent.background.opacity=1
                    onPressed: parent.background.opacity=0.5
                    onReleased: parent.background.opacity=entered?0.75:1
                }

            }
        }
    }
}

