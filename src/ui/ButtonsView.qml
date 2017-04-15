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


Rectangle {
    id: buttonsView
    implicitHeight: grid.implicitHeight
    implicitWidth: grid.implicitWidth
    property var labels
    property var targets
    property int rowsCount: 4
    property int fontSize: 17
    signal buttonClicked(string strToAppend)
    signal buttonLongPressed(string strToAppend)

    Grid {
        id: grid
        columns: getColumnsCount()
        rows: 4
        topPadding: Units.smallSpacing
        bottomPadding: Units.smallSpacing
        rowSpacing: Units.smallSpacing
        columnSpacing: 0

        Repeater {
            model: buttonsView.labels

            Label {
                text: modelData
                width: root.width / 8
                topPadding: Units.smallSpacing / 2
                bottomPadding: Units.smallSpacing / 2
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                color: 'white'
                font.pixelSize: buttonsView.fontSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: buttonsView.buttonClicked(targets[index])
                    onPressAndHold: buttonsView.buttonLongPressed(targets[index])
                }

            }
        }
    }

    function getColumnsCount() {
        return Math.ceil(buttonsView.labels.length / buttonsView.rowsCount);
    }
}
