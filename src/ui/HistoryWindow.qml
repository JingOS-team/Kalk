import QtQuick 2.0
import QtQuick.Controls 2.0
import Fluid.Controls 1.0
import ".."

FluidWindow {
    id: window
    width: 300
    visible: false
    signal calculationSelected(string formulaStr)
    signal historyCleared()

//    onActiveFocusItemChanged: {
//        if (activeFocusItem == null) {
//            hide();
//        }
//    }

    IconButton {
        id: deleteButton
        implicitHeight: 40
        implicitWidth: 40
        z: 10
        opacity: 0.54
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        iconSize: 20
        iconName: 'content/delete_sweep'
        iconColor: 'black'
        onClicked: clearHistory()

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }
    }

    ListView {
        id: list
        anchors.fill: parent
        model: root.history
        header: Subheader {
            text: "Calculations history"
        }
        delegate: ListItem {
            text: modelData.formula + ' → ' + modelData.result
            onClicked: select(modelData.formula)
        }

        ScrollIndicator.vertical: ScrollIndicator {}
    }

    function open(history) {
        list.model = history;
        window.showNormal();
    }

    function select(formula) {
        calculationSelected(formula);
        window.hide();
    }

    function clearHistory() {
        list.model = [];
        historyCleared();
    }
}
