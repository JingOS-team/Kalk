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
import org.kde.kirigami 2.13 as Kirigami
ComboBox {
    id: groupSelect
    property real fontSize: Kirigami.Theme.defaultFont.pointSize * 2
    property real popupFontSize: Kirigami.Theme.defaultFont.pointSize * 2
    property real popupWidth: groupSelect.width
    y: 3
    contentItem: Text {
        text: parent.displayText
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        font.pointSize: fontSize
        color: Kirigami.Theme.textColor
    }
    background: Rectangle {
           implicitHeight: parent.height
           color: Kirigami.Theme.backgroundColor
           radius: 5
       }
    indicator: Canvas {
            id: canvas
            x: groupSelect.width - width - groupSelect.rightPadding
            y: groupSelect.topPadding + (groupSelect.availableHeight - height) / 2
            width: 12
            height: 8
            contextType: "2d"

            Connections {
                target: groupSelect
                function onPressedChanged() { canvas.requestPaint(); }
            }

            onPaint: {
                context.reset();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = groupSelect.pressed ? Kirigami.Theme.textColor : Kirigami.Theme.activeTextColor;
                context.fill();
            }
        }
    delegate: ItemDelegate {
        width: popupWidth
        contentItem: Text {
            id: delegateText
            text:modelData;
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: popupFontSize
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
                delegateText.color = Kirigami.Theme.activeTextColor
            }
            else {
                delegateText.color = Kirigami.Theme.textColor
            }
        }
    }
    popup: Popup {
        id: groupPopup
        width: popupWidth
        implicitHeight: listview.contentHeight
        margins: 0
        background: Rectangle {
            color: Kirigami.Theme.alternateBackgroundColor
            radius: Kirigami.Theme.defaultFont.pointSize
        }
        contentItem: ListView {
            id: listview
            anchors.fill: parent
            model: groupSelect.model
            boundsBehavior: Flickable.StopAtBounds
            highlight: Rectangle {
                Kirigami.Theme.colorSet: Kirigami.Theme.Selection
                color: Kirigami.Theme.alternateBackgroundColor
            }
            spacing: 0
            highlightFollowsCurrentItem: true
            currentIndex: groupSelect.highlightedIndex
            delegate: groupSelect.delegate
        }
    }
}
