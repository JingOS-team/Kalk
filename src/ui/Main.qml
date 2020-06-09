import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1 as Controls
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
    height: Kirigami.Units.gridUnit * 45
    width: Kirigami.Units.gridUnit * 27
    minimumHeight: normalHeight
    minimumWidth: normalWidth

    globalDrawer: Kirigami.GlobalDrawer {
        id: globalDrawer
        title: "Kalk"
        titleIcon: "accessories-calculator"
        actions: [
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
    
    property bool expanded: true
    property bool advanced: false

    property string history: ''

    property string lastFormula
    property string lastError
    property int smallSpacing: 10
    header: Item {}
    title: 'Kalk'
    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.None

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
        }

        Controls.SwipeView {
            id: swipeView
            anchors.fill: parent
            currentIndex: 1
            clip: true
            Item {
                ButtonsView {
                    id: fns
                    fontSize: root.height / 18
                    backgroundColor: "#2ecc71"
                    labels: ['sqrt','exp','log','sin','cos','tan','asin','acos','atan','π','∞','e']
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
