/*
 * This file is part of Kalk
 * Copyright (C) 2016 Pierre Jacquier <pierrejacquier39@gmail.com>
 *
 *               2020 Cahfofpai
 *                    Han Young <hanyoung@protonmail.com>
 *
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 */
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import org.kde.kirigami 2.13 as Kirigami

Rectangle {
    id: calculationZone
    color: Kirigami.Theme.backgroundColor
    layer.enabled: true
    z: 10

    property alias formula: formula
    property alias result: result
    property bool isNewCalculation: true

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
            font.pointSize: root.height / 20
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
            var Expression = formula.replace(/÷/g, "/").replace(/×/g, "*");
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

    function appendToFormula(text) {
        if (isNewCalculation)
            calculationZone.formula.text = "";
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
    }

    function setFormulaText(formula) {
        calculationZone.formula.text = formula;
    }

    function getFormulaText() {
        return calculationZone.formula.text;
    }

    function removeFromFormula() {
        var index = calculationZone.formula.cursorPosition;
        if (index === 0)
            return;
        calculationZone.formula.remove(index - 1, index);
    }

    function clearFormula() {
        setFormulaText('');
        calculationZone.result.text = "";
    }

    function replaceFormula(formulaStr) {
        setFormulaText(formulaStr);
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
