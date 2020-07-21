/*
 * This file is part of Kalk
 * Copyright (C) 2016 Pierre Jacquier <pierrejacquier39@gmail.com>
 *
 *               2020 Han Young <hanyoung@protonmail.com>
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
import QtQuick.Controls 2.1 as Controls
import Qt.labs.platform 1.0
import Qt.labs.settings 1.0
import org.kde.kirigami 2.13 as Kirigami

Kirigami.Page {
    icon.name: "accessories-calculator"
    id: initialPage
    title: i18n("Calculator")
    leftPadding: 0
    rightPadding: 0
    bottomPadding: 0
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Controls.Label {
            id: expressionRow
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            font.pointSize: Kirigami.Units.gridUnit * 2
            text: inputPad.expression
            onTextChanged: {
                mathEngine.parse(this.text);
            }
        }
        Controls.Label {
            id: result
            horizontalAlignment: Text.AlignRight
            Layout.fillWidth: true
            font.pointSize: Kirigami.Units.gridUnit * 3
            text: mathEngine.result
        }

        Kirigami.Separator {
            Layout.fillWidth: true
        }
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Kirigami.Theme.colorSet: Kirigami.Theme.View
            Kirigami.Theme.inherit: false
            color: Kirigami.Theme.backgroundColor
            Layout.alignment: Qt.AlignBottom
            Controls.SwipeView{
                property string expression: ""
                id: inputPad
                width: parent.width
                height: parent.height
                NumberPad {
                    id: numberPad
                    onPressed: {
                        if(text == "DEL")
                            inputPad.expression = inputPad.expression.slice(0, inputPad.expression.length - 1);
                        else if(text == "longPressed")
                            inputPad.expression = "";
                        else if(text == "="){
                            historyManager.expression = inputPad.expression + "=" + result.text;
                            inputPad.expression = ""
                        }
                        else
                            inputPad.expression += text;
                    }
                }
                FunctionPad {
                    id: functionPad
                    onPressed: inputPad.expression += text;
                }
            }
        }
    }
}
