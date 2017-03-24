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

Rectangle {
    id: historyPanel
    color: 'white'

    ListView {
        id: list
        anchors.margins: Units.smallSpacing
        anchors.fill: parent
        model: root.history
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.NoSnap
        spacing: Units.smallSpacing

        delegate: Label {
            width: parent.width
            font.pointSize: root.styles.historyFontSize
            textFormat: Text.StyledText
            wrapMode: Text.WrapAnywhere
            text: '<font color="#757575">' + formula + ' = </font><font color="#212121">' + result + '</font>'

            MouseArea {
                anchors.fill: parent
                onClicked: calculationZone.replaceFormula(formula)
            }
        }

        ScrollIndicator.vertical: ScrollIndicator { active: true }
    }

    function add() {
        if (calculationZone.getFormulaText() !== '' && calculationZone.result.text !== '') {
            root.history.insert(0, {
                formula: calculationZone.getFormulaText(),
                result: calculationZone.result.text,
            });
        }
    }

    function clear() {
        root.history.clear();
        calculationZone.retrieveFormulaFocus();
    }
}
