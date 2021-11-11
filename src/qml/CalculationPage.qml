/*
 * This file is part of Kalk
 * Copyright (C) 2016 Pierre Jacquier <pierrejacquier39@gmail.com>
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
import QtQuick.Controls 2.1 as Controls
import org.kde.kirigami 2.13 as Kirigami

Kirigami.Page {
    id: initialPage

    leftPadding: 0
    rightPadding: 0
    bottomPadding: 0

    function expressionAdd(text) {
        mathEngine.parse(inputPad.expression + text)
        if (!mathEngine.error) {
            inputPad.expression += text;
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: Kirigami.Units.gridUnit * 6

            color: "#f2fbfbfb"
            Controls.Label {
                id: expressionRow

                anchors.right: parent.right
                horizontalAlignment: Text.AlignRight
                font.pointSize: Kirigami.Units.gridUnit * 3
                text: inputPad.expression
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: Kirigami.Units.gridUnit * 4
            color: "#f2fbfbfb"
            Controls.Label {
                id: result

                anchors.right: parent.right
                horizontalAlignment: Text.AlignRight
                font.pointSize: Kirigami.Units.gridUnit * 2
                text: mathEngine.result
                NumberAnimation on opacity {
                    id: resultFadeInAnimation

                    from: 0.5
                    to: 1
                    duration: Kirigami.Units.shortDuration
                }
                NumberAnimation on opacity {
                    id: resultFadeOutAnimation

                    from: 1
                    to: 0
                    duration: Kirigami.Units.shortDuration
                }
                onTextChanged: resultFadeInAnimation.start()
            }
        }

        Kirigami.Separator {
            Layout.fillWidth: true
        }

        Rectangle {
            id: inputPad

            property string expression: ""

            Layout.fillHeight: true
            Layout.preferredWidth: root.inPortrait ? initialPage.width : initialPage.width * 0.5
            Layout.alignment: Qt.AlignLeft

            Kirigami.Theme.colorSet: Kirigami.Theme.View
            Kirigami.Theme.inherit: false
            color: Kirigami.Theme.backgroundColor
            NumberPad {
                id: numberPad

                anchors.fill: parent
                onPressed: {
                    if (text == "DEL") {
                        inputPad.expression = inputPad.expression.slice(0, inputPad.expression.length - 1)
                        expressionAdd("")
                    } else if(text.indexOf("longPressed")==0) {
                        if (text == "longPressedDEL") {
                            inputPad.expression = ""
                        }
                    } else if(text == "=") {
                        historyManager.expression = inputPad.expression + " = " + result.text;
                        inputPad.expression = mathEngine.result;
                        resultFadeOutAnimation.start();
                    } else {
                        expressionAdd(text);
                    }
                }
            }
            Rectangle {
                id: drawerIndicator

                height: inputPad.height
                width: Kirigami.Units.gridUnit * 1.5
                x: parent.width - this.width + this.radius

                visible: root.inPortrait
                radius: 5
                color: Kirigami.Theme.highlightColor

                Rectangle {
                    anchors.centerIn: parent
                    height: parent.height / 20
                    width: parent.width / 4

                    radius: 3
                    color: Kirigami.Theme.textColor
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: functionDrawer.open()
                }
            }

            Controls.Drawer {
                id: functionDrawer

                y: initialPage.height - inputPad.height
                height: inputPad.height
                width: root.inPortrait? initialPage.width * 0.8 : initialPage.width * 0.5

                parent: initialPage
                modal: root.inPortrait
                dragMargin: 0
                interactive: root.inPortrait
                position: root.inPortrait ? 0 : 1
                visible: !root.inPortrait
                edge: Qt.RightEdge
                dim: false

                onXChanged: drawerIndicator.x = this.x - drawerIndicator.width + drawerIndicator.radius
                FunctionPad {
                    height: inputPad.height
                    width: parent.width
                    anchors.bottom: parent.Bottom
                    onPressed: expressionAdd(text);
                }
            }
        }
    }
}
