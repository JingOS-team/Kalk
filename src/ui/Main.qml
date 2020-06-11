import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1 as Controls
import Qt.labs.platform 1.0
import Qt.labs.settings 1.0
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
            height: parent.height - mainButtonsView.height
        }

        Controls.SwipeView {
            id: swipeView
            anchors.fill: parent
            currentIndex: 0
            clip: true
            Item {
                ButtonsView {
                    id: mainButtonsView
                    labels: ['7', '8', '9', '÷', '4', '5', '6', 'x', '1', '2', '3', '-', '.', '0', 'C', '+']
                    targets: ['7', '8', '9', '÷', '4', '5', '6', 'x', '1', '2', '3', '-', '.', '0', 'DEL', '+']
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
                    id: fns
                    fontSize: root.height / 18
                    backgroundColor: Kirigami.Theme.complementaryBackgroundColor
                    labels: ['!','sqrt','exp','log','^','sin','cos','tan','asin','(','acos','atan',')','π','e']
                    targets: ['!','sqrt(','exp(','log','^','sin(','cos(','tan(','asin(','(','acos(','atan(',')','pi','e']
                    onButtonClicked: calculationZone.appendToFormula(strToAppend)
                }
            }
        }

        function updateTitle() {
            root.title = 'Kalk';
            if (root.advanced) {
                root.title += ' - ' + getDisplayableFileName();
            }
        }

        function toggleExpanded() {
            setExpanded(!root.expanded);
            root.advanced = false;
        }

        function setExpanded(expanded) {
            root.expanded = expanded;
            updateTitle();
            calculationZone.retrieveFormulaFocus();
        }

        function toggleAdvanced() {
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
    }
}
