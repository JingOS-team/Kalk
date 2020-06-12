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
            Kirigami.Theme.colorSet: Kirigami.Theme.Window
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
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: smallSpacing
        font.pointSize: root.height / 22
        horizontalAlignment: TextInput.AlignRight
        text: ''
    }

    function save(){
        if (calculationZone.formula.text.length != 0)
        historyManager.expression = calculationZone.formula.text + " = " + calculationZone.result.text;
    }

    function calculate(formula, wantArray) {
        try {
            var Expression = formula.replace("÷", "/").replace("×", "*");
            var gaps = getParenthesis(Expression, '(') - getParenthesis(Expression, ')');
            while(gaps--){
                Expression += ')';
            }

            var res = mathJs.eval(Expression);
            if (!wantArray) {
                res = formatBigNumber(res);
            }
        } catch (exception) {
            if (debug) {
                console.log(exception.toString());
            }
            lastError = exception.toString();
            return;
        }

        res = res.substr(0,18);
        while (res.charAt(res.length -1) === '0')
            res = res.slice(0,-1);
        calculationZone.result.text = res === '' ?calculationZone.result.text : res;
    }

    function getParenthesis(text, parenthesis){
        var n = 0,
        pos = 0;

        while (true) {
            pos = text.indexOf(parenthesis, pos);
            if (pos >= 0) {
                ++n;
                pos++;
            } else break;
        }
        return n;
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
        calculationZone.formula.forceActiveFocus();
    }

    function appendToFormula(text) {
        if (text === "DEL") {
            removeFromFormula();
            calculate(calculationZone.formula.text);
            return;
        }
        var lastChar = calculationZone.formula.text.charAt(calculationZone.formula.text.length - 1);
        if ( (lastChar === '÷' || lastChar === '×' || lastChar === '+' || lastChar === '-') && (text === '÷' || text === '×' || text === '+' || text === '-'))
            return;
        calculationZone.formula.insert(calculationZone.formula.cursorPosition, text);
        calculate(calculationZone.formula.text);
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
        setFormulaText('');
        calculationZone.result.text = "";
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
