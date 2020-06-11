import QtQuick 2.0
import org.kde.kirigami 2.11 as Kirigami
import QtQuick.Controls 2.1 as Controls
Controls.SwipeView {
    anchors.fill: parent
    currentIndex: 0
    clip: true
    Item {
        ButtonsView {
            id: numericPad
            width: root.width * 0.75
            labels: ['7', '8', '9', '4', '5', '6', '1', '2', '3', '.', '0', '=']
            targets: ['7', '8', '9', '4', '5', '6', '1', '2', '3', '.', '0', '=']
            onButtonClicked: calculationZone.appendToFormula(strToAppend)
            onButtonLongPressed: {
                if (strToAppend === "DEL") {
                    calculationZone.clearFormula();
                }
            }
        }

        ButtonsView {
            id: controlPad
            width: root.width * 0.18
            anchors.left: numericPad.right
            columnsCount: 1
            fontSize: root.height / 12
            rowsCount: 5
            labels: ['C', '+', '-', 'x', '÷']
            targets: ['DEL', '+', '-', 'x', '÷']
            onButtonClicked: calculationZone.appendToFormula(strToAppend)
            onButtonLongPressed: {
                if (strToAppend === "DEL") {
                    calculationZone.clearFormula();
                }
            }
        }

        Rectangle {
            id: rightPanelIndicator
            anchors.left: controlPad.right
            anchors.right: parent.right
            Kirigami.Theme.colorSet: Kirigami.Theme.Selection
            color: Kirigami.Theme.activeTextColor
        }
    }
    Item {
        ButtonsView {
            id: fns
            anchors.right: parent.right
            fontSize: root.height / 18
            Kirigami.Theme.colorSet: Kirigami.Theme.Selection
            backgroundColor: Kirigami.Theme.backgroundColor
            labels: ['!','sqrt','exp','log','^','sin','cos','tan','asin','(','acos','atan',')','π','e']
            targets: ['!','sqrt(','exp(','log','^','sin(','cos(','tan(','asin(','(','acos(','atan(',')','pi','e']
            onButtonClicked: calculationZone.appendToFormula(strToAppend)
        }
    }
}
