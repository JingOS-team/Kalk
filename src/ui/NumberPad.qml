/*
 * This file is part of Kalk
 *
 * Copyright (C) 2020 Han Young <hanyoung@protonmail.com>
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
import QtQuick 2.0
import org.kde.kirigami 2.11 as Kirigami
import QtQuick.Controls 2.1 as Controls
import QtQuick.Layouts 1.1
Controls.SwipeView {
    currentIndex: 0
    clip: true
    Rectangle{
        Kirigami.Theme.colorSet: Kirigami.Theme.Selection
        color: Kirigami.Theme.backgroundColor
        ButtonsView {
            id: numericPad
            Kirigami.Theme.colorSet: Kirigami.Theme.Selection
            width: root.width * 0.75
            labels: ['7', '8', '9', '4', '5', '6', '1', '2', '3', '.', '0', '=']
            targets: ['7', '8', '9', '4', '5', '6', '1', '2', '3', '.', '0', '=']
            onButtonClicked: {
                if (strToAppend === '='){
                    calculationZone.save();
                    calculationZone.isNewCalculation = true;
                }
                else {
                    calculationZone.appendToFormula(strToAppend)
                    calculationZone.isNewCalculation = false;
                }
            }
        }

        ButtonsView {
            id: controlPad
            Kirigami.Theme.colorSet: Kirigami.Theme.Selection
            width: root.width * 0.18
            anchors.left: numericPad.right
            columnsCount: 1
            fontSize: root.height / 15
            rowsCount: 5
            labels: ['C', '+', '−', '×', '÷']
            targets: ['DEL', '+', '-', '×', '÷']
            onButtonClicked: calculationZone.appendToFormula(strToAppend)
            onButtonLongPressed: {
                if (strToAppend === "DEL") {
                    calculationZone.clearFormula();
                }
            }
        }
    }

    Item {
        ButtonsView {
            id: fns
            anchors.right: parent.right
            fontSize: root.height / 18
            Kirigami.Theme.colorSet: Kirigami.Theme.Selection
            backgroundColor: Kirigami.Theme.backgroundColor
            labels: ['!','sqrt','exp','ln','^','sin','cos','tan','asin','(','acos','atan',')','π','e']
            targets: ['!','sqrt(','exp(','log(','^','sin(','cos(','tan(','asin(','(','acos(','atan(',')','pi','e']
            onButtonClicked: calculationZone.appendToFormula(strToAppend)
        }
    }
}
