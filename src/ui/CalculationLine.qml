import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0
import Fluid.Material 1.0


Column {
    width: parent.width
    padding: Units.smallSpacing
    spacing: Units.smallSpacing

    Row {
        width: parent.width
        height: formulaEdit.height
        spacing: Units.smallSpacing

            TextEdit {
                id: formulaEdit
                text: formula
                width: (root.advancedWidth - 3 * Units.smallSpacing) * 2/3
                font.pointSize: root.styles.advancedFontSize
                opacity: root.styles.secondaryTextOpacity
                selectByMouse: true
                wrapMode: TextEdit.WrapAnywhere
                onTextChanged: {
                    formula = text;
                    var calculations = [];
                    for (var i=0; i<calculationsRepeater.model.count; i++) {
                        calculations.push(calculationsRepeater.model.get(i).formula);
                    }
                    var results = calculate(calculations, true);
                    for (var i=0; i<calculationsRepeater.model.count; i++) {
                        calculationsRepeater.model.setProperty( i, 'result', results[i] + '');
                    }
                    syncTextDocument();
                }
                Keys.onReturnPressed: {
                    calculationsRepeater.model.insert(index + 1,{ formula: '', result: '' });
                    setFocusAt(index + 1);
                    if (index + 2 === calculationsRepeater.model.count && advancedView.contentHeight >= advancedView.height) {
                        advancedView.contentY = advancedView.contentHeight - advancedView.height;
                    }
                }
                Keys.onDownPressed: {
                    if (index < calculationsRepeater.model.count - 1) {
                        setFocusAt(index + 1)
                    }
                }
                Keys.onUpPressed: {
                    if (index > 0) {
                        setFocusAt(index - 1)
                    }
                }
                Keys.onPressed: {
                    if (index > 0 && event.key === Qt.Key_Backspace && text === '') {
                        setFocusAt(index - 1);
                        calculationsRepeater.model.remove(index, 1);
                    }
                }
            }

            Text {
                text: result
                height: formulaEdit.height
                opacity: root.styles.primaryTextOpacity
                width: (root.advancedWidth - 3 * Units.smallSpacing) * 1/3
                font.pointSize: root.styles.advancedFontSize
                horizontalAlignment: Text.AlignRight
                clip: true
                wrapMode: TextEdit.NoWrap
                verticalAlignment: Qt.AlignBottom
            }
    }

    Rectangle {
        width: parent.width - 2 * Units.smallSpacing
        height: 1
        color: 'black'
        opacity: 0.1
    }
}
