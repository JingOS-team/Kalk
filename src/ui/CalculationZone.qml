import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.2
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
        opacity: root.styles.secondaryTextOpacity
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
//        Keys.onPressed: {
//            if (event.key === Qt.P) {
//                console.log('Key A was pressed');
//                root.setAdvanced(true);
//            }
//        }
    }

    Flickable {
         id: advancedView
         visible: root.advanced
         width: parent.width
         height: parent.height;
         contentWidth: formulasLines.paintedWidth
         contentHeight: formulasLines.paintedHeight
         clip: true
         flickableDirection: Flickable.VerticalFlick

         ScrollIndicator.vertical: ScrollIndicator {}

         function ensureVisible(r) {
             if (contentX >= r.x) {
                 contentX = r.x;
             } else if (contentX + width <= r.x + r.width) {
                 contentX = r.x + r.width - width;
             }

             if (contentY >= r.y) {
                 contentY = r.y;
             } else if (contentY + height <= r.y + r.height) {
                 contentY = r.y + r.height - height;
             }
         }

         Row {
             id: row
             width: parent.width
             padding: Units.smallSpacing
             spacing: Units.smallSpacing

             TextEdit {
                 id: formulasLines
                 text: ''
                 width: root.advancedWidth * 2/3
                 height: advancedView.height
                 font.pointSize: root.styles.advancedFontSize
                 opacity: root.styles.secondaryTextOpacity
                 selectByMouse: true
                 onCursorRectangleChanged: advancedView.ensureVisible(cursorRectangle)
                 onTextChanged: {
                     resultsLines.text = calculate(text.split('\n'), true).join('\n')
                 }
                 wrapMode: TextEdit.NoWrap
                 property string placeholderText: "Write your multiline calculations here..."

                 Text {
                     text: formulasLines.placeholderText
                     color: 'black'
                     opacity: root.styles.hintTextOpacity
                     font.pointSize: root.styles.advancedFontSize
                     visible: !formulasLines.text
                 }
             }

             Text {
                 id: resultsLines
                 text: ''
                 opacity: root.styles.primaryTextOpacity
                 width: root.advancedWidth * 1/3
                 font.pointSize: root.styles.advancedFontSize
                 clip: true
                 wrapMode: TextEdit.NoWrap
             }
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
            opacity: root.styles.secondaryTextOpacity
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
            opacity: root.styles.secondaryTextOpacity
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
            opacity: root.styles.secondaryTextOpacity
            onClicked: toogleExpanded()
        }
    }

    // Shouldn't be needed but the update isn't triggered otherwise
    function getHeight() {
        return calculationZone.formula.height + 4 * Units.smallSpacing + result.height;
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
