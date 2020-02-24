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
// import Fluid.Controls 1.0
import ".."
import "../engine"

Rectangle {
    id: buttonsPanel

    property alias computedHeight: mainButtonsView.height

    height: computedHeight

    Row {
        anchors.fill: parent

//         ButtonsView {
//             id: fns
//             color: "#fdbc4b"
//             labels: ['sqrt','exp','log','cos','sin','tan','acos','asin','atan','π','∞','x10^']
//             targets: ['sqrt(','exp(','log','cos(','sin(','tan(','acos(','asin(','atan(','pi','Infinity','e']
//             onButtonClicked: calculationZone.appendToFormula(strToAppend)
//         }
// 
//         ButtonsView {
//             id: mainButtonsView
//             color: "#3da"
//             labels: ['7', '8', '9', '←', '4', '5', '6', '^', '1', '2', '3', '!', '.', '0', '(', ')']
//             targets: ['7', '8', '9', 'DEL', '4', '5', '6', '^', '1', '2', '3', '!', '.', '0', '(', ')']
//             onButtonClicked: calculationZone.appendToFormula(strToAppend)
//             onButtonLongPressed: {
//                 if (strToAppend === "DEL") {
//                     calculationZone.clearFormula();
//                 }
//             }
//         }
// 
//         ButtonsView {
//             color: "#3daee9"
//             labels: ['+', '-', '×', '÷']
//             targets: ['+', '-', '*', '/']
//             onButtonClicked: calculationZone.appendToFormula(strToAppend)
//         }
        
        ButtonsView {
            id: mainButtonsView
            color: "#3da"
            labels: ['7', '8', '9', '÷', '4', '5', '6', 'x', '1', '2', '3', '-', '.', '0', 'C', '+']
            targets: ['7', '8', '9', '/', '4', '5', '6', '*', '1', '2', '3', '-', '.', '0', 'DEL', '+']
            onButtonClicked: calculationZone.appendToFormula(strToAppend)
            onButtonLongPressed: {
                if (strToAppend === "DEL") {
                    calculationZone.clearFormula();
                }
            }
        }
        
        ButtonsView {
            id: fns
            color: "#fdbc4b"
            opacity: 0
            labels: ['sqrt','exp','log','cos','sin','tan','acos','asin','atan','π','∞','x10^']
            targets: ['sqrt(','exp(','log(','cos(','sin(','tan(','acos(','asin(','atan(','pi','Infinity','e']
            onButtonClicked: calculationZone.appendToFormula(strToAppend)
        }


//         ButtonsView {
//             color: "#3daee9"
//             labels: ['+', '-', '×', '']
//             targets: ['+', '-', '*', '/']
//             onButtonClicked: calculationZone.appendToFormula(strToAppend)
//         }
    }
}
