/*
 * This file is part of Liri Calculator
 *
 * Copyright (C) 2016 Pierre Jacquier <pierrejacquier39@gmail.com>
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
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0
import Fluid.Material 1.0
import Qt.labs.settings 1.0
import ".."
import "../engine"

FluidWindow {
    id: root
    visible: true
    Component.onCompleted: calculationZone.retrieveFormulaFocus()

    property bool expanded: true
    property bool advanced: false
    property var history: ListModel {}

    property string lastFormula
    property string lastError

    property int normalWidth: 64 * (3 + 4 + 1)
    property int normalHeight: 60
    property int advancedWidth: 700
    property int advancedHeight: 400

    maximumWidth: root.advanced ? 1000 : normalWidth
    minimumWidth: normalWidth
    height: normalHeight
    onHeightChanged: {
        if (!advanced) {
            updateHeight()
        }
    }

    header: Item {}
    title: 'Calculator'

    Settings {
        property alias expanded: root.expanded
        property alias history: root.history
    }

    property var mathJs: mathJsLoader.item ? mathJsLoader.item.mathJs : null;

    Loader {
        id: mathJsLoader
        source: "../engine/MathJs.qml"
        asynchronous: true
        active: true
        onLoaded: {
            mathJs.config({
                number: 'BigNumber'
            });
        }
    }

    CalculationZone { id: calculationZone }

    ButtonsPanel {
        id: buttonsPanel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: calculationZone.bottom
        visible: !root.advanced
    }

    HistoryPanel {
        id: historyPanel
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: calculationZone.bottom
        height: buttonsPanel.height
    }

    Timer {
        id: addToHistoryTimer
        running: false
        interval: 1000
        onTriggered: {
            handleCalculationError();
            historyPanel.add();
        }
    }

    InfoBar {
       id: infoBar
    }

    function toogleExpanded() {
        setExpanded(!root.expanded);
        root.advanced = false;
    }

    function setExpanded(expanded) {
        root.expanded = expanded;
        updateHeight();
        calculationZone.retrieveFormulaFocus();
    }

    function toogleHistory() {
        historyPanel.visible = !historyPanel.visible;
        setExpanded(true);
    }

    function toogleAdvanced() {
        setAdvanced(!root.advanced);
        setExpanded(!root.advanced);
    }

    function setAdvanced(advanced) {
        root.advanced = advanced;
        root.width = advanced ? advancedWidth : normalWidth;
        root.height = advanced ? advancedHeight : normalHeight;
        calculationZone.formulasLines.forceActiveFocus();
        calculationZone.formulasLines.focus = true;
    }

    function updateHeight() {
        if (root.advanced) {
            return;
        }

        if (root.expanded) {
            root.height = calculationZone.getHeight() + buttonsPanel.computedHeight;
        } else {
            root.height = calculationZone.getHeight();
        }
    }

    function handleCalculationError() {
        if (lastFormula !== '' && lastError) {
            infoBar.open(lastError);
        }
    }

    /*
     * Copyright (C) 2014 Canonical Ltd
     *
     * This file is part of Ubuntu Calculator App
     *
     * Ubuntu Calculator App is free software: you can redistribute it and/or modify
     * it under the terms of the GNU General Public License version 3 as
     * published by the Free Software Foundation.
     *
     * Ubuntu Calculator App is distributed in the hope that it will be useful,
     * but WITHOUT ANY WARRANTY; without even the implied warranty of
     * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     * GNU General Public License for more details.
     *
     * You should have received a copy of the GNU General Public License
     * along with this program.  If not, see <http://www.gnu.org/licenses/>.
     */

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

    function calculate(formula, wantArray) {
//        lastFormula = formula;
        try {
            var res = mathJs.eval(formula);
            if (!wantArray) {
                res = formatBigNumber(res);
            }
//            lastError = undefined;
//            console.log(res);
        } catch (exception) {
            console.log(exception.toString());
            if (exception.toString().indexOf('Syntax') > -1) {
                lastError = exception.toString();
            }
            return '';
        }
        return res;
    }
}
