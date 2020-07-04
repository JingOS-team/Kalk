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
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import ".."
import org.kde.kirigami 2.11 as Kirigami

Rectangle {
    id: buttonsView
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    height: parent.height
    property var labels
    property var targets
    property int rowsCount: Math.ceil(buttonsView.labels.length / buttonsView.columnsCount)
    property int columnsCount: Math.floor(Math.sqrt(buttonsView.labels.length))
    property int fontSize: root.height / 12
    property color backgroundColor: Kirigami.Theme.alternateBackgroundColor
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
                width: buttonsView.width / columnsCount
                height: buttonsView.height / rowsCount
                topPadding: smallSpacing
                bottomPadding: smallSpacing
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Kirigami.Theme.colorSet: Kirigami.Theme.Window
                color: Kirigami.Theme.textColor
                font.pointSize: buttonsView.fontSize
                background: Rectangle {
                    Kirigami.Theme.colorSet: Kirigami.Theme.Window
                    color: "0123456789.=".indexOf(modelData)!=-1 ? Kirigami.Theme.activeBackgroundColor : backgroundColor
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

