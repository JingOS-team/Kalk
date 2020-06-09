import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import org.kde.kirigami 2.4 as Kirigami

Rectangle {
    id: calculationZone
    color: Kirigami.Theme.backgroundColor
    layer.enabled: true
    z: 10

    property alias formula: formula
    property alias result: result

    height: root.advanced ? root.height : getHeight()

//    Rectangle {
//        id: advancedToolbar
//        anchors.top: parent.top
//        anchors.left: parent.left
//        anchors.right: parent.right
//        height: 40
//        layer.enabled: root.advanced

//        Text {
//            id: filename
//            visible: root.advanced
//            text: getDisplayableFileName()
//            anchors.top: parent.top
//            anchors.left: parent.left
//            anchors.margins: smallSpacing
//            font.pointSize: 12
//            opacity: 1
//        }
//    }

    Flickable {
        id: formulaFlick
        anchors.top: parent.top
        anchors.left: parent.left
        clip: true
        anchors.bottom: result.top
        width: root.width
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
            color: Kirigami.Theme.focusColor
            opacity: 1
            padding: smallSpacing
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            font.pointSize: root.height / 9
            wrapMode: TextInput.WrapAnywhere
            selectByMouse: true
            onTextChanged: {
                addToHistoryTimer.restart();
                result.text = calculate(text);
            }
            onCursorRectangleChanged: formulaFlick.ensureVisible(cursorRectangle)
        }
    }

    Label {
        id: result
        opacity: 0.5
        color: Kirigami.Theme.focusColor
        visible: !root.advanced
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: smallSpacing
        font.pointSize: root.height / 15
        horizontalAlignment: TextInput.AlignRight
        text: ''
    }

    // Shouldn't be needed but the update isn't triggered otherwise
    function getHeight() {
        return calculationZone.formula.height + result.height;
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
