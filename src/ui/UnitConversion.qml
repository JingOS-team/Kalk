import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.11 as Kirigami

Kirigami.Page {
    id: conversionPage
    property var inputField: input
    title: i18n("units conversion")
    visible: false
    ColumnLayout {
        width: parent.width
        spacing: root.height / 36
        AutoResizeComboBox {
            id: unitTypeSelection
            Layout.alignment: Qt.AlignHCenter
            model: unitTypeSelectionModel
            textRole: "type"
            onCurrentTextChanged: {
                fromComboBox.model = determineModel(currentText);
                toComboBox.model = determineModel(currentText);
            }
        }
        Kirigami.Separator {}
        RowLayout {
            width: parent.width * 0.5
            Layout.alignment: Qt.AlignHCenter
            ColumnLayout {
                Controls.TextField {
                    id: input
                    Layout.preferredHeight: root.height / 16
                    Kirigami.Theme.colorSet: Kirigami.Theme.Selection
                    color: Kirigami.Theme.activeTextColor
                    wrapMode: TextInput.WrapAnywhere
                    validator: DoubleValidator{}
                    focus: true
                }
                AutoResizeComboBox {
                    id: fromComboBox
                    model: angleModel
                    textRole: "type"
                    currentIndex: 0
                }
            }

            ColumnLayout {
                Controls.TextField {
                    id: output
                    Layout.preferredHeight: root.height / 16
                    readOnly: true
                    Kirigami.Theme.colorSet: Kirigami.Theme.Selection
                    color: Kirigami.Theme.activeTextColor
                    wrapMode: TextInput.WrapAnywhere
                    validator: DoubleValidator{}
                    focus: true
                }
                AutoResizeComboBox {
                    id: toComboBox
                    model: angleModel
                    textRole: "type"
                    currentIndex: 0
                }
            }
        }
    }
    NumericInputPad {
        height: ( parent.height - globalToolBar.height ) * 0.8
        width: parent.width
        anchors.bottom: parent.bottom
    }
    ListModel {
        id: unitTypeSelectionModel
        ListElement {type: "Angle"}
        ListElement {type: "Area"}
        ListElement {type: "Data Transfer Rate"}
        ListElement {type: "Digital Storage"}
        ListElement {type: "Duration"}
        ListElement {type: "Energy"}
        ListElement {type: "Force"}
        ListElement {type: "Frequency"}
        ListElement {type: "Length"}
        ListElement {type: "Mass"}
        ListElement {type: "Power"}
        ListElement {type: "Pressure"}
        ListElement {type: "Speed"}
        ListElement {type: "Temperature"}
        ListElement {type: "Volume"}
    }

    ListModel {
        id: angleModel
        ListElement {type: "Radian"}
        ListElement {type: "Degree"}
        ListElement {type: "Turn"}
        ListElement {type: "π"}
        ListElement {type: "Quadrant"}
        ListElement {type: "Sextant"}
        ListElement {type: "Hexacontade"}
        ListElement {type: "Binary degree"}
        ListElement {type: "Grad"}
        ListElement {type: "Minute of arc"}
        ListElement {type: "Second of arc"}
    }
    ListModel {
        id: areaModel
    }
    ListModel {
        id: dataTransferRateModel
    }
    ListModel {
        id: digitalStoreageModel
    }
    ListModel {
        id: durationModel
    }
    ListModel {
        id: energyModel
    }
    ListModel {
        id: forceModel
    }
    ListModel {
        id: frequencyModel
    }
    ListModel {
        id: lengthModel
    }
    ListModel {
        id: massModel
    }
    ListModel {
        id: powerModel
    }
    ListModel {
        id: pressureModel
    }
    ListModel {
        id: speedModel
    }
    ListModel {
        id: temperatureModel
    }
    ListModel {
        id: volumeModel
    }

    function determineModel(type) {
        var fromModel;
        switch(type){
        case "Angle":
            fromModel = angleModel;
            break;
        case "Area":
            fromModel = areaModel;
            break;
        case "Data Transfer Rate":
            fromModel = dataTransferRateModel;
            break;
        case "Digital Storage":
            fromModel = digitalStoreageModel;
            break;
        case "Duration":
            fromModel = durationModel;
            break;
        case "Energy":
            fromModel = energyModel;
            break;
        case "Force":
            fromModel = forceModel;
            break;
        case "Frequency":
            fromModel = frequencyModel;
            break;
        case "Length":
            fromModel = lengthModel;
            break;
        case "Mass":
            fromModel = massModel;
            break;
        case "Power":
            fromModel = powerModel;
            break;
        case "Pressure":
            fromModel = pressureModel;
            break;
        case "Speed":
            fromModel = speedModel;
            break;
        case "Temperature":
            fromModel = temperatureModel;
            break;
        case "Volume":
            fromModel = volumeModel;
            break;
        default:
            fromModel = angleModel;
        }
        return fromModel;
    }

    function append(text){
        if (text === "DEL") {
            var index = conversionPage.inputField.cursorPosition;
            if (index === 0)
                return;
            conversionPage.inputField.remove(index - 1, index);
            return;
        }
        conversionPage.inputField.insert(conversionPage.inputField.cursorPosition,text);
    }

    function clear(){
        conversionPage.inputField.clear();
    }
}
