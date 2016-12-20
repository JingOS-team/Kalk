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
    id: buttonsPanel
    height: grid.height
    width: grid.width
    property var labels
    property var targets
    property int rowsCount: 4
    property int fontSize: 17
    signal buttonClicked(string strToAppend)

    Grid {
        id: grid
        columns: getColumnsCount()
        rows: 4
        topPadding: Units.smallSpacing
        bottomPadding: Units.smallSpacing
        rowSpacing: Units.smallSpacing
        columnSpacing: 0

        Repeater {
            model: buttonsPanel.labels

            Label {
                text: modelData
                width: 64
                topPadding: Units.smallSpacing / 2
                bottomPadding: Units.smallSpacing / 2
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                color: 'white'
                font.pixelSize: buttonsPanel.fontSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: buttonsPanel.buttonClicked(targets[index])
                }

            }
        }
    }

    function getColumnsCount() {
        if (buttonsPanel.labels.length % buttonsPanel.rowsCount === 0) {
            return buttonsPanel.labels.length / buttonsPanel.rowsCount;
        }
        return Math.floor(buttonsPanel.labels.length / buttonsPanel.rowsCount) + 1;
    }
}
