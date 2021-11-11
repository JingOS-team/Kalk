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
import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.13 as Kirigami

Controls.Drawer {
    id: unitConversionDrawer

    property alias header: headerLabel.text
    property alias inputText: input.text
    property alias outputText: output.text
    property alias from: fromComboBox
    property alias to: toComboBox

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: parent.width
            Controls.Label {
                id: headerLabel
                text: "Acceleration"
                leftPadding: Kirigami.Units.largeSpacing
                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 3
            }
            Kirigami.Icon {
                visible: root.inPortrait
                width: Kirigami.Units.gridUnit * 3
                height: width
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                source: "window-close-symbolic"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        unitConversionDrawer.close()
                    }
                    onEntered: parent.opacity = 0.6
                    onExited: parent.opacity = 1

                }
            }
        }

        Kirigami.Separator{
            Layout.fillWidth: true
        }

        ColumnLayout {
            Layout.fillHeight: true

            ColumnLayout {
                Layout.fillWidth: true
                Layout.leftMargin: Kirigami.Units.gridUnit
                Layout.rightMargin: Kirigami.Units.gridUnit
                Layout.bottomMargin: Kirigami.Units.gridUnit * 2
                RowLayout {
                    Layout.fillWidth: true
                    Controls.Label {
                        text: i18n("From: ")
                        font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        Controls.Label {
                            id: input
                            Layout.alignment: Qt.AlignLeft
                            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
                            onTextChanged: {
                                if(text != "") {
                                    output.text = unitModel.getRet(Number(text), fromComboBox.currentIndex, toComboBox.currentIndex);
                                }
                            }
                        }
                        Kirigami.Separator {
                            Layout.fillWidth: true
                        }
                    }
                }
                Controls.ComboBox {
                    id: fromComboBox

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop
                    model: unitModel
                    textRole: "name"
                    currentIndex: 0
                    onCurrentIndexChanged: {
                        if(input.text != "") {
                            output.text = unitModel.getRet(Number(input.text), fromComboBox.currentIndex, toComboBox.currentIndex);
                        }
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.leftMargin: Kirigami.Units.gridUnit
                Layout.rightMargin: Kirigami.Units.gridUnit
                RowLayout {
                    Controls.Label {
                        text: i18n("To: ")
                        font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        Controls.Label {
                            id: output
                            Layout.alignment: Qt.AlignLeft
                            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
                            text: "0"
                        }
                        Kirigami.Separator {
                            Layout.fillWidth: true
                        }
                    }
                }

                Controls.ComboBox {
                    id: toComboBox
                    Layout.fillWidth: true
                    model: unitModel
                    textRole: "name"
                    currentIndex: 1
                    onCurrentIndexChanged: {
                        if(input.text != "") {
                            output.text = unitModel.getRet(Number(input.text), fromComboBox.currentIndex, toComboBox.currentIndex);
                        }
                    }
                }
            }
            Kirigami.Separator {
                Layout.fillWidth: true
            }

            NumberPad {
                id: unitNumberPad
                pureNumber: true
                Layout.alignment: Qt.AlignBottom
                onPressed: {
                    if(text == "DEL")
                        input.text = input.text.slice(0, input.text.length - 1);
                    else if(text == "longPressedDEL")
                        input.text = "";
                    else
                        input.text += text;
                }
            }
        }
    }
}

