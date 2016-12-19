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
import ".."
import "../engine"

FluidWindow {
    id: root
    visible: true
    Component.onCompleted: formula.forceActiveFocus()

    property bool expanded: true

    maximumWidth: 64 * (3 + 4 + 1)
    minimumWidth: 64 * (3 + 4 + 1)
    height: 296

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

    Rectangle {
        id: calculationZone
        color: 'white'
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: getCalculationZoneHeight()
        layer.enabled: true
        layer.effect: ElevationEffect { elevation: 2 }

        TextInput {
            id: formula
            color: 'black'
            opacity: 0.54
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: actions.left
            anchors.margins: Units.smallSpacing
            font.pixelSize: 20
            onTextChanged: calculationResult.text = calculate(text)
            wrapMode: TextInput.WrapAnywhere
            onHeightChanged: updateHeight()
        }

        DisplayLabel {
            id: calculationResult
            opacity: 0.87
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
                id: trimButton
                implicitHeight: 40
                implicitWidth: 40
                iconSize: 20
                iconName: 'navigation/arrow_back'
                iconColor: 'black'
                opacity: formula.text !== '' ? 0.54 : 0
                onClicked: removeFromFormula()

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }
                }
            }

            IconButton {
                id: deleteButton
                implicitHeight: 40
                implicitWidth: 40
                iconSize: 20
                iconName: 'action/delete'
                iconColor: 'black'
                opacity: formula.text !== '' ? 0.54 : 0
                onClicked: clearFormula()

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }
                }
            }

            IconButton {
                id: expandButton
                implicitHeight: 40
                implicitWidth: 40
                iconSize: 20
                iconName: root.expanded ? 'navigation/expand_less' : 'navigation/expand_more'
                iconColor: 'black'
                opacity: 0.54
                onClicked: toogleExpanded()
            }

            IconButton {
                id: menuButton
                implicitHeight: 40
                implicitWidth: 40
                iconSize: 20
                iconName: 'navigation/menu'
                iconColor: 'black'
                opacity: 0.54
            }
        }
    }

    Rectangle {
        id: calculationButtons
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: calculationZone.bottom
        height: fns.height

        Row {
            anchors.fill: parent

            ButtonsPanel {
                id: fns
                color: Material.color(Material.Pink, Material.Shade500)
                labels: ['sqrt','pow','!','cos','sin','tan','acos','asin','atan','exp','log','pi']
                targets: ['sqrt(','pow(','!','cos(','sin(','tan(','acos(','asin(','atan(','exp(','log(','pi']
                onButtonClicked: appendToFormula(strToAppend)
            }

            ButtonsPanel {
                color: Material.color(Material.Grey, Material.Shade900)
                labels: ['7', '8', '9', 'X', '4', '5', '6', '→X', '1', '2', '3', '(', '0', '.', ',', ')']
                targets: ['7', '8', '9', 'X', '4', '5', '6', '->X', '1', '2', '3', '(', '0', '.', ',', ')']
                onButtonClicked: appendToFormula(strToAppend)
            }

            ButtonsPanel {
                color: Material.color(Material.Grey, Material.Shade800)
                labels: ['+', '-', '×', '÷']
                targets: ['+', '-', '*', '/']
                onButtonClicked: appendToFormula(strToAppend)
            }
        }
    }

    function appendToFormula(text) {
        formula.text += text;
        formula.forceActiveFocus();
    }

    function removeFromFormula() {
        formula.text = formula.text.slice(0, -1);
        formula.forceActiveFocus();
    }

    function clearFormula() {
        formula.text = '';
        formula.forceActiveFocus();
    }

    function toogleExpanded() {
        root.expanded = !root.expanded;
        updateHeight();
    }

    function updateHeight() {
        if (root.expanded) {
            root.height = getCalculationZoneHeight() + fns.height;
        } else {
            root.height = getCalculationZoneHeight();
        }
    }

    function getCalculationZoneHeight() {
        return formula.height + 4 * Units.smallSpacing + calculationResult.height;
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
        } catch(exception) {
            console.log("[LOG]: Unable to calculate formula : \"" + formula + "\", math.js: " + exception.toString());
            return '';
        }

        return result;
    }
}
