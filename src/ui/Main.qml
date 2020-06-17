import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1 as Controls
import Qt.labs.platform 1.0
import Qt.labs.settings 1.0
import ".."
import "../engine"
import org.kde.kirigami 2.13 as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: 'Kalk'
    visible: true
    controlsVisible: false
    height: Kirigami.Units.gridUnit * 45
    width: Kirigami.Units.gridUnit * 27
    Kirigami.PagePool {
        id: mainPagePool
    }

    property string history: ''

    property string lastFormula
    property string lastError
    property int smallSpacing: 10
    Kirigami.SwipeNavigator {
        anchors.fill: parent
        Kirigami.Page {
            id: initialPage
            title: i18n("Calculation")
            Loader {
                id: mathJsLoader
                source: "qrc:///engine/MathJs.qml"
                asynchronous: true
                active: true
                onLoaded: {
                    mathJs.config({
                                      number: 'BigNumber'
                                  });
                }
            }

            CalculationZone {
                id: calculationZone
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height - swipeView.height
            }

            NumberPad {
                id: swipeView
                height: parent.height * 0.8
                width: parent.width
                anchors.bottom: parent.bottom
            }
        }

        UnitConversion {
            id: unitConversion
        }

        HistoryView {
            id: historyView
            visible: false
        }

        Kirigami.AboutPage {
                id: aboutPage
                visible: false
                title: i18n("About")
                aboutData: {
                    "displayName": "Calculator",
                    "productName": "kirigami/calculator",
                    "componentName": "kalk",
                    "shortDescription": "A mobile friendly calculator built with Kirigami.",
                    "homepage": "",
                    "bugAddress": "",
                    "version": "0.1",
                    "otherText": "",
                    "copyrightStatement": "© 2020 Plasma Development Team",
                    "desktopFileName": "org.kde.kalk",
//                    "authors": [
//                        {
//                            "name": "Han Young",
//                            "emailAddress": "hanyoung@protonmail.com",
//                        },
//                        {
//                            "name": "Devin Lin",
//                            "emailAddress": "espidev@gmail.com",
//                            "webAddress": "https://espi.dev"
//                        }
//                    ],
//                    "licenses": [
//                        {
//                            "name": "GPL v2",
//                            "text": "long, boring, license text",
//                            "spdx": "GPL-v2.0",
//                        }
//                    ]
                }
            }

    }

    //pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.None

    property var mathJs: mathJsLoader.item ? mathJsLoader.item.mathJs : null;
    
    //pageStack.initialPage: initialPage

//    function switchToPage(page) {
//        while (pageStack.depth > 0) pageStack.pop();
//        pageStack.push(page);
//    }
}
