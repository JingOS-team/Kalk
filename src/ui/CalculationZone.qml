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

    Rectangle {
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
                ToolTip.text: "Help"
                onClicked: Qt.openUrlExternally('http://mathjs.org/docs/expressions/syntax.html')
            }

            NavButton {
                id: openButton
                visible: root.advanced
                iconName: 'file/folder_open'
                ToolTip.text: "Open file (Ctrl+O)"
                onClicked: openFile()
            }

            NavButton {
                id: saveButton
                enabled: formulasLines.text !== ''
                visible: root.advanced
                iconName: 'content/save'
                opacity: enabled ? root.styles.secondaryTextOpacity : root.styles.hintTextOpacity
                ToolTip.text: "Save file (Ctrl+S)"
                onClicked: saveFile()
            }

            NavButton {
                id: advancedButton
                visible: !root.advanced
                iconName: 'action/list'
                ToolTip.text: "Advanced mode (Ctrl+D)"
                onClicked: setAdvanced(true)
            }

            NavButton {
                id: closeButton
                visible: root.advanced
                iconName: 'navigation/close'
                ToolTip.text: "Close advanced mode"
                onClicked: closeFile()
            }

            NavButton {
                id: historyButton
                visible: !root.advanced
                iconName: historyPanel.visible ? 'communication/dialpad' : 'action/history'
                ToolTip.text: "Toggle history (Ctrl+H)"
                onClicked: toogleHistory()
            }

            NavButton {
                id: expandButton
                visible: !root.advanced
                iconName: root.expanded ? 'navigation/expand_less' : 'navigation/expand_more'
                ToolTip.text: "Toggle expanded (Ctrl+E)"
                onClicked: toogleExpanded()
            }
        }
    }

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
         anchors.fill: parent
         anchors.topMargin: 40
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
                 width: (root.advancedWidth - 3 * Units.smallSpacing) * 2/3
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
                     opacity: root.styles.hintTextOpacity * 1/root.styles.secondaryTextOpacity
                     font.pointSize: root.styles.advancedFontSize
                     visible: !formulasLines.text
                 }
             }

             Text {
                 id: resultsLines
                 text: ''
                 opacity: !formulasLines.text ? root.styles.hintTextOpacity : root.styles.primaryTextOpacity
                 width: (root.advancedWidth - 3 * Units.smallSpacing) * 1/3
                 font.pointSize: root.styles.advancedFontSize
                 horizontalAlignment: Text.AlignRight
                 clip: true
                 wrapMode: TextEdit.NoWrap
                 visible: !!formulasLines.text
             }

             Text {
                 text: '... to get results'
                 opacity: root.styles.hintTextOpacity
                 width: (root.advancedWidth - 3 * Units.smallSpacing) * 1/3
                 font.pointSize: root.styles.advancedFontSize
                 horizontalAlignment: Text.AlignRight
                 visible: !formulasLines.text
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
