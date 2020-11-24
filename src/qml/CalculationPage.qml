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
import QtGraphicalEffects 1.12
import org.kde.kirigami 2.13 as Kirigami

Kirigami.Page {
    id: initialPage
    title: i18n("Calculator")
    topPadding: 0
    leftPadding: 0
    rightPadding: 0
    bottomPadding: 0
    
    property color dropShadowColor: Qt.darker(Kirigami.Theme.backgroundColor, 1.15)
    property int keypadHeight: {
        let rows = 4, columns = 3;
        // restrict keypad so that the height of buttons never go past 0.85 times their width
        if ((initialPage.height - Kirigami.Units.gridUnit * 7) / rows > 0.85 * initialPage.width / columns) {
            return rows * 0.85 * initialPage.width / columns;
        } else {
            return initialPage.height - Kirigami.Units.gridUnit * 7;
        }
    }
    
    function expressionAdd(text) {
        mathEngine.parse(inputPad.expression + text);
        if (!mathEngine.error) {
            inputPad.expression += text;
        }
    }
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        Rectangle {
            id: outputScreen
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: initialPage.height - initialPage.keypadHeight
            color: Kirigami.Theme.backgroundColor
            
            Column {
                id: outputColumn
                anchors.fill: parent
                anchors.margins: Kirigami.Units.largeSpacing
                spacing: Kirigami.Units.gridUnit
                
                Flickable {
                    anchors.right: parent.right
                    height: Kirigami.Units.gridUnit * 1.5
                    width: Math.min(parent.width, contentWidth)
                    contentHeight: expressionRow.height
                    contentWidth: expressionRow.width
                    flickableDirection: Flickable.HorizontalFlick
                    Controls.Label {
                        id: expressionRow
                        horizontalAlignment: Text.AlignRight
                        font.pointSize: Kirigami.Units.gridUnit
                        text: inputPad.expression
                        color: Kirigami.Theme.disabledTextColor
                    }
                    onContentWidthChanged: {
                        if(contentWidth > width)
                        contentX = contentWidth - width;
                    }
                }
                
                Flickable {
                    anchors.right: parent.right
                    height: Kirigami.Units.gridUnit * 4
                    width: Math.min(parent.width, contentWidth)
                    contentHeight: result.height
                    contentWidth: result.width
                    flickableDirection: Flickable.HorizontalFlick
                    Controls.Label {
                        id: result
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
            }
        }
        
        // keypad area
        Rectangle {
            property string expression: ""
            id: inputPad
            Layout.fillHeight: true
            Layout.preferredWidth: initialPage.width
            Layout.alignment: Qt.AlignLeft
            Kirigami.Theme.colorSet: Kirigami.Theme.View
            Kirigami.Theme.inherit: false
            color: Kirigami.Theme.backgroundColor
            
            NumberPad {
                id: numberPad
                anchors.fill: parent
                anchors.topMargin: Kirigami.Units.gridUnit * 0.7
                anchors.bottomMargin: Kirigami.Units.smallSpacing
                anchors.leftMargin: Kirigami.Units.smallSpacing
                anchors.rightMargin: Kirigami.Units.gridUnit * 1.5 // for right side drawer indicator
                onPressed: {
                    if (text == "DEL") {
                        inputPad.expression = inputPad.expression.slice(0, inputPad.expression.length - 1);
                        expressionAdd("");
                    } else if (text == "=") {
                        historyManager.expression = inputPad.expression + " = " + result.text;
                        inputPad.expression = mathEngine.result;
                        resultFadeOutAnimation.start();
                    } else {
                        expressionAdd(text);
                    }
                }
                onClear: inputPad.expression = ""
            }
            
            Rectangle {
                id: drawerIndicator
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: Kirigami.Units.gridUnit
                x: parent.width - this.width
                
                Kirigami.Theme.colorSet: Kirigami.Theme.View
                color: Kirigami.Theme.backgroundColor
                
                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: -2
                    verticalOffset: 0
                    radius: 4
                    samples: 6
                    color: initialPage.dropShadowColor
                }
                
                Rectangle {
                    anchors.centerIn: parent
                    height: parent.height / 20
                    width: parent.width / 4
                    radius: 3
                    color: Kirigami.Theme.textColor
                }
            }

            Controls.Drawer {
                id: functionDrawer
                parent: initialPage
                y: initialPage.height - inputPad.height
                height: inputPad.height
                width: initialPage.width * 0.8
                dragMargin: drawerIndicator.width
                edge: Qt.RightEdge
                dim: false
                onXChanged: drawerIndicator.x = this.x - drawerIndicator.width + drawerIndicator.radius
                opacity: 1 // for plasma style
                FunctionPad {
                    anchors.fill: parent
                    anchors.bottom: parent.Bottom
                    anchors.leftMargin: Kirigami.Units.largeSpacing
                    anchors.rightMargin: Kirigami.Units.largeSpacing
                    anchors.topMargin: Kirigami.Units.largeSpacing
                    anchors.bottomMargin: parent.height / 4
                    onPressed: expressionAdd(text)
                }
                // for plasma style
                background: Rectangle {
                    Kirigami.Theme.colorSet: Kirigami.Theme.View
                    color: Kirigami.Theme.backgroundColor
                    anchors.fill: parent
                }
            }
        }
        
        // top panel drop shadow (has to be above the keypad)
        DropShadow {
            anchors.fill: outputScreen
            source: outputScreen
            horizontalOffset: 0
            verticalOffset: 1
            radius: 4
            samples: 6
            color: initialPage.dropShadowColor
        }
    }
    
}
