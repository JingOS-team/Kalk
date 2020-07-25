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
import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.13 as Kirigami

Kirigami.ScrollablePage {
    title: i18n("Units Converter")
    id: root
    ListView {
        id: typeView
        anchors.fill: parent
        topMargin: Kirigami.Units.gridUnit
        model: typeModel
        spacing: Kirigami.Units.gridUnit
        anchors.horizontalCenter: parent.horizontalCenter
        delegate: Rectangle {
            color: Kirigami.Theme.highlightColor
            width: root.width * 0.8
            height: Kirigami.Units.gridUnit * 3
            radius: 5
            opacity: mouse.pressed ? 0.4 : 1
            anchors.horizontalCenter: parent.horizontalCenter
            Behavior on opacity {
                OpacityAnimator {
                    duration: Kirigami.Units.longDuration
                    easing.type: Easing.InOutQuad
                }
            }
            Text {
                text: name
                anchors.centerIn: parent
                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
                color: Kirigami.Theme.textColor
            }
            MouseArea {
                id: mouse
                anchors.fill: parent
                onClicked: {
                    drawer.inputText = "";
                    drawer.outputText = "0";
                    typeModel.currentIndex(index);
                    drawer.from.currentIndex = 0;
                    drawer.to.currentIndex = 1;
                    drawer.header = modelData;
                    drawer.open();
                }
            }
        }
    }
    UnitConversionDrawer {
        id: drawer
        y: Kirigami.Settings.isMobile ? 0 : parent.height - typeView.height
        height: root.height
        width: parent.width * 0.9
    }
}
