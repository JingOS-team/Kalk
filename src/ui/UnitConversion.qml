import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.11 as Kirigami

Kirigami.Page {
    id: conversionPage
    property var inputField: input
    title: i18n("Units Conversion")
    visible: false
    ColumnLayout {
        width: parent.width
        spacing: root.height / 36
        AutoResizeComboBox {
            id: unitTypeSelection
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: parent.width
            model: typeModel
            textRole: "name"
//            onCurrentTextChanged: {
//                fromComboBox.model = determineModel(currentText);
//                toComboBox.model = determineModel(currentText);
//                toComboBox.currentIndex = 1;
//            }
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
        height: parent.height * 0.7
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
    function areaConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Square Metre":
            fromToStandard = value;
            break;
        case "Square Centimetre":
            fromToStandard = value / 10000;
            break;
        case "Square Millimetre":
            fromToStandard = value / 1000000;
            break;
        case "Square Kilometre":
            fromToStandard = value * 1000000;
            break;
        case "Square Inch":
            fromToStandard = value * 0.00064516;
            break;
        case "Square Feet":
            fromToStandard = value * 0.09290304;
            break;
        case "Square Yard":
            fromToStandard = value * 0.83612736;
            break;
        case "Square Mile":
            fromToStandard = value * 2589988.110336;
            break;
        case "Hectare":
            fromToStandard = value * 10000;
            break;
        case "Acre":
            fromToStandard = value * 4046.856422;
            break;
        }
        switch(toUnit){
        case "Square Metre":
            return fromToStandard;
        case "Square Centimetre":
            return fromToStandard * 10000;
        case "Square Millimetre":
            return fromToStandard * 1000000;
        case "Square Kilometre":
            return fromToStandard / 1000000;
        case "Square Inch":
            return fromToStandard / 0.00064516;
        case "Square Feet":
            return fromToStandard / 0.09290304;
        case "Square Yard":
            return fromToStandard / 0.83612736;
        case "Square Mile":
            return fromToStandard / 2589988.110336;
        case "Hectare":
            return fromToStandard / 10000;
        case "Acre":
            return fromToStandard / 4046.856422;
        }
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
    function dataTransferRateConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "kb/s":
            fromToStandard = value * 1000;
            break;
        case "Mb/s":
            fromToStandard = value * 1000000;
            break;
        case "Gb/s":
            fromToStandard = value * 1000000000;
            break;
        case "Tb/s":
            fromToStandard = value * 1000000000000;
            break;
        case "kB/s":
            fromToStandard = value * 8000;
            break;
        case "MB/s":
            fromToStandard = value * 8000000;
            break;
        case "GB/s":
            fromToStandard = value * 8000000000;
            break;
        case "TB/s":
            fromToStandard = value * 8000000000000;
            break;
        case "bit/s":
            fromToStandard = value;
            break;
        case "B/s":
            fromToStandard = value * 8;
            break;
        case "KiB/s":
            fromToStandard = value * 8192;
            break;
        case "MiB/s":
            fromToStandard = value * 8388608;
            break;
        case "GiB/s":
            fromToStandard = value * 8589934592;
            break;
        case "TiB/s":
            fromToStandard = value * 8796093022208;
            break;
        }
        switch(toUnit){
        case "kb/s":
            return fromToStandard / 1000;

        case "Mb/s":
            return fromToStandard / 1000000;

        case "Gb/s":
            return fromToStandard / 1000000000;

        case "Tb/s":
            return fromToStandard / 1000000000000;

        case "kB/s":
            return fromToStandard / 8000;

        case "MB/s":
            return fromToStandard / 8000000;

        case "GB/s":
            return fromToStandard / 8000000000;

        case "TB/s":
            return fromToStandard / 8000000000000;

        case "bit/s":
            return fromToStandard;

        case "B/s":
            return fromToStandard / 8;

        case "KiB/s":
            return fromToStandard / 8192;

        case "MiB/s":
            return fromToStandard / 8388608;

        case "GiB/s":
            return fromToStandard / 8589934592;

        case "TiB/s":
            return fromToStandard / 8796093022208;

        }
    }
    ListModel {
        id: digitalStorageModel
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
    function digitalStorageConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Kilobit(kb)":
            fromToStandard = value * 1000;
            break;
        case "Megabit(Mb)":
            fromToStandard = value * 1000000;
            break;
        case "Gigabit(Gb)":
            fromToStandard = value * 1000000000;
            break;
        case "Terabit(Tb)":
            fromToStandard = value * 1000000000000;
            break;
        case "Kilobyte(kB)":
            fromToStandard = value * 8000;
            break;
        case "Megabyte(MB)":
            fromToStandard = value * 8000000;
            break;
        case "Gigabyte(GB)":
            fromToStandard = value * 8000000000;
            break;
        case "Terabyte(TB)":
            fromToStandard = value * 8000000000000;
            break;
        case "Bit(bit)":
            fromToStandard = value;
            break;
        case "Byte(B)":
            fromToStandard = value * 8;
            break;
        case "Kibibyte(KiB)":
            fromToStandard = value * 8192;
            break;
        case "Mebibyte(MiB)":
            fromToStandard = value * 8388608;
            break;
        case "Gibibyte(GiB)":
            fromToStandard = value * 8589934592;
            break;
        case "Tebibyte(TiB)":
            fromToStandard = value * 8796093022208;
            break;
        }
        switch(toUnit){
        case "Kilobit(kb)":
            return fromToStandard / 1000;

        case "Megabit(Mb)":
            return fromToStandard / 1000000;

        case "Gigabit(Gb)":
            return fromToStandard / 1000000000;

        case "Terabit(Tb)":
            return fromToStandard / 1000000000000;

        case "Kilobyte(kB)":
            return fromToStandard / 8000;

        case "Megabyte(MB)":
            return fromToStandard / 8000000;

        case "Gigabyte(GB)":
            return fromToStandard / 8000000000;

        case "Terabyte(TB)":
            return fromToStandard / 8000000000000;

        case "Bit(bit)":
            return fromToStandard;

        case "Byte(B)":
            return fromToStandard / 8;

        case "Kibibyte(KiB)":
            return fromToStandard / 8192;

        case "Mebibyte(MiB)":
            return fromToStandard / 8388608;

        case "Gibibyte(GiB)":
            return fromToStandard / 8589934592;

        case "Tebibyte(TiB)":
            return fromToStandard / 8796093022208;

        }
    }
    ListModel {
        id: durationModel
        ListElement {type: "Microsecond"}
        ListElement {type: "Millisecond"}
        ListElement {type: "Second"}
        ListElement {type: "Minute"}
        ListElement {type: "Hour"}
        ListElement {type: "Day"}
        ListElement {type: "Week"}
        ListElement {type: "Month"}
        ListElement {type: "Year"}
    }
    function durationConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Microsecond":
            fromToStandard = value / 1000000;
            break;
        case "Millisecond":
            fromToStandard = value / 1000;
            break;
        case "Second":
            fromToStandard = value;
            break;
        case "Minute":
            fromToStandard = value * 60;
            break;
        case "Hour":
            fromToStandard = value * 3600;
            break;
        case "Day":
            fromToStandard = value * 86400;
            break;
        case "Week":
            fromToStandard = value * 604800;
            break;
        case "Month":
            fromToStandard = value * 18144000;
            break;
        case "Year":
            fromToStandard = value * 6622560000;
            break;
        }
        switch(toUnit){
        case "Microsecond":
            return fromToStandard * 1000000;
        case "Millisecond":
            return fromToStandard * 1000;
        case "Second":
            return fromToStandard;
        case "Minute":
            return fromToStandard / 60;
        case "Hour":
            return fromToStandard / 3600;
        case "Day":
            return fromToStandard / 86400;
        case "Week":
            return fromToStandard / 604800;
        case "Month":
            return fromToStandard / 18144000;
        case "Year":
            return fromToStandard / 6622560000;
        }
    }
    ListModel {
        id: energyModel
        ListElement {type: "Joule"}
        ListElement {type: "kWh"}
        ListElement {type: "Calorie"}
        ListElement {type: "One ton of TNT"}
    }
    function energyConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Joule":
            fromToStandard = value;
            break;
        case "kWh":
            fromToStandard = value * 3600000;
            break;
        case "Calorie":
            fromToStandard = value *  4.184;
            break;
        case "One ton of TNT":
            fromToStandard = value * 4184000000000;
            break;
        }
        switch(toUnit){
        case "Joule":
            return fromToStandard;
        case "kWh":
            return fromToStandard / 3600000;
        case "Calorie":
            return fromToStandard /  4.184;
        case "One ton of TNT":
            return fromToStandard / 4184000000000;
        }
    }
    ListModel {
        id: forceModel
        ListElement {type: "Newton"}
        ListElement {type: "Pound force"}
    }
    function forceConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Newton":
            fromToStandard = value;
            break;
        case "Pound force":
            fromToStandard = value * 4.448222;
            break;
        }
        switch(toUnit){
        case "Joule":
            return fromToStandard;
        case "kWh":
            return fromToStandard / 4.448222;
        }
    }
    ListModel {
        id: frequencyModel
        ListElement {type: "Hertz"}
        ListElement {type: "Kilohertz"}
        ListElement {type: "Megahertz"}
        ListElement {type: "Gigahertz"}
    }
    function frequencyConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Hertz":
            fromToStandard = value;
            break;
        case "Kilohertz":
            fromToStandard = value * 1000;
            break;
        case "Megahertz":
            fromToStandard = value * 1000000;
            break;
        case "Gigahertz":
            fromToStandard = value * 1000000000;
            break;
        }
        switch(toUnit){
        case "Hertz":
            return fromToStandard;
        case "Kilohertz":
            return fromToStandard / 1000;
        case "Megahertz":
            return fromToStandard / 1000000;
        case "Gigahertz":
            return fromToStandard / 1000000000;
        }
    }
    ListModel {
        id: lengthModel
        ListElement {type: "Feet"}
        ListElement {type: "Inch"}
        ListElement {type: "Yard"}
        ListElement {type: "Mile"}
        ListElement {type: "Millimeter"}
        ListElement {type: "Centimeter"}
        ListElement {type: "Meter"}
        ListElement {type: "Kilometer"}
    }
    function lengthConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Feet":
            fromToStandard = value * 30.48;
            break;
        case "Inch":
            fromToStandard = value * 2.54;
            break;
        case "Yard":
            fromToStandard = value * 91.44;
            break;
        case "Mile":
            fromToStandard = value * 160934.4;
            break;
        case "Millimeter":
            fromToStandard = value / 10;
            break;
        case "Centimeter":
            fromToStandard = value;
            break;
        case "Meter":
            fromToStandard = value * 100;
            break;
        case "Kilometer":
            fromToStandard = value * 1000;
            break;
        }
        switch(toUnit){
        case "Feet":
            return fromToStandard / 30.48;
        case "Inch":
            return fromToStandard / 2.54;
        case "Yard":
            return fromToStandard / 91.44;
        case "Mile":
            return fromToStandard / 160934.4;
        case "Millimeter":
            return fromToStandard * 10;
        case "Centimeter":
            return fromToStandard;
        case "Meter":
            return fromToStandard / 100;
        case "Kilometer":
            return fromToStandard / 1000;
        }
    }
    ListModel {
        id: massModel
        ListElement {type: "Gram"}
        ListElement {type: "Kilogram"}
        ListElement {type: "Ton"}
        ListElement {type: "Long ton"}
        ListElement {type: "Ounce"}
        ListElement {type: "Pound"}
        ListElement {type: "Stone"}
    }
    function massConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Gram":
            fromToStandard = value;
            break;
        case "Kilogram":
            fromToStandard = value * 1000;
            break;
        case "Ton":
            fromToStandard = value * 1000000;
            break;
        case "Long ton":
            fromToStandard = value * 1016047;
            break;
        case "Ounce":
            fromToStandard = value * 28.349523125;
            break;
        case "Pound":
            fromToStandard = value * 453.59237;
            break;
        case "Stone":
            fromToStandard = value * 6350;
            break;
        }
        switch(toUnit){
        case "Gram":
            return fromToStandard;
        case "Kilogram":
            return fromToStandard / 1000;
        case "Ton":
            return fromToStandard / 1000000;
        case "Long ton":
            return fromToStandard / 1016047;
        case "Ounce":
            return fromToStandard / 28.349523125;
        case "Pound":
            return fromToStandard / 453.59237;
        case "Stone":
            return fromToStandard / 6350;
        }
    }
    ListModel {
        id: powerModel
        ListElement {type: "Watt"}
        ListElement {type: "HP(Metric)"}
        ListElement {type: "Kilowatt"}
        ListElement {type: "Megawatt"}
        ListElement {type: "Gigawatt"}
    }
    function powerConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Watt":
            fromToStandard = value;
            break;
        case "HP(Metric)":
            fromToStandard = value * 735.49875;
            break;
        case "Kilowatt":
            fromToStandard = value * 1000;
            break;
        case "Megawatt":
            fromToStandard = value * 1000000;
            break;
        case "Gigawatt":
            fromToStandard = value * 1000000000;
            break;
        }
        switch(toUnit){
        case "Watt":
            return fromToStandard;
        case "HP(Metric)":
            return fromToStandard / 735.49875;
        case "Kilowatt":
            return fromToStandard / 1000;
        case "Megawatt":
            return fromToStandard / 1000000;
        case "Gigawatt":
            return fromToStandard / 1000000000;
        }
    }
    ListModel {
        id: pressureModel
        ListElement {type: "Atmospheres"}
        ListElement {type: "Pa"}
        ListElement {type: "mmHg"}
        ListElement {type: "mmH2O"}
    }
    function pressureConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Atmospheres":
            fromToStandard = value * 101325;
            break;
        case "Pa":
            fromToStandard = value;
            break;
        case "mmHg":
            fromToStandard = value * 133.322368421053;
            break;
        case "mmH2O":
            fromToStandard = value * 9.80665;
            break;
        }
        switch(toUnit){
        case "Atmospheres":
            return fromToStandard / 101325;
        case "Pa":
            return fromToStandard;
        case "mmHg":
            return fromToStandard / 133.322368421053;
        case "mmH2O":
            return fromToStandard / 9.80665;
        }
    }
    ListModel {
        id: speedModel
        ListElement {type: "Metres/second"}
        ListElement {type: "Miles/hour"}
        ListElement {type: "Kilometres/hour"}
        ListElement {type: "Knot"}
    }
    function speedConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Metres/second":
            fromToStandard = value / 3.6;
            break;
        case "Miles/hour":
            fromToStandard = value * 1.609344;
            break;
        case "Kilometres/hour":
            fromToStandard = value;
            break;
        case "Knot":
            fromToStandard = value * 1.852;
            break;
        }
        switch(toUnit){
        case "Metres/second":
            return fromToStandard * 3.6;
        case "Miles/hour":
            return fromToStandard / 1.609344;
        case "Kilometres/hour":
            return fromToStandard;
        case "Knot":
            return fromToStandard / 1.852;
        }
    }
    ListModel {
        id: temperatureModel
        ListElement {type: "Celsius"}
        ListElement {type: "Fahrenheit"}
        ListElement {type: "Kelvin"}
    }
    function temperatureConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "Celsius":
            fromToStandard = value;
            break;
        case "Fahrenheit":
            fromToStandard = (value - 32) / 1.8;
            break;
        case "Kelvin":
            fromToStandard = value - 273.15;
            break;
        }
        switch(toUnit){
        case "Celsius":
            return fromToStandard;
        case "Fahrenheit":
            return fromToStandard * 1.8 + 32;
        case "Kelvin":
            return fromToStandard + 273.15;
        }
    }
    ListModel {
        id: volumeModel
        ListElement {type: "mL"}
        ListElement {type: "Litre"}
        ListElement {type: "Cubic Metre"}
        ListElement {type: "US Gallon"}
        ListElement {type: "Imperial Gallon"}
        ListElement {type: "US Pint"}
        ListElement {type: "Imperial Pint"}
        ListElement {type: "US Quart"}
        ListElement {type: "Imperial Quart"}
        ListElement {type: "US Ounce"}
        ListElement {type: "Imperial Ounce"}
    }
    function volumeConverter(fromUnit, value, toUnit) {
        var fromToStandard;
        switch(fromUnit){
        case "mL":
            fromToStandard = value;
            break;
        case "Litre":
            fromToStandard = value * 1000;
            break;
        case "Cubic Metre":
            fromToStandard = value * 1000000;
            break;
        case "US Gallon":
            fromToStandard = value * 3785;
            break;
        case "Imperial Gallon":
            fromToStandard = value * 4546;
            break;
        case "US Pint":
            fromToStandard = value * 473;
            break;
        case "Imperial Pint":
            fromToStandard = value * 568;
            break;
        case "US Quart":
            fromToStandard = value * 946;
            break;
        case "Imperial Quart":
            fromToStandard = value * 1137;
            break;
        case "US Ounce":
            fromToStandard = value * 29.5735295625;
            break;
        case "Imperial Ounce":
            fromToStandard = value * 28.4130625;
            break;
        }
        switch(toUnit){
        case "mL":
            return fromToStandard ;
        case "Litre":
            return fromToStandard / 1000;
        case "Cubic Metre":
            return fromToStandard / 1000000;
        case "US Gallon":
            return fromToStandard / 3785;
        case "Imperial Gallon":
            return fromToStandard / 4546;
        case "US Pint":
            return fromToStandard / 473;
        case "Imperial Pint":
            return fromToStandard / 568;
        case "US Quart":
            return fromToStandard / 946;
        case "Imperial Quart":
            return fromToStandard / 1137;
        case "US Ounce":
            return fromToStandard / 29.5735295625;
        case "Imperial Ounce":
            return fromToStandard / 28.4130625;
        }
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
            fromModel = digitalStorageModel;
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
            return areaConverter(fromUnit, value, toUnit);
        case "Data Transfer Rate":
            return dataTransferRateConverter(fromUnit, value, toUnit);
        case "Digital Storage":
            return digitalStorageConverter(fromUnit, value, toUnit);
        case "Duration":
            return durationConverter(fromUnit, value, toUnit);
        case "Energy":
            return energyConverter(fromUnit, value, toUnit);
        case "Force":
            return forceConverter(fromUnit, value, toUnit);
        case "Frequency":
            return frequencyConverter(fromUnit, value, toUnit);
        case "Length":
            return lengthConverter(fromUnit, value, toUnit);
        case "Mass":
            return massConverter(fromUnit, value, toUnit);
        case "Power":
            return powerConverter(fromUnit, value, toUnit);
        case "Pressure":
            return pressureConverter(fromUnit, value, toUnit);
        case "Speed":
            return speedConverter(fromUnit, value, toUnit);
        case "Temperature":
            return temperatureConverter(fromUnit, value, toUnit);
        case "Volume":
            return volumeConverter(fromUnit, value, toUnit);
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
