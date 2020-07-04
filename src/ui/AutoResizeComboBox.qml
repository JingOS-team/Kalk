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
import QtQuick.Controls 2.0
import org.kde.kirigami 2.11 as Kirigami
ComboBox {
    id: groupSelect
    y: 3
    Kirigami.Theme.colorSet: Kirigami.Theme.Selection
    contentItem: Text {
        color : Kirigami.Theme.textColor
        text: parent.displayText
        font.pointSize: root.height / 48
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignLeft;
    }
    background: Rectangle {
        Kirigami.Theme.colorSet: Kirigami.Theme.Window
        color: Kirigami.Theme.alternateBackgroundColor
        height: root.height / 22
        radius: root.height / 72
        Text {
            text: "⌄"
            font.pointSize: root.height / 48
            anchors.right: parent.right
            Kirigami.Theme.colorSet: Kirigami.Theme.Selection
            color : Kirigami.Theme.textColor
        }
    }

    indicator: Rectangle { }
    delegate: ItemDelegate {
        width: groupSelect.width
        contentItem: Text {
            id: delegateText
            text:modelData;
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: root.height / 48
            //Kirigami.Theme.colorSet: Kirigami.Theme.Selection
            color: Kirigami.Theme.textColor
        }
        hoverEnabled: true
        onClicked:
        {
            groupSelect.currentIndex = index;
            listview.currentIndex = index;
            groupPopup.close();
        }
        onHoveredChanged: {
            if (hovered) {
                Kirigami.Theme.colorSet = Kirigami.Theme.Selection;
                delegateText.color = Kirigami.Theme.activeTextColor
            }
            else {
                Kirigami.Theme.colorSet = Kirigami.Theme.Window;
                delegateText.color = Kirigami.Theme.textColor
            }
        }
    }
    popup: Popup {
        id: groupPopup
        width: parent.width
        height: parent.height * parent.count
        implicitHeight: listview.contentHeight
        margins: 0
        background: Rectangle {
            color: Kirigami.Theme.alternateBackgroundColor
            radius: root.height / 72
        }
        contentItem: ListView {
            id: listview
            anchors.fill: parent
            model: groupSelect.model
            boundsBehavior: Flickable.StopAtBounds
            highlight: Rectangle {
                Kirigami.Theme.colorSet: Kirigami.Theme.Selection
                color: Kirigami.Theme.activeBackgroundColor
            }
            spacing: 0
            highlightFollowsCurrentItem: true
            currentIndex: groupSelect.highlightedIndex
            delegate: groupSelect.delegate
        }
    }
}
