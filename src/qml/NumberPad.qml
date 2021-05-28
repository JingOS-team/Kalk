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
import org.kde.kirigami 2.13 as Kirigami
import QtQuick.Layouts 1.1
GridLayout {
    signal pressed(string text)
    property bool pureNumber: false
    columns: pureNumber ? 3 : 4
    NumberButton {text: "7" ; onClicked: pressed(text);}
    NumberButton {text: "8" ; onClicked: pressed(text);}
    NumberButton {text: "9" ; onClicked: pressed(text);}
    NumberButton {text: "+" ; onClicked: pressed(text); special: true; visible: !pureNumber}
    NumberButton {text: "4" ; onClicked: pressed(text);}
    NumberButton {text: "5" ; onClicked: pressed(text);}
    NumberButton {text: "6" ; onClicked: pressed(text);}
    NumberButton {text: "-" ; onClicked: pressed(text); special: true; visible: !pureNumber}
    NumberButton {text: "1" ; onClicked: pressed(text);}
    NumberButton {text: "2" ; onClicked: pressed(text);}
    NumberButton {text: "3" ; onClicked: pressed(text);}
    NumberButton {text: "×" ; onClicked: pressed(text); special: true; visible: !pureNumber}
    NumberButton {text: "0" ; onClicked: pressed(text);}
    NumberButton {text: "." ; onClicked: pressed(text);}
    NumberButton {text: "^" ; onClicked: pressed(text); visible: !pureNumber}
    NumberButton {text: "÷" ; onClicked: pressed(text); special: true; visible: !pureNumber}
    NumberButton {text: "(" ; onClicked: pressed(text); special: true; visible: !pureNumber}
    NumberButton {text: ")" ; onClicked: pressed(text); special: true; visible: !pureNumber}
    NumberButton {text: "DEL"; display: "⌫"; onClicked: pressed(text); special: true;}
    NumberButton {text: "=" ; onClicked: pressed(text); special: true; visible: !pureNumber}
}

