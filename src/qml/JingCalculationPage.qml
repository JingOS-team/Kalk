
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
import org.kde.kirigami 2.13 as Kirigami

import "qrc:/qml/StringUtils.js" as StringUtils

Kirigami.Page {
    //    icon.name: "accessories-calculator"
    id: initialPage
    title: i18n("Calculator")

    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    bottomPadding: 0
    globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None
    property bool isResult: false
    property alias myResult: result.text

    // remove blur
    // background: Item {}
    background:Rectangle{
        color:"#e8efff"
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: reslutLayout
            width: parent.width
            Layout.fillHeight: true
            anchors.bottom: inputPad.top
            anchors.top: parent.top
            color: "#f2fbfbfb"

            //            color: "grey"
            Rectangle {
                id: expression_view
                width: parent.width
                height: 120
                color: "transparent"

                Controls.Label {
                    id: expressionRow
                    anchors.right: parent.right
                    anchors.rightMargin: 22
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: 60
                    text: inputPad.expression
                    color: "#414345"
                }
            }

            Rectangle {
                id: result_view
                Layout.fillWidth: true
                anchors {
                    top: expression_view.bottom
                    bottom: parent.bottom
                }

                width: parent.width
                Layout.fillHeight: true
                color: "transparent"

                Controls.Label {
                    id: result
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignRight
                    anchors.rightMargin: 22
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 40
                    color: "#8D9199"

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

        Rectangle {

            property string expression: ""
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            id: inputPad
            height: parent.height / 5 * 3
            Kirigami.Theme.inherit: false
            color: "transparent"
            focus: true
            Keys.enabled: true
            Keys.onPressed: {
                if (event.key === Qt.Key_0) {
                    expressionAdd("0")
                } else if (event.key === Qt.Key_1) {
                    expressionAdd("1")
                } else if (event.key === Qt.Key_2) {
                    expressionAdd("2")
                } else if (event.key === Qt.Key_3) {
                    expressionAdd("3")
                } else if (event.key === Qt.Key_4) {
                    expressionAdd("4")
                } else if (event.key === Qt.Key_5) {
                    expressionAdd("5")
                } else if (event.key === Qt.Key_6) {
                    expressionAdd("6")
                } else if (event.key === Qt.Key_7) {
                    expressionAdd("7")
                } else if (event.key === Qt.Key_8) {
                    expressionAdd("8")
                } else if (event.key === Qt.Key_9) {
                    expressionAdd("9")
                } else if (event.key === Qt.Key_Plus) {
                    expressionAdd("+")
                } else if (event.key === Qt.Key_Minus) {
                    expressionAdd("-")
                } else if (event.key === Qt.Key_Asterisk) {
                    expressionAdd("×")
                } else if (event.key === Qt.Key_Slash) {
                    expressionAdd("÷")
                } else if (event.key === Qt.Key_Percent) {
                    expressionAdd("%")
                } else if (event.key === Qt.Key_Period) {
                    expressionAdd(".")
                } else if (event.key === Qt.Key_AsciiCircum) {
                    expressionAdd("^")
                } else if (event.key === Qt.Key_Equal
                           || event.key === Qt.Key_Enter) {
                    historyManager.expression = inputPad.expression + " = " + result.text
                    inputPad.expression = mathEngine.result
                    isResult = true
                    resultFadeOutAnimation.start()
                } else if (event.key === Qt.Key_Backspace
                           || event.key === Qt.Key_Delete) {
                    inputPad.expression = inputPad.expression.slice(
                                0, inputPad.expression.length - 1)
                } else if (event.key === Qt.Key_Escape) {
                    inputPad.expression = ""
                    myResult = ""
                }
            }

            border.width: 1
            border.color: "transparent"

            JingKeyboard {
                id: keyboard

                anchors.fill: parent
                property bool longPressBack: false

                //                item_base_width:  inputPad.width / 64
                //                item_base_height : inputPad.height / 5
                //                item_base_height:  185 * appWindow.officalScale
                onPressed: {
                    if (text == "DEL" || text == "←") {
                        if(inputPad.expression.length > 0 ){

                            inputPad.expression = inputPad.expression.slice(
                                    0, inputPad.expression.length - 1)
                            expressionAdd("")
                            if(inputPad.expression.length== 0){
                                myResult = ""
                            }
                        }
                    } else if (text == "C") {
                        inputPad.expression = ""
                        myResult = ""
                        mathEngine.result = ""
                    } else if (text.indexOf("longPressed") == 0) {
                        if (text == "longPressedDEL") {
                            inputPad.expression = ""
                            myResult = ""
                        }
                    } else if (text == "=") {
                        historyManager.expression = inputPad.expression + " = " + result.text
                        inputPad.expression = mathEngine.result
                        isResult = true
                        resultFadeOutAnimation.start()
                    } else {
                        console.log("input  ....")
                        expressionAdd(text)
                    }
                }

                onPressedAndHold: {
                    console.log("Press And Hold" , text)
                    longPressBack = true
                    back_timer.start()
                }

                onRelease: {
                    if(longPressBack){
                        back_timer.stop()
                    }
                       longPressBack = false
                }

                Timer {
                     id: back_timer
                     interval: 200
                     repeat: true
                     triggeredOnStart: true
                     onTriggered: {
                         console.log('do delete.....')
                         if(inputPad.expression.length > 0 ){

                             inputPad.expression = inputPad.expression.slice(
                                     0, inputPad.expression.length - 1)
                             expressionAdd("")
                             if(inputPad.expression.length== 0){
                                 myResult = ""
                             }
                         }
                     }
                }

            }
        }
    }

    function expressionAdd(text) {
        console.log("input : " , text)

        if (isNumber(text)) {
            if (text === "0") {
//                var curValue = inputPad.expression + text
                var curValue = inputPad.expression
                if (curValue.length === 1) {
//                    var char_value = StringUtils.getCharAt(curValue, 0)
//                    if (char_value === 0) {
//                        return
//                    }
                    if(curValue == "0"){
                        return
                    }
                } else if (curValue.length > 2) {
                    console.log("1111   allChar : ", curValue)
                    var lastChar = StringUtils.getCharAt(curValue,
                                                         curValue.length - 1)
                    console.log("lastChar : ", lastChar)
                    var lastTwoChar = StringUtils.getCharAt(curValue,
                                                            curValue.length - 2)
                    console.log("lastTowChar", lastTwoChar)
                    if (lastChar == "0" && isYunSuanFu(lastTwoChar)) {
                        console.log("org : ", inputPad.expression)
                        inputPad.expression = StringUtils.subString(
                                    inputPad.expression, 0,
                                    inputPad.expression.length - 1)
                        console.log("new : ", inputPad.expression)
                    }
                }
            } else {

                var curValue1 = inputPad.expression
                if (curValue1.length === 1) {
                    if (curValue1 == "0") {
                        inputPad.expression = ""
                    }
                } else {
                    if (curValue1.length > 2) {
                        console.log("1111   allChar : ", curValue1)
                        var lastChar = StringUtils.getCharAt(
                                    curValue1, curValue1.length - 1)
                        console.log("lastChar : ", lastChar)
                        var lastTwoChar = StringUtils.getCharAt(
                                    curValue1, curValue1.length - 2)
                        console.log("lastTowChar", lastTwoChar)
                        if (lastChar == "0" && isYunSuanFu(lastTwoChar)) {
                            console.log("org : ", inputPad.expression)
                            inputPad.expression = StringUtils.subString(
                                        inputPad.expression, 0,
                                        inputPad.expression.length - 1)
                            console.log("new : ", inputPad.expression)
                        }
                    }
                }
            }
        }

//        if (text == ".") {
//            var expLength = inputPad.expression.length
//            var content  = inputPad.expression
//            console.log("=====1.5 --> ", inputPad.expression)
//            if (expLength === "1") {
//                console.log("=====2-> ", inputPad.expression)
//                if (inputPad.expression == ".") {
//                    return
//                }
//            } else if (expLength > 1) {
//                console.log("content : ", content)
//                console.log("length : " , expLength)
//                var uu = StringUtils.getCharAt(content , expLength - 1)
//                console.log("special  : " ,uu )
//                if (uu == '.') {
//                    console.log("=====3", inputPad.expression)
//                    return
//                }
//            }
//        }

        if (isResult) {
            if (text == "+" || text == "-" || text == "x" || text == "/"
                    || text == "×" || text == "÷"
                    || text == "^" || text == "%") {
                //                inputPad.expression = ""
            } else {
                inputPad.expression = ""
            }

            isResult = false
        }

        console.log("8888 =>  ", inputPad.expression)

        if (mathEngine.parse(inputPad.expression + text)) {
            console.log("after parse ::::::::: :", (inputPad.expression + text))
            if (!mathEngine.error) {
                inputPad.expression += text
                console.log("result :" , inputPad.expression)
            }
            myResult = mathEngine.result
            console.log("result : ",mathEngine.result)
        }
    }

    function isYunSuanFu(text) {
        if (text === "+" || text === "-" || text === "x" || text === "/"
        || text == "×" || text == "÷"
                || text === "%" || text === "^") {
            return true
        }
        return false
    }

    function isNumber(text) {
        if (text === "1" || text === "2" || text === "3" || text === "4" || text === "5" || text
                === "6" || text === "7" || text === "8" || text === "9" || text === "0") {
            return true
        }
        return false
    }
}
