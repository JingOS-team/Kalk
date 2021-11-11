
/*
 * This file is part of Kalk
 *
 * Copyright (C) 2020 Han Young <hanyoung@protonmail.com>
 *               2021 Bob <pengbo·wu@jingos.com>
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
import org.kde.kirigami 2.13 as Kirigami
import QtQuick.Layouts 1.1

GridLayout {
    property bool pureNumber: false
    property real mScale: appWindow.officalScale
    property int leftFontSize: appWindow.fontSize + 12
    property int leftSingleFontSize: appWindow.fontSize + 18
    property int numFontSize: appWindow.fontSize + 31
    property int calFontSize: appWindow.fontSize + 34

    signal pressed(string text)

    columns: 8
    rows: 4
    columnSpacing: 0
    rowSpacing: 0

    // first row
    NumberButton {
        text: "sin("
        display: "sin"
        onClicked: pressed(text)
        textColor: Kirigami.Theme.textColor
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: "cos("
        display: "cos"
        onClicked: pressed(text)
        textColor: Kirigami.Theme.textColor
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: "tan("
        display: "tan"
        onClicked: pressed(text)
        textColor: Kirigami.Theme.textColor
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: "7"
        onClicked: pressed(text)
        textSize: numFontSize
        backgroundColor: "#ffffff"
        iWidth: 290 * mScale
    }
    NumberButton {
        text: "8"
        textSize: numFontSize
        onClicked: pressed(text)
        backgroundColor: "#ffffff"
        iWidth: 290 * mScale
    }
    NumberButton {
        text: "9"
        textSize: numFontSize
        onClicked: pressed(text)
        backgroundColor: "#ffffff"
        iWidth: 290 * mScale
    }
    NumberButton {
        text: "+"
        textSize: calFontSize
        iWidth: 221 * mScale
        display: "+"
        onClicked: pressed(text)
        textColor: "#e97503"
        backgroundColor: "#f8f8f8"
    }
    NumberButton {
        text: "←"
        textSize: calFontSize
        onClicked: pressed(text)
        visible: !pureNumber
        textColor: "#e97503"
        iWidth: 221 * mScale
        backgroundColor: "#f8f8f8"
    }

    // second row
    NumberButton {
        text: "log("
        display: "log"
        onClicked: pressed(text)
        textColor: Kirigami.Theme.textColor
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: "log10("
        display: "log10"
        onClicked: pressed(text)
        textColor: Kirigami.Theme.textColor
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: "log2("
        display: "log2"
        onClicked: pressed(text)
        textColor: Kirigami.Theme.textColor
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: "4"
        textSize: numFontSize
        onClicked: pressed(text)
        backgroundColor: "#ffffff"
        iWidth: 290 * mScale
    }
    NumberButton {
        text: "5"
        textSize: numFontSize
        onClicked: pressed(text)
        backgroundColor: "#ffffff"
        iWidth: 290 * mScale
    }
    NumberButton {
        text: "6"
        textSize: numFontSize
        onClicked: pressed(text)
        backgroundColor: "#ffffff"
        iWidth: 290 * mScale
    }
    NumberButton {
        text: "-"
        textSize: calFontSize
        iWidth: 221 * mScale
        textColor: "#e97503"
        onClicked: pressed(text)
        visible: !pureNumber
        backgroundColor: "#f8f8f8"
    }
    NumberButton {
        text: "C"
        textSize: leftSingleFontSize
        iWidth: 221 * mScale
        onClicked: pressed(text)
        textColor: "#e97503"
        backgroundColor: "#f8f8f8"
    }

    // third row
    NumberButton {
        text: "√("
        display: "√"
        textSize: leftSingleFontSize
        onClicked: pressed(text)
        textColor: Kirigami.Theme.textColor
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: "π"
        textSize: leftSingleFontSize
        onClicked: pressed(text)
        textColor: Kirigami.Theme.textColor
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: "e"
        textSize: leftSingleFontSize
        onClicked: pressed(text)
        textColor: Kirigami.Theme.textColor
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: "1"
        textSize: numFontSize
        onClicked: pressed(text)
        backgroundColor: "#ffffff"
        iWidth: 290 * mScale
    }
    NumberButton {
        text: "2"
        textSize: numFontSize
        iWidth: 290 * mScale
        onClicked: pressed(text)
        backgroundColor: "#ffffff"
    }
    NumberButton {
        text: "3"
        textSize: numFontSize
        iWidth: 290 * mScale
        onClicked: pressed(text)
        backgroundColor: "#ffffff"
    }
    NumberButton {
        text: "×"
        textSize: calFontSize
        textColor: "#e97503"
        onClicked: pressed(text)
        visible: !pureNumber
        iWidth: 221 * mScale
        backgroundColor: "#f8f8f8"
    }
    NumberButton {
        text: "="
        textSize: calFontSize
        onClicked: pressed(text)
        Layout.rowSpan: 2
        backgroundColor: "#e97503"
        textColor: "#ffffff"
        iWidth: 221 * mScale
        iHeight: appWindow.height * 3 / 5 / 2
    }

    // last row
    NumberButton {
        text: "%"
        textSize: leftSingleFontSize
        onClicked: pressed(text)
        textColor: Kirigami.Theme.textColor
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: "("
        textSize: leftSingleFontSize
        onClicked: pressed(text)
        backgroundColor: "#4dc1c1c1"
    }
    NumberButton {
        text: ")"
        textSize: leftSingleFontSize
        onClicked: pressed(text)
        backgroundColor: "#4dc1c1c1"
    }

    NumberButton {
        text: "^"
        display: "xʸ"
        textSize: numFontSize
        iWidth: 290 * mScale
        onClicked: pressed(text)
        visible: !pureNumber
        backgroundColor: "#ffffff"
    }
    NumberButton {
        text: "0"
        textSize: numFontSize
        iWidth: 290 * mScale
        onClicked: pressed(text)
        backgroundColor: "#ffffff"
    }

    NumberButton {
        text: "."
        textSize: numFontSize
        iWidth: 290 * mScale
        onClicked: pressed(text)
        backgroundColor: "#ffffff"
    }

    NumberButton {
        iWidth: 221 * mScale
        text: "÷"
        textSize: calFontSize
        onClicked: pressed(text)
        textColor: "#e97503"
        visible: !pureNumber
        backgroundColor: "#f8f8f8"
    }
}