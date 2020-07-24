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

Kirigami.Page {
    id: conversionPage
    property var inputField: input
    title: i18n("Units Converter")
    visible: false
    leftPadding: 0
    rightPadding: 0
    bottomPadding: 0
    ColumnLayout {
        width: parent.width
        AutoResizeComboBox {
            id: unitTypeSelection
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width * 0.8
            model: typeModel
            textRole: "name"
            onCurrentIndexChanged: {
                input.text = "";
                output.text = "";
                typeModel.currentIndex(currentIndex);
                fromComboBox.currentIndex = 0;
                toComboBox.currentIndex = 1;
            }
        }
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width * 0.9
            RowLayout {
                Controls.TextField {
                    id: input
                    Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                    Layout.preferredWidth: parent.width * 0.4
                    Kirigami.Theme.colorSet: Kirigami.Theme.Selection
                    font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                    color: Kirigami.Theme.activeTextColor
                    wrapMode: TextInput.WrapAnywhere
                    validator: DoubleValidator{}
                    focus: true
                    onTextChanged: {
                        console.log(unitNumberPad.expression);
                        if(text != "") {
                            output.text = unitModel.getRet(Number(text), fromComboBox.currentIndex, toComboBox.currentIndex);
                            output.cursorPosition = 0; // force align left
                        }
                    }
                }
                AutoResizeComboBox {
                    id: fromComboBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                    fontSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                    popupWidth: parent.width
                    model: unitModel
                    textRole: "name"
                    currentIndex: 0
                    onCurrentIndexChanged: {
                        if(input.text != "") {
                            output.text = unitModel.getRet(Number(input.text), fromComboBox.currentIndex, toComboBox.currentIndex);
                            output.cursorPosition = 0; // force align left
                        }
                    }
                }
            }

            RowLayout {
                Controls.Label {
                    id: output
                    Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                    Layout.preferredWidth: parent.width * 0.4
                    font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                    Kirigami.Theme.colorSet: Kirigami.Theme.Selection
                    color: Kirigami.Theme.activeTextColor
                }
                AutoResizeComboBox {
                    id: toComboBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                    fontSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                    popupWidth: parent.width
                    model: unitModel
                    textRole: "name"
                    currentIndex: 1
                    onCurrentIndexChanged: {
                        if(input.text != "") {
                            output.text = unitModel.getRet(Number(input.text), fromComboBox.currentIndex, toComboBox.currentIndex);
                            output.cursorPosition = 0; // force align left
                        }
                    }
                }
            }
        }
    }


    Kirigami.Separator {
        width: parent.width
        anchors.bottom: unitNumberPad.top
    }
    NumberPad {
        id: unitNumberPad
        pureNumber: true
        height: parent.height * 0.7
        width: parent.width
        anchors.bottom: parent.bottom
        onPressed: {
            if(text == "DEL")
                input.text = input.text.slice(0, input.text.length - 1);
            else if(text == "longPressed")
                input.text = "";
            else
                input.text += text;
        }
    }
}
