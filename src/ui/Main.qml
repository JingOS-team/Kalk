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
    property var history: ListModel {}

    maximumWidth: 64 * (3 + 4 + 1)
    minimumWidth: 64 * (3 + 4 + 1)
    height: 60
    onHeightChanged: updateHeight()

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
        onTriggered: historyPanel.add()
    }

    function toogleExpanded() {
        setExpanded(!root.expanded);
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

    function updateHeight() {
        if (root.expanded) {
            root.height = calculationZone.getHeight() + buttonsPanel.computedHeight;
        } else {
            root.height = calculationZone.getHeight();
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

    function calculate(formula) {
        try {
            var result = mathJs.eval(formula);
            result = formatBigNumber(result)
        } catch (exception) {
            console.log("[LOG]: Unable to calculate formula : \"" + formula + "\", math.js: " + exception.toString());
            return '';
        }

        return result;
    }
}
