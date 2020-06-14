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
    header: Controls.ToolBar {
        id: globalToolBar
        RowLayout {
            anchors.fill: parent
            ToolBarBtn {
                checked: true
                text: i18n("Calculation")
            }

            ToolBarBtn {
                text: i18n("Units Conversion")
                page: unitConversion
            }

            ToolBarBtn {
                text: i18n("History")
                page: historyView
            }
        }
    }

    pageStack.globalToolBar.style: Kirigami.ApplicationHeaderStyle.None

    property var mathJs: mathJsLoader.item ? mathJsLoader.item.mathJs : null;
    
    pageStack.initialPage: initialPage


    Kirigami.Page {
        id: initialPage
        topPadding: 0.0
        bottomPadding: 0.0
        leftPadding: 0.0
        rightPadding: 0
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
            height: parent.height - globalToolBar.height - swipeView.height
        }

        NumberPad {
            id: swipeView
            height: ( parent.height - globalToolBar.height ) * 0.8
            width: parent.width
            anchors.bottom: parent.bottom
        }
    }

    HistoryView {
        id: historyView
    }

    UnitConversion {
        id: unitConversion
    }

    function switchToPage(page) {
        while (pageStack.depth > 0) pageStack.pop();
        pageStack.push(page);
    }
}
