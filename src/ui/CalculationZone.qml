import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0
import Fluid.Material 1.0

Rectangle {
    id: calculationZone
    color: 'white'
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    layer.enabled: true
    z: 10
    layer.effect: ElevationEffect { elevation: 2 }

    property alias formula: formula
    property alias result: result
    property alias formulasLines: formulasLines

    height: root.advanced ? root.height : getHeight()

    TextInput {
        id: formula
        color: 'black'
        opacity: 0.54
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: actions.left
        visible: !root.advanced
        anchors.margins: Units.smallSpacing
        font.pixelSize: 20
        wrapMode: TextInput.WrapAnywhere
        selectByMouse: true
        onHeightChanged: updateHeight()
        onTextChanged: {
            addToHistoryTimer.restart();
            result.text = calculate(text);
        }
    }

    Flickable {
        visible: root.advanced
        width: parent.width
        height: parent.width
        contentWidth: parent.width
        contentHeight: formulasLines.implicitHeight
//        boundsBehavior: Flickable.StopAtBounds
        Row {
            id: row
            width: parent.width
            padding: Units.smallSpacing
            spacing: Units.smallSpacing

            TextEdit {
                id: formulasLines
                text: ''
                width: parent.width * 2/3
                font.pointSize: 18
                opacity: 0.54
                selectByMouse: true
                clip: true
                onTextChanged: {
                    resultsLines.text = calculate(text.split('\n'), true).join('\n')
                }
                wrapMode: TextEdit.NoWrap
                property string placeholderText: "Write your multiline calculations here..."

                Text {
                    text: formulasLines.placeholderText
                    color: 'black'
                    opacity: 0.38
                    font.pointSize: 18
                    visible: !formulasLines.text
                }
            }

            Text {
                id: resultsLines
                text: ''
                opacity: 0.87
                width: parent.width * 1/3
                font.pointSize: 18
                clip: true
                wrapMode: TextEdit.NoWrap
            }
        }
    }

    DisplayLabel {
        id: result
        opacity: 0.87
        visible: !root.advanced
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: Units.smallSpacing
        horizontalAlignment: TextInput.AlignRight
        level: 1
        text: ''
    }

    Row {
        id: actions
        anchors.top: parent.top
        anchors.right: parent.right

        IconButton {
            id: advancedButton
            implicitHeight: 40
            implicitWidth: 40
            iconSize: 20
            iconName: root.advanced ? 'navigation/close' : 'action/list'
            iconColor: 'black'
            opacity: 0.54
            onClicked: toogleAdvanced()
        }

        IconButton {
            id: historyButton
            implicitHeight: 40
            implicitWidth: 40
            iconSize: 20
            visible: !root.advanced
            iconName: historyPanel.visible ? 'communication/dialpad' : 'action/history'
            iconColor: 'black'
            opacity: 0.54
            onClicked: toogleHistory()
        }

        IconButton {
            id: expandButton
            implicitHeight: 40
            implicitWidth: 40
            iconSize: 20
            visible: !root.advanced
            iconName: root.expanded ? 'navigation/expand_less' : 'navigation/expand_more'
            iconColor: 'black'
            opacity: 0.54
            onClicked: toogleExpanded()
        }

//            IconButton {
//                id: menuButton
//                implicitHeight: 40
//                implicitWidth: 40
//                iconSize: 20
//                iconName: 'navigation/menu'
//                iconColor: 'black'
//                opacity: 0.54
//            }
    }


    // Shouldn't be needed but the update isn't triggered otherwise
    function getHeight() {
        return calculationZone.formula.height + 4 * Units.smallSpacing + result.height;
    }

    function retrieveFormulaFocus() {
        calculationZone.formula.forceActiveFocus();
    }

    function appendToFormula(text) {
        if (text === "DEL") {
            removeFromFormula();
            return;
        }

        setFormulaText(getFormulaText() + text);
        retrieveFormulaFocus();
    }

    function setFormulaText(formula) {
        calculationZone.formula.text = formula;
    }

    function getFormulaText() {
        return calculationZone.formula.text;
    }

    function removeFromFormula() {
        setFormulaText(getFormulaText().slice(0, -1));
        retrieveFormulaFocus();
    }

    function clearFormula() {
        historyPanel.add();
        setFormulaText('');
        retrieveFormulaFocus();
    }

    function replaceFormula(formulaStr) {
        setFormulaText(formulaStr);
        retrieveFormulaFocus();
    }
}
