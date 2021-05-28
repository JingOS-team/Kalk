

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
import QtQuick.Controls 2.2 as Controls

import org.kde.kirigami 2.2 as Kirigami

Item {
    id: root

    property int iWidth: /*200 * appWindow.officalScale*/ appWindow.width / 64 * 7
    property int iHeight: /*185 * appWindow.officalScale*/ appWindow.height * 3 / 5 / 4
    width: iWidth
    height: iHeight

     Layout.fillWidth: true
     Layout.fillHeight: true
     signal clicked(string text)
     signal pressAndHold(string text)
     signal release(string text)

    property string text
    property string backgroundColor: "#ff0000"
    property string pressedColor: "#1a000000"
    property string hoverColor: "#0D000000"
    property alias textColor: main.color
    property alias textSize: main.font.pointSize
    property string display
    property bool special: false

    Rectangle {
        id: background
        anchors.fill: parent
        z: -1
        color: backgroundColor
        opacity: mouse.clicked ? 1.0 : 0.4
        Behavior on opacity {
            OpacityAnimator {
                duration: Kirigami.Units.longDuration
                easing.type: Easing.InOutQuad
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        id:coverLayer
        color: "transparent"
        z: 2
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true

        onClicked: root.clicked(parent.text)

        onPressAndHold:{
            console.log("NumberButton PressAndHold" , parent.text)
            root.pressAndHold(parent.text)
        }
        onPressed: {
            coverLayer.color = root.pressedColor
        }

        onReleased: {
            coverLayer.color = "transparent"
            root.release(parent.text)
        }

        onEntered: {
            coverLayer.color = root.hoverColor
        }

        onExited: {
            coverLayer.color = "transparent"
        }
    }

    ColumnLayout {
        spacing: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Controls.Label {
            id: main
            color: "#484848"
           font.pixelSize: textSize
            // font.pointSize: appWindow.fontSize + 12
            text: root.display == "" ? root.text : root.display
            opacity: special ? 0.4 : 1.0
            Layout.minimumWidth: parent.width
            horizontalAlignment: Text.AlignHCenter
        }
    }
}


