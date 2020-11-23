/*
 *   Copyright 2014 Aaron Seigo <aseigo@kde.org>
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of

 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.2 as Controls

import org.kde.kirigami 2.2 as Kirigami


Item {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    signal clicked(string text)
    signal longClicked()

    property string text
    property alias fontSize: main.font.pointSize
    property alias backgroundColor: keyRect.color
    property alias textColor: main.color
    property string display: text
    property bool special: false
    
    property color buttonColor: Qt.lighter(Kirigami.Theme.backgroundColor, 1.3)
    property color buttonPressedColor: Qt.darker(Kirigami.Theme.backgroundColor, 1.08)
    property color buttonTextColor: Kirigami.Theme.textColor
    property color dropShadowColor: Qt.darker(Kirigami.Theme.backgroundColor, 1.15)

    Rectangle {
        id: keyRect
        anchors.fill: parent
        anchors.margins: Kirigami.Units.smallSpacing * 0.5
        radius: Kirigami.Units.smallSpacing
        color: root.buttonColor
        
        Controls.AbstractButton {
            anchors.fill: parent
            onPressedChanged: {
                if (pressed) {
                    parent.color = root.buttonPressedColor;
                } else {
                    parent.color = root.buttonColor;
                }
            }

            onClicked: root.clicked(parent.text)
            onPressAndHold: root.longClicked()
        }
    }

    DropShadow {
        anchors.fill: keyRect
        source: keyRect
        cached: true
        horizontalOffset: 0
        verticalOffset: 1
        radius: 4
        samples: 6
        color: root.dropShadowColor
    }

    Controls.Label {
        id: main
        anchors.centerIn: keyRect

        font.pointSize: Math.min(keyRect.width * 0.4, Kirigami.Theme.defaultFont.pointSize * 2)
        text: root.display
        opacity: special ? 0.4 : 1.0
        horizontalAlignment: Text.AlignHCenter
        color: root.buttonTextColor
    }
}
