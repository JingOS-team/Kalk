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
                toComboBox.currentIndex = 1;
            }
        }
        Kirigami.Separator {}
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            ColumnLayout {
                Controls.TextField {
                    id: input
                    Layout.preferredHeight: root.height / 16
                    Layout.preferredWidth: root.width * 0.4
                    font.pointSize: root.height / 36
                    Kirigami.Theme.colorSet: Kirigami.Theme.Selection
                    color: Kirigami.Theme.activeTextColor
                    wrapMode: TextInput.WrapAnywhere
                    validator: DoubleValidator{}
                    focus: true
                    onTextChanged: {
                        output.text = converter(unitTypeSelection.currentText, fromComboBox.currentText, toComboBox.currentText, parseFloat(input.text));
                        output.cursorPosition = 0; // force align left
                    }
                }
                AutoResizeComboBox {
                    id: fromComboBox
                    model: angleModel
                    textRole: "type"
                    currentIndex: 0
                    onCurrentTextChanged: {
                        output.text = converter(unitTypeSelection.currentText, fromComboBox.currentText, toComboBox.currentText, parseFloat(input.text));
                        output.cursorPosition = 0; // force align left
                    }
                }
            }

            ColumnLayout {
                Controls.TextField {
                    id: output
                    Layout.preferredHeight: root.height / 16
                    Layout.preferredWidth: root.width * 0.4
                    font.pointSize: root.height / 36
                    readOnly: true
                    Kirigami.Theme.colorSet: Kirigami.Theme.Selection
                    color: Kirigami.Theme.activeTextColor
                    validator: DoubleValidator{}
                }
                AutoResizeComboBox {
                    id: toComboBox
                    model: angleModel
                    textRole: "type"
                    currentIndex: 1
                    onCurrentTextChanged: {
                        output.text = converter(unitTypeSelection.currentText, fromComboBox.currentText, toComboBox.currentText, parseFloat(input.text));
                        output.cursorPosition = 0; // force align left
                    }
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
        ListElement {type: "Radian";}
        ListElement {type: "Degree";}
        ListElement {type: "Turn";}
        ListElement {type: "π"}
        ListElement {type: "Binary degree"}
        ListElement {type: "Grad"}
        ListElement {type: "Minute of arc"}
        ListElement {type: "Second of arc"}
    }
    function angleConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Radian":
            fromToStandard = value * 57.29577951308;
            break;
        case "Degree":
            fromToStandard = value;
            break;
        case "Turn":
            fromToStandard = value * 360;
            break;
        case "π":
            fromToStandard = value * 180;
            break;
        case "Binary degree":
            fromToStandard = value * 1.40625;
            break;
        case "Grad":
            fromToStandard = value * 0.9;
            break;
        case "Minute of arc":
            fromToStandard = value * 0.0166666666666;
            break;
        case "Second of arc":
            fromToStandard = value * 0.0016666666666;
            break;
        }
        switch(toUnit){
        case "Radian":
            return fromToStandard / 57.29577951308;
        case "Degree":
            return fromToStandard;
        case "Turn":
            return fromToStandard / 360;
        case "π":
            return fromToStandard / 180;
        case "Binary degree":
            return fromToStandard / 1.40625;
        case "Grad":
            return fromToStandard / 0.9;
        case "Minute of arc":
            return fromToStandard / 0.0166666666666;
        case "Second of arc":
            return fromToStandard / 0.0016666666666;
        }
    }

    ListModel {
        id: areaModel
        ListElement {type: "Square Metre"}
        ListElement {type: "Square Centimetre"}
        ListElement {type: "Square Millimetre"}
        ListElement {type: "Square Kilometre"}
        ListElement {type: "Square Inch"}
        ListElement {type: "Square Feet"}
        ListElement {type: "Square Yard"}
        ListElement {type: "Square Mile"}
        ListElement {type: "Hectare"}
        ListElement {type: "Acre"}
    }
    ListModel {
        id: dataTransferRateModel
        ListElement {type: "kb/s"}
        ListElement {type: "Mb/s"}
        ListElement {type: "Gb/s"}
        ListElement {type: "Tb/s"}
        ListElement {type: "kB/s"}
        ListElement {type: "MB/s"}
        ListElement {type: "GB/s"}
        ListElement {type: "TB/s"}
        ListElement {type: "bit/s"}
        ListElement {type: "B/s"}
        ListElement {type: "KiB/s"}
        ListElement {type: "MiB/s"}
        ListElement {type: "GiB/s"}
        ListElement {type: "TiB/s"}
    }
    ListModel {
        id: digitalStoreageModel
        ListElement {type: "Kilobit(kb)"}
        ListElement {type: "Megabit(Mb)"}
        ListElement {type: "Gigabit(Gb)"}
        ListElement {type: "Terabit(Tb)"}
        ListElement {type: "Kilobyte(kB)"}
        ListElement {type: "Megabyte(MB)"}
        ListElement {type: "Gigabyte(GB)"}
        ListElement {type: "Terabyte(TB)"}
        ListElement {type: "Bit(bit)"}
        ListElement {type: "Byte(B)"}
        ListElement {type: "Kibibyte(KiB)"}
        ListElement {type: "Mebibyte(MiB)"}
        ListElement {type: "Gibibyte(GiB)"}
        ListElement {type: "Tebibyte(TiB)"}
    }
    ListModel {
        id: durationModel
        ListElement {type: "Picosecond"}
        ListElement {type: "Nanosecond"}
        ListElement {type: "Microsecond"}
        ListElement {type: "Millisecond"}
        ListElement {type: "Second"}
        ListElement {type: "Minute"}
        ListElement {type: "Hour"}
        ListElement {type: "Day"}
        ListElement {type: "Week"}
        ListElement {type: "Fortnight"}
        ListElement {type: "Month"}
        ListElement {type: "Year"}
        ListElement {type: "Decade"}
        ListElement {type: "Century"}
        ListElement {type: "Millennium"}
    }
    ListModel {
        id: energyModel
        ListElement {type: "BTU"}
        ListElement {type: "Calorie"}
        ListElement {type: "Celsius heat unit"}
        ListElement {type: "Joule"}
        ListElement {type: "Horsepower-hour"}
    }
    ListModel {
        id: forceModel
        ListElement {type: "Newton"}
        ListElement {type: "Kilo Newton"}
        ListElement {type: "Pound force"}
    }
    ListModel {
        id: frequencyModel
        ListElement {type: "Hertz"}
        ListElement {type: "Kilohertz"}
        ListElement {type: "Megahertz"}
        ListElement {type: "Gigahertz"}
        ListElement {type: "Petahertz"}
        ListElement {type: "Terahertz"}
    }
    ListModel {
        id: lengthModel
        ListElement {type: "Feet"}
        ListElement {type: "Inch"}
        ListElement {type: "Millimeter"}
        ListElement {type: "Centimeter"}
        ListElement {type: "Meter"}
        ListElement {type: "Kilometer"}
        ListElement {type: "Mile"}
        ListElement {type: "Yard"}
        ListElement {type: "Light year"}
        ListElement {type: "Micrometer"}
        ListElement {type: "Nanometer"}
        ListElement {type: "Picometer"}
    }
    ListModel {
        id: massModel
        ListElement {type: "Gram"}
        ListElement {type: "Kilogram"}
        ListElement {type: "Ton"}
        ListElement {type: "Milligram"}
        ListElement {type: "Microgram"}
        ListElement {type: "Long ton"}
        ListElement {type: "Ounce"}
        ListElement {type: "Pound"}
        ListElement {type: "Stone"}
    }
    ListModel {
        id: powerModel
        ListElement {type: "Watt"}
        ListElement {type: "HP"}
        ListElement {type: "Kilowatt"}
        ListElement {type: "Megawatt"}
        ListElement {type: "Gigawatt"}
        ListElement {type: "Terawatt"}
    }
    ListModel {
        id: pressureModel
        ListElement {type: "Atmospheres"}
        ListElement {type: "mmHg"}
        ListElement {type: "mmH2O"}
    }
    ListModel {
        id: speedModel
        ListElement {type: "Miles/hour"}
        ListElement {type: "Kilometres/hour"}
        ListElement {type: "Knot"}
        ListElement {type: "Metres/second"}
    }
    ListModel {
        id: temperatureModel
        ListElement {type: "Celsius"}
        ListElement {type: "Fahrenheit"}
        ListElement {type: "Kelvin"}
    }
    ListModel {
        id: volumeModel
        ListElement {type: "Litre"}
        ListElement {type: "Millilitre"}
        ListElement {type: "US Gallon"}
        ListElement {type: "Imperial Gallon"}
        ListElement {type: "US Pint"}
        ListElement {type: "US Quart"}
        ListElement {type: "Imperial Quart"}
        ListElement {type: "US Ounce"}
        ListElement {type: "Imperial Ounce"}
        ListElement {type: "Cubic Centimeter"}
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

    function converter(unitType, fromUnit, toUnit, value) {
        switch(unitType){
        case "Angle":
            return angleConverter(fromUnit, value, toUnit);
        case "Area":
            return angleConverter(fromUnit, value, toUnit);
        case "Data Transfer Rate":
            return angleConverter(fromUnit, value, toUnit);
        case "Digital Storage":
            return angleConverter(fromUnit, value, toUnit);
        case "Duration":
            return angleConverter(fromUnit, value, toUnit);
        case "Energy":
            return angleConverter(fromUnit, value, toUnit);
        case "Force":
            return angleConverter(fromUnit, value, toUnit);
        case "Frequency":
            return angleConverter(fromUnit, value, toUnit);
        case "Length":
            return angleConverter(fromUnit, value, toUnit);
        case "Mass":
            return angleConverter(fromUnit, value, toUnit);
        case "Power":
            return angleConverter(fromUnit, value, toUnit);
        case "Pressure":
            return angleConverter(fromUnit, value, toUnit);
        case "Speed":
            return angleConverter(fromUnit, value, toUnit);
        case "Temperature":
            return angleConverter(fromUnit, value, toUnit);
        case "Volume":
            return angleConverter(fromUnit, value, toUnit);
        default:
            fromModel = angleModel;
        }
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
