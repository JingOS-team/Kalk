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

Controls.Drawer {
    property alias header: headerLabel.text
    property alias from: fromListView
    property alias to: toListView
    id: unitConversionDrawer
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

        RowLayout {
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
                    Kirigami.SearchField {
                        id: fromSearchField
                        Layout.fillWidth: true
                        onAccepted: console.log("Search text is " + fromSearchField.text)
                        onTextEdited: {
                            fromListView.model = unitModel.search(fromSearchField.text);
                            fromListViewPopup.open();
                        }

                        onPressed: {
                            fromListView.model = unitModel.search("");
                            fromListViewPopup.open();
                        }
                    }

                    Controls.Popup {
                        id: fromListViewPopup
                        height: fromListView.height
                        width: parent.width * 1.8
                        ListView {
                            id: fromListView
                            width: parent.width
                            height: unitNumberPad.height
                            delegate: Kirigami.BasicListItem {
                                    text: modelData
                                    onClicked: {
                                        fromSearchField.text = modelData;
                                        result.text = unitModel.getRet(Number(value.text),fromSearchField.text.split(" ", 1),toSearchField.text.split(" ",1));
                                        fromListViewPopup.close();
                                    }
                            }
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Controls.Label {
                    text: i18n("To: ")
                    font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                }
                ColumnLayout {
                    Layout.fillWidth: true
                    Kirigami.SearchField {
                        id: toSearchField
                        Layout.fillWidth: true
                        onAccepted: console.log("Search text is " + toSearchField.text)
                        onTextEdited: {
                            toListView.model = unitModel.search(toSearchField.text);
                            toListViewPopup.open();
                        }
                        onPressed: {
                            toListView.model = unitModel.search("");
                            toListViewPopup.open();
                        }
                    }

                    Controls.Popup {
                        id: toListViewPopup
                        height: toListView.height
                        width: parent.width * 1.8
                        ListView {
                            id: toListView
                            width: parent.width
                            height: contentHeight + Kirigami.Units.gridUnit
                            delegate: Kirigami.BasicListItem {
                                text: modelData
                                onClicked: {
                                    toSearchField.text = modelData;
                                    result.text = unitModel.getRet(Number(value.text),fromSearchField.text.split(" ", 1),toSearchField.text.split(" ",1));
                                    toListViewPopup.close();
                                }
                            }
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: Kirigami.Units.largeSpacing
            Controls.Label {
                id: value
                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                onTextChanged: {
                    result.text = unitModel.getRet(Number(value.text),fromSearchField.text.split(" ", 1),toSearchField.text.split(" ",1));
                }
            }
            Controls.Label {
                text: fromSearchField.text.split(" ", 1) + " = "
                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
            }

            Controls.Label {
                id: result
                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
            }
            Controls.Label {
                text: toSearchField.text.split(" ",1)
                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
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
                    value.text = value.text.slice(0, value.text.length - 1);
                else
                    value.text += text;
            }
            onClear: value.text = ""
        }
    }
    background: Rectangle {
        color: Kirigami.Theme.backgroundColor
        anchors.fill: parent
    }
}

