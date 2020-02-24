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
// import QtQuick.Controls.Material 2.0
// import Fluid.Controls 1.0
import ".."


Rectangle {
    id: buttonsView
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    visible: !root.advanced && root.expanded
    implicitHeight: grid.implicitHeight
    implicitWidth: grid.implicitWidth
    property var labels
    property var targets
    property var backgroundColor
    property int rowsCount: Math.ceil(buttonsView.labels.length / buttonsView.columnsCount)
    property int columnsCount: Math.floor(Math.sqrt(buttonsView.labels.length))
    property int fontSize: root.height / 9
    signal buttonClicked(string strToAppend)
    signal buttonLongPressed(string strToAppend)

    Grid {
        id: grid
        columns: columnsCount
        rows: rowsCount
        columnSpacing: 0

        Repeater {
            model: buttonsView.labels

            Label {
                text: modelData
                width: root.width / columnsCount
                height: root.height / (2*rowsCount)
//                 topPadding: smallSpacing / 2
//                 bottomPadding: smallSpacing / 2
                topPadding: smallSpacing
                bottomPadding: smallSpacing
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                color: 'white'
                font.pixelSize: buttonsView.fontSize
                background: Rectangle {
                    color: "0123456789.C".indexOf(modelData)!=-1 ? "#bdc3c7" : buttonsView.backgroundColor
                    anchors.fill: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: buttonsView.buttonClicked(targets[index])
                    onPressAndHold: buttonsView.buttonLongPressed(targets[index])
                    hoverEnabled: true
                    onEntered: parent.background.opacity=0.75
                    onExited: parent.background.opacity=1
                    onPressed: parent.background.opacity=0.5
                    onReleased: parent.background.opacity=entered?0.75:1
                }

            }
        }
    }
}

