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
            font.pointSize: root.height / 15
            wrapMode: TextInput.WrapAnywhere
            selectByMouse: true
            onTextChanged: {
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
        font.pointSize: root.height / 22
        horizontalAlignment: TextInput.AlignRight
        text: ''
    }
    function loadFileContent(text) {
        var formulas = text.split('\n');
        calculationsRepeater.model.clear();
        for (var i=0; i<formulas.length; i++) {
            calculationsRepeater.model.append({formula: formulas[i], result: ''});
        }
    }

    function calculate(formula, wantArray) {
        try {
            var res = mathJs.eval(formula);
            if (!wantArray) {
                res = formatBigNumber(res);
            }
        } catch (exception) {
            if (debug) {
                console.log(exception.toString());
            }
            lastError = exception.toString();
            return '';
        }
        return res;
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
        var lastChar = calculationZone.formula.text.charAt(calculationZone.formula.text.length - 1);
        if ( (lastChar === '÷' || lastChar === 'x' || lastChar === '+' || lastChar === '-') && (text === '÷' || text === 'x' || text === '+' || text === '-'))
            return;
        calculationZone.formula.insert(calculationZone.formula.cursorPosition, text);
        var Expression = calculationZone.formula.text.replace("÷", "/").replace("x", "*");
        var res = calculate(Expression);
        if (res.substr(res.length - 6) === "000004"){ // get ride of 0.300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004
            res = res.slice(0,-1);
            while (res.charAt(res.length -1) === '0')
                res = res.slice(0,-1);
        }

        calculationZone.result.text = res === '' ?calculationZone.result.text : res;
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

    function formatBigNumber(bigNumberToFormat) {
        // Maximum length of the result number
        var NUMBER_LENGTH_LIMIT = 14;

        if (bigNumberToFormat.toString().length > NUMBER_LENGTH_LIMIT) {
            var resultLength = mathJs.format(bigNumberToFormat, {exponential: {lower: 1e-10, upper: 1e10},
                                                 precision: NUMBER_LENGTH_LIMIT}).toString().length;

            return mathJs.format(bigNumberToFormat, {exponential: {lower: 1e-10, upper: 1e10},
                                     precision: (NUMBER_LENGTH_LIMIT - resultLength + NUMBER_LENGTH_LIMIT)}).toString();
        }
        return bigNumberToFormat.toString()
    }
}
