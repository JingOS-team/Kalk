/*
 * This file is part of Liri Calculator
 *
 * Copyright (C) 2016 Pierre Jacquier <pierrejacquier39@gmail.com>
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
// import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.1 as Controls
// import Fluid.Controls 1.0 as FluidControls
// import Fluid.Controls 1.0
import Qt.labs.platform 1.0
import Qt.labs.settings 1.0
import filehandler 1.0
import ".."
import "../engine"
import org.kde.kirigami 2.11 as Kirigami

Kirigami.ApplicationWindow {
    id: root
    visible: true
    controlsVisible: false
    
    globalDrawer: Kirigami.GlobalDrawer {
        id: globalDrawer
        title: "Kalk"
        titleIcon: "accessories-calculator"
        actions: [
//             Kirigami.PagePoolAction {
//                 text: qsTr("About")
//                 pagePool: mainPagePool
//                 page: "About.qml"
//             }
            Kirigami.Action {
                id: helpButton
                visible: root.advanced
                text: qsTr('Help')
                iconName: "documentinfo"
                tooltip: qsTr('Help')
                onTriggered: Qt.openUrlExternally('http://mathjs.org/docs/expressions/syntax.html')
            },
            Kirigami.Action {
                id: openButton
                visible: root.advanced
                text: qsTr('Open')
                iconName: "document-open-folder"
                tooltip: qsTr('Open file') + ' (Ctrl+O)'
                onTriggered: openFile()
            },
            Kirigami.Action {
                id: saveButton
                enabled: document.edited || document.unsaved
                visible: root.advanced
                text: qsTr('Save')
                iconName: "document-save"
//                 opacity: enabled ? root.styles.secondaryTextOpacity : root.styles.hintTextOpacity
                tooltip: qsTr('Save file') + ' (Ctrl+S)'
                onTriggered: saveFile()
            },
            Kirigami.Action {
                id: advancedButton
                visible: !root.advanced
                text: qsTr('Advanced')
                iconName: "view-list-text"
                tooltip: qsTr('Advanced mode') + ' (Ctrl+D)'
                onTriggered: setAdvanced(true)
            },
            Kirigami.Action {
                id: closeButton
                visible: root.advanced
                text: qsTr('Close')
                iconName: "window-close-symbolic"
                tooltip: qsTr('Close advanced mode')
                onTriggered: closeFile()
            },
            Kirigami.Action {
                id: historyButton
                visible: !root.advanced
                text: qsTr('History')
                iconName: historyPanel.visible ? "gnumeric-format-thousand-separator" : "shallow-history"
                tooltip: qsTr('Toggle history') + ' (Ctrl+H)'
                onTriggered: toogleHistory()
            },
            Kirigami.Action {
                id: expandButton
                visible: !root.advanced
                text: qsTr('Expand')
                iconName: root.expanded ? "draw-arrow-back" : "expand-all"
                tooltip: qsTr('Toggle expanded') + ' (Ctrl+E)'
                onTriggered: toogleExpanded()
            }
            
        ]
    }
    
    Kirigami.PagePool {
        id: mainPagePool
    }
    
//     pageActions: [
//             
//             ]
    
//     contextDrawer: Kirigami.ContextDrawer {
//         id: contextDrawer
//     }

    property bool expanded: true
    property bool advanced: false

    property string history: ''

    property string lastFormula
    property string lastError

//     property int normalWidth: 64 * (3 + 4 + 1)
// //     property int normalHeight: root.expanded ? buttonsPanel.height + normalCalculationZoneHeight : normalCalculationZoneHeight
//     property int advancedWidth: 700
//     property int advancedHeight: 800
//     property int normalCalculationZoneHeight: 110
    
    property int smallSpacing: 10

    height: normalHeight
    minimumHeight: normalHeight
    width: normalWidth
    minimumWidth: normalWidth
    header: Item {}
    title: 'Kalk'
    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.None
    
    property Item styles: Styles {}

    Shortcuts {}

    Settings {
        property alias expanded: root.expanded
        property alias history: root.history
    }
    
    property var mathJs: mathJsLoader.item ? mathJsLoader.item.mathJs : null;
    
    pageStack.initialPage: Kirigami.Page {
        topPadding: 0.0
        bottomPadding: 0.0
        leftPadding: 0.0
        rightPadding: 0
        
//             actions {
//                 main: Kirigami.Action {
//                     iconName: "document-edit"
//                     onTriggered: {
//                         print("Action button in buttons page clicked");
// //                         sheet.sheetOpen = !sheet.sheetOpen
//                     }
//                 }
//                 left: Kirigami.Action {
//                     iconName: "go-previous"
//                     onTriggered: {
//                         print("Left action triggered")
//                     }
//                 }
//                 right: Kirigami.Action {
//                     iconName: "go-next"
//                     onTriggered: {
//                         print("Right action triggered")
//                     }
//                 }
//                 contextualActions: [
//                     Kirigami.Action {
//                         text:"Action for buttons"
//                         iconName: "bookmarks"
//                         onTriggered: print("Action 1 clicked")
//                     },
//                     Kirigami.Action {
//                         text:"Action 2"
//                         iconName: "folder"
//                         enabled: false
//                     },
//                     Kirigami.Action {
//                         text: "Action for Sheet"
// //                         visible: sheet.sheetOpen
//                     }
//                 ]
//             }
                
//             ColumnLayout {
                
            Component.onCompleted: {
                calculationZone.retrieveFormulaFocus();
                retrieveHistory();
            }

            Component.onDestruction: saveHistory()

            Loader {
                id: mathJsLoader
                source: "../engine/MathJs.qml"
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
                height: parent.height-mainButtonsView.height
//                 anchors.bottom: root.advanced || !root.expanded ? parent.bottom : mainButtonsView.top
            }
            
            Controls.SwipeView {
                id: swipeView
                anchors.fill: parent
                currentIndex: 1
                clip: true
//                 property alias computedHeight: mainButtonsView.height
//                 height: 250
                Item {
                    ButtonsView {
                        id: fns
                        backgroundColor: "#2ecc71"
                        labels: ['sqrt','exp','log','sin','cos','tan','asin','acos','atan','π','∞','x10^']
                        targets: ['sqrt(','exp(','log','sin(','cos(','tan(','asin(','acos(','atan(','pi','Infinity','e']
                        onButtonClicked: calculationZone.appendToFormula(strToAppend)
                    }
                }
                Item {
                    ButtonsView {
                        id: mainButtonsView
                        backgroundColor: "#3daee9"
                        labels: ['7', '8', '9', '÷', '4', '5', '6', 'x', '1', '2', '3', '-', '.', '0', 'C', '+']
                        targets: ['7', '8', '9', '/', '4', '5', '6', '*', '1', '2', '3', '-', '.', '0', 'DEL', '+']
                        onButtonClicked: calculationZone.appendToFormula(strToAppend)
                        onButtonLongPressed: {
                            if (strToAppend === "DEL") {
                                calculationZone.clearFormula();
                            }
                        }
                    }
                }
                Item {
                    ButtonsView {
                        backgroundColor: "#fdbc4b"
//                         Kirigami.Theme.Complementary.neutralTextColor
                        labels: ['^', '!', '(', ')']
                        targets: ['^', '!', '(', ')']
                        onButtonClicked: calculationZone.appendToFormula(strToAppend)
                    }
                }
            }

            HistoryPanel {
                id: historyPanel
                visible: false
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: calculationZone.bottom
                height: mainButtonsView.height
            }

            Timer {
                id: addToHistoryTimer
                running: false
                interval: 1000
                onTriggered: historyPanel.add()
            }

            FileHandler {
                id: document
                document: documentText.textDocument
                onError: snackBar.open(message)
                onFileUrlChanged: updateTitle()
                onLoaded: {
                    setAdvanced(true);
                    calculationZone.loadFileContent(text);
                    document.edited = false;
                }

                property bool edited: false
                property bool unsaved: document.fileName === 'untitled.lcs'

                function setEdited(edited) {
                    this.edited = edited;
                    root.updateTitle();
                }
            }

            TextEdit {
                id: documentText
                visible: false
            }

            FileDialog {
                id: openDialog
                fileMode: FileDialog.OpenFile
                selectedNameFilter.index: 1
                nameFilters: ["Liri Calculator Script (*.lcs)"]
                folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                onAccepted: document.load(file)
            }

            FileDialog {
                id: saveDialog
                fileMode: FileDialog.SaveFile
                defaultSuffix: document.fileType
                nameFilters: openDialog.nameFilters
                selectedNameFilter.index: document.fileType === 'lcs' ? 0 : 1
                folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                onAccepted: saveFile(true, file)
            }
            
            // TODO: Maybe replace the OberlaySheet with an InlineMessage
            
            Kirigami.OverlaySheet {
                id: alertDialog
                property string target: ''
                header: Kirigami.Heading {
                    text: qsTr('Discard unsaved?')
                }
                ColumnLayout {
                    Controls.Button {
                        text: qsTr("Cancel") 
                        Layout.alignment: Qt.AlignHCenter
                        onClicked: alertDialog.close()
                    }
                    Controls.Button {
                        text: qsTr("OK")
                        Layout.alignment: Qt.AlignHCenter
                        onClicked: {
                            alertDialog.close()
                            closeFile(true)
                        }
                    }
                }
            }

        //     SnackBar {
        //         id: snackBar
        //         z: 99
//             }
//             
// }
        }
//     }
    
    function retrieveHistory() {
        historyPanel.historyModel.clear();
        var historyArray = JSON.parse(root.history);
        for (var i = 0; i < historyArray.length; i++) {
            historyPanel.historyModel.append(historyArray[i]);
        }
    }

    function saveHistory() {
        var historyArray = [];
        for (var i = 0; i < historyPanel.historyModel.count; i++) {
            var item = historyPanel.historyModel.get(i);
            historyArray.push({
               formula: item.formula,
               result: item.result,
            });
        }
        root.history = JSON.stringify(historyArray)
    }

    function saveFile(bypass, bypassFileUrl) {
        if (!bypass) {
            if (document.unsaved) {
                saveDialog.open();
                return;
            }
        }
        document.saveAs(bypassFileUrl ? bypassFileUrl : document.fileUrl);
        document.edited = false;
        snackBar.open((bypassFileUrl ? bypassFileUrl : document.fileName) + ' ' + qsTr('saved'));
        updateTitle();
    }

    function closeFile(bypass) {
        if (!(documentText.text === '')) {
            if (!bypass) {
                if (document.unsaved || document.edited) {
                    alertDialog.open('close');
                    return;
                }
            }
        }

        document.load(null);
        setAdvanced(false);
    }

    function openFile(bypass) {
        if (!bypass && root.advanced) {
            if (document.unsaved || document.edited) {
                alertDialog.show('open');
                return;
            }
        }
        openDialog.open();
    }

    function getDisplayableFileName() {
        if (document.unsaved) {
            return 'Unsaved';
        }
        if (document.edited) {
            return document.fileName + '*';
        }
        return document.fileName;
    }

    function updateTitle() {
        root.title = 'Kalk';
        if (root.advanced) {
            root.title += ' - ' + getDisplayableFileName();
        }
    }

    function toogleExpanded() {
        setExpanded(!root.expanded);
        root.advanced = false;
    }

    function setExpanded(expanded) {
        root.expanded = expanded;
        updateTitle();
        calculationZone.retrieveFormulaFocus();
    }

    function toogleHistory() {
        historyPanel.visible = !historyPanel.visible;
        setExpanded(true);
    }

    function toogleAdvanced() {
        setAdvanced(!root.advanced);
        setExpanded(!root.advanced);
    }

    function setAdvanced(advanced) {
        root.advanced = advanced;
        root.width = advanced ? advancedWidth : normalWidth;
        root.height = advanced ? advancedHeight : normalHeight;

        if (advanced) {
            calculationZone.loadFileContent(calculationZone.formula.text);
            calculationZone.setFocusAt(0);
        } else {
            calculationZone.retrieveFormulaFocus();
        }
        updateTitle();
    }

    function setAdvancedContent(text) {
        calculationZone.formulasLines.text = text;
    }

    /*
     * Copyright (C) 2014 Canonical Ltd
     *
     * This file is part of Ubuntu Calculator App
     *
     * Ubuntu Calculator App is free software: you can redistribute it and/or modify
     * it under the terms of the GNU General Public License version 3 as
     * published by the Free Software Foundation.
     *
     * Ubuntu Calculator App is distributed in the hope that it will be useful,
     * but WITHOUT ANY WARRANTY; without even the implied warranty of
     * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     * GNU General Public License for more details.
     *
     * You should have received a copy of the GNU General Public License
     * along with this program.  If not, see <http://www.gnu.org/licenses/>.
     */

    function formatBigNumber(bigNumberToFormat) {
        // Maximum length of the result number
        var NUMBER_LENGTH_LIMIT = 14;

        if (bigNumberToFormat.toString().length > NUMBER_LENGTH_LIMIT) {
            var resultLength = mathJs.format(bigNumberToFormat, {exponential: {lower: 1e-10, upper: 1e10},
                                            precision: NUMBER_LENGTH_LIMIT}).toString().length;

            return mathJs.format(bigNumberToFormat, {exponential: {lower: 1e-10, upper: 1e10},
                                 precision: (NUMBER_LENGTH_LIMIT - resultLength + NUMBER_LENGTH_LIMIT)}).toString();
        }
        return bigNumberToFormat.toString()
    }

    function calculate(formula, wantArray) {
        try {
            var res = mathJs.eval(formula);
            if (!wantArray) {
                res = formatBigNumber(res);
            }
        } catch (exception) {
            if (debug) {
                console.log(exception.toString());
            }
            lastError = exception.toString();
            return '';
        }
        return res;
    }
}
