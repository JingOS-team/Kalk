import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import org.kde.kirigami 2.11 as Kirigami
Column {
    width: root.width
    padding: smallSpacing
    spacing: smallSpacing

    Row {
        width: parent.width
        height: formulaEdit.height
        spacing: smallSpacing

        TextEdit {
            id: formulaEdit
            text: formula
            width: (root.width - 3 * smallSpacing) * 2/3
            font.pointSize: root.height / 9
            opacity: 1
            selectByMouse: true
            wrapMode: TextEdit.WrapAnywhere
            Text {
                id: formulaResult
                text: hasError ? qsTr('Error') : formula === '' ? '' : result
                color: hasError ? 'red' : 'black'
                height: formulaEdit.height
                opacity: hasError ? root.styles.hintTextOpacity : root.styles.primaryTextOpacity
                width: (root.width - 3 * smallSpacing) * 1/3
                font.pointSize: root.height / 9
                horizontalAlignment: Text.AlignRight
                clip: true
                wrapMode: TextEdit.NoWrap
                font.italic: hasError
                verticalAlignment: Qt.AlignBottom

                property bool hasError: result === 'undefined' && formula !== ''

                MouseArea {
                    visible: parent.hasError
                    enabled: parent.hasError
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: snackBar.open(root.lastError)
                }
            }
        }

        Rectangle {
            width: root.width - 2 * smallSpacing
            height: 1
            color: formulaResult.hasError ? 'red' : 'black'
            opacity: 0.1
        }
    }
}
