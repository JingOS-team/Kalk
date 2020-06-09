import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import ".."
import "../engine"

Rectangle {
    id: historyPanel
    color: 'white'
    property ListModel historyModel: ListModel { }

    ListView {
        id: list
        anchors.margins: smallSpacing
        anchors.fill: parent
        model: historyModel
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.NoSnap
        spacing: smallSpacing

        delegate: Label {
            width: parent.width
            font.pointSize: root.height / 9
            textFormat: Text.StyledText
            wrapMode: Text.WrapAnywhere
            text: '<font color="#757575">' + formula + ' = </font><font color="#212121">' + result + '</font>'

            MouseArea {
                anchors.fill: parent
                onClicked: calculationZone.replaceFormula(formula)
            }
        }

        ScrollIndicator.vertical: ScrollIndicator { active: true }
    }

    function add() {
        if (calculationZone.getFormulaText() !== '' && calculationZone.result.text !== '') {
            historyModel.insert(0, {
                formula: calculationZone.getFormulaText(),
                result: calculationZone.result.text,
            });
        }
    }

    function clear() {
        historyModel.clear();
        calculationZone.retrieveFormulaFocus();
    }
}
