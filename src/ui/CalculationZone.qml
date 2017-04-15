import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0
import Fluid.Material 1.0

Rectangle {
    id: calculationZone
    color: 'white'
    layer.enabled: true
    z: 10
    layer.effect: ElevationEffect { elevation: 2 }

    property alias formula: formula
    property alias result: result
    property alias calculationsRepeater: calculationsRepeater

    height: root.advanced ? root.height : getHeight()

    Rectangle {
        id: advancedToolbar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40
        layer.enabled: root.advanced
        layer.effect: ElevationEffect {
            elevation: advancedView.contentY < 5 ? 0 : 2

            Behavior on elevation {
                NumberAnimation { duration: 400 }
            }
        }

        Text {
            id: filename
            visible: root.advanced
            text: getDisplayableFileName()
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: Units.smallSpacing
            font.pointSize: 12
            opacity: root.styles.secondaryTextOpacity
        }

        Row {
            id: actions
            anchors.top: parent.top
            anchors.right: parent.right

            NavButton {
                id: helpButton
                visible: root.advanced
                iconName: 'action/info_outline'
                ToolTip.text: qsTr('Help')
                onClicked: Qt.openUrlExternally('http://mathjs.org/docs/expressions/syntax.html')
            }

            NavButton {
                id: openButton
                visible: root.advanced
                iconName: 'file/folder_open'
                ToolTip.text: qsTr('Open file') + ' (Ctrl+O)'
                onClicked: openFile()
            }

            NavButton {
                id: saveButton
                enabled: document.edited || document.unsaved
                visible: root.advanced
                iconName: 'content/save'
                opacity: enabled ? root.styles.secondaryTextOpacity : root.styles.hintTextOpacity
                ToolTip.text: qsTr('Save file') + ' (Ctrl+S)'
                onClicked: saveFile()
            }

            NavButton {
                id: advancedButton
                visible: !root.advanced
                iconName: 'action/list'
                ToolTip.text: qsTr('Advanced mode') + ' (Ctrl+D)'
                onClicked: setAdvanced(true)
            }

            NavButton {
                id: closeButton
                visible: root.advanced
                iconName: 'navigation/close'
                ToolTip.text: qsTr('Close advanced mode')
                onClicked: closeFile()
            }

            NavButton {
                id: historyButton
                visible: !root.advanced
                iconName: historyPanel.visible ? 'communication/dialpad' : 'action/history'
                ToolTip.text: qsTr('Toggle history') + ' (Ctrl+H)'
                onClicked: toogleHistory()
            }

            NavButton {
                id: expandButton
                visible: !root.advanced
                iconName: root.expanded ? 'navigation/expand_less' : 'navigation/expand_more'
                ToolTip.text: qsTr('Toggle expanded') + ' (Ctrl+E)'
                onClicked: toogleExpanded()
            }
        }
    }

    Flickable {
        id: advancedView
        visible: root.advanced
        y: advancedToolbar.height
        height: parent.height - y
        clip: true
        width: root.advancedWidth
        contentHeight: contentColumn.height
        contentWidth: contentColumn.width
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        Column {
            id: contentColumn
            spacing: Units.smallSpacing
            width: parent.width

            property Transition transition: Transition {
                PropertyAnimation { properties: "x,opacity"; easing.type: Easing.InOutQuad }
            }

            move: transition
            add: transition

            Repeater {
                id: calculationsRepeater
                width: parent.width

                model: ListModel {
                    ListElement {
                        formula: ''
                        result: ''
                    }
                }

                delegate: CalculationLine {}
            }
        }
    }

    Flickable {
        id: formulaFlick
        anchors.top: parent.top
        anchors.left: parent.left
        clip: true
        anchors.bottom: result.top
        width: root.width - actions.width
        visible: !root.advanced
        contentHeight: formula.implicitHeight
        flickableDirection: Flickable.VerticalFlick
        ScrollIndicator.vertical: ScrollIndicator {}

        function ensureVisible(r) {
            if (contentY >= r.y) {
                contentY = r.y;
            }
            else if (contentY + height <= r.y + r.height) {
                contentY = r.y + r.height - height;
            }
        }

        TextInput {
            id: formula
            color: 'black'
            opacity: root.styles.secondaryTextOpacity
            padding: Units.smallSpacing
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: 20
            wrapMode: TextInput.WrapAnywhere
            selectByMouse: true
            onTextChanged: {
                addToHistoryTimer.restart();
                result.text = calculate(text);
            }
            onCursorRectangleChanged: formulaFlick.ensureVisible(cursorRectangle)
        }
    }

    DisplayLabel {
        id: result
        opacity: root.styles.primaryTextOpacity
        visible: !root.advanced
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: Units.smallSpacing
        horizontalAlignment: TextInput.AlignRight
        level: 1
        text: ''
    }

    // Shouldn't be needed but the update isn't triggered otherwise
    function getHeight() {
        return calculationZone.formula.height + 4 * Units.smallSpacing + result.height;
    }

    function loadFileContent(text) {
        var formulas = text.split('\n');
        calculationsRepeater.model.clear();
        for (var i=0; i<formulas.length; i++) {
            calculationsRepeater.model.append({formula: formulas[i], result: ''});
        }
    }

    function syncTextDocument() {
        var text = '';
        for (var i=0; i<calculationsRepeater.model.count; i++) {
            text += calculationsRepeater.model.get(i).formula;
            if (i < calculationsRepeater.model.count - 1) {
                text += '\n';
            }
        }
        documentText.text = text;
        document.setEdited(true);
    }

    function retrieveFormulaFocus() {
        if (advanced) {
            calculationZone.formulasLines.forceActiveFocus();
        } else {
            calculationZone.formula.forceActiveFocus();
        }
    }

    function appendToFormula(text) {
        if (text === "DEL") {
            removeFromFormula();
            return;
        }

        calculationZone.formula.insert(calculationZone.formula.cursorPosition, text);
        retrieveFormulaFocus();
    }

    function setFormulaText(formula) {
        calculationZone.formula.text = formula;
    }

    function getFormulaText() {
        return calculationZone.formula.text;
    }

    function removeFromFormula() {
        var index = calculationZone.formula.cursorPosition;
        calculationZone.formula.remove(index - 1, index);
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

    function setFocusAt(index) {
        calculationsRepeater.itemAt(index).children[0].children[0].forceActiveFocus();
    }
}
