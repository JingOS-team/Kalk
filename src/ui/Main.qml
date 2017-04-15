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
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.1
import Fluid.Controls 1.0 as FluidControls
import Fluid.Controls 1.0
import Fluid.Material 1.0
import Qt.labs.platform 1.0
import Qt.labs.settings 1.0
import filehandler 1.0
import ".."
import "../engine"

FluidWindow {
    id: root
    visible: true

    property bool expanded: true
    property bool advanced: false

    property string history: ''

    property string lastFormula
    property string lastError

    property int normalWidth: 64 * (3 + 4 + 1)
    property int normalHeight: root.expanded ? buttonsPanel.height + normalCalculationZoneHeight : normalCalculationZoneHeight
    property int advancedWidth: 700
    property int advancedHeight: 400
    property int normalCalculationZoneHeight: 110

    height: normalHeight
    minimumHeight: normalHeight
    width: normalWidth
    minimumWidth: normalWidth
    header: Item {}
    title: 'Calculator'

    Component.onCompleted: {
        calculationZone.retrieveFormulaFocus();
        retrieveHistory();
    }

    Component.onDestruction: saveHistory()

    property Item styles: Styles {}

    Shortcuts {}

    Settings {
        property alias expanded: root.expanded
        property alias history: root.history
    }

    property var mathJs: mathJsLoader.item ? mathJsLoader.item.mathJs : null;

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
        anchors.bottom: root.advanced || !root.expanded ? parent.bottom : buttonsPanel.top
    }

    ButtonsPanel {
        id: buttonsPanel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: !root.advanced && root.expanded
    }

    HistoryPanel {
        id: historyPanel
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: calculationZone.bottom
        height: buttonsPanel.height
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
        visible: false
        id: documentText
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

    FluidControls.AlertDialog {
        id: alertDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        standardButtons: Dialog.Ok | Dialog.Cancel
        title: qsTr('Discard unsaved?')
        onAccepted: target === 'close' ? closeFile(true) : openFile(true)

        property string target: ''

        function show(target) {
            alertDialog.open();
            alertDialog.target = target;
        }
    }

    InfoBar {
        id: snackBar
        z: 99
    }

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
                    alertDialog.show('close');
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
        root.title = 'Calculator';
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
