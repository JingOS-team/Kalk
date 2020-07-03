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
            onCurrentIndexChanged: {
                input.text = "";
                output.text = "";
                typeModel.currentIndex(currentIndex);
            }
        }
        Kirigami.Separator {}
        ColumnLayout {
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
                        if(text != "") {
                            output.text = unitModel.getRet(Number(text), fromComboBox.currentIndex, toComboBox.currentIndex);
                            output.cursorPosition = 0; // force align left
                        }
                    }
                }
                AutoResizeComboBox {
                    id: fromComboBox
                    Layout.fillWidth: parent.width
                    model: unitModel
                    textRole: "name"
                    currentIndex: 0
                    onCurrentIndexChanged: {
                        if(input.text != "") {
                            output.text = unitModel.getRet(Number(input.text), fromComboBox.currentIndex, toComboBox.currentIndex);
                            output.cursorPosition = 0; // force align left
                        }
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
                    Layout.fillWidth: parent.width
                    model: unitModel
                    textRole: "name"
                    currentIndex: 1
                    onCurrentIndexChanged: {
                        if(input.text != "") {
                            output.text = unitModel.getRet(Number(input.text), fromComboBox.currentIndex, toComboBox.currentIndex);
                            output.cursorPosition = 0; // force align left
                        }
                    }
                }
            }
        }
    }
    NumericInputPad {
        height: parent.height * 0.6
        width: parent.width
        anchors.bottom: parent.bottom
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
