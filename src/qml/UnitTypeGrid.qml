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
    ListView {
        id: typeView
        anchors.fill: parent
        topMargin: Kirigami.Units.gridUnit
        model: typeModel
        spacing: Kirigami.Units.gridUnit
        anchors.right: parent.right
        delegate: Kirigami.AbstractCard {
            id: listItem
            width: root.inPortrait ? parent.width * 0.9 : (parent.width - drawer.width) * 0.9
            anchors.right: parent.right
            anchors.rightMargin: root.inPortrait ? parent.width * 0.05 : (parent.width - drawer.width) * 0.05
            contentItem: Text {
                text: name
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
            }
            MouseArea {
                id: mouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    drawer.inputText = "";
                    drawer.outputText = "0";
                    typeModel.currentIndex(index);
                    drawer.from.currentIndex = 0;
                    drawer.to.currentIndex = 1;
                    drawer.header = modelData;
                    drawer.open();
                }
                onEntered: {
                    listItem.highlighted = true;
                }
                onExited: {
                    listItem.highlighted = false;
                }
            }
        }
    }
    UnitConversionDrawer {
        id: drawer
        parent: parent
        dragMargin: 0
        y: Kirigami.Settings.isMobile ? 0 : parent.height - typeView.height
        height: parent.height
        width: root.inPortrait ? parent.width : parent.width / 2
        interactive: root.inPortrait
        position: root.inPortrait ? 0 : 1
        visible: !root.inPortrait
        modal: root.inPortrait
    }
}
