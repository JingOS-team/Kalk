import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Column {
    width: root.width
    padding: smallSpacing
    spacing: smallSpacing

    Row {
        width: parent.width
        height: formulaEdit.height
        spacing: smallSpacing

            TextEdit {
                id: formulaEdit
                text: formula
                width: (root.width - 3 * smallSpacing) * 2/3
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
                    switch (event.key) {
                        case Qt.Key_Enter:
                        case Qt.Key_Return:
                            event.accepted = true;
                            calculationsRepeater.model.insert(index + 1,{ formula: '', result: '' });
                            setFocusAt(index + 1);
                            if (index + 2 === calculationsRepeater.model.count && advancedView.contentHeight >= advancedView.height) {
                                advancedView.contentY = advancedView.contentHeight - advancedView.height;
                            }
                            break;
                        case Qt.Key_Backspace:
                            if (index > 0 && event.key === Qt.Key_Backspace && text === '') {
                                setFocusAt(index - 1);
                                calculationsRepeater.model.remove(index, 1);
                            }
                            break;
                        default: return;
                    }
                }
            }

            Text {
                id: formulaResult
                text: hasError ? qsTr('Error') : formula === '' ? '' : result
                color: hasError ? 'red' : 'black'
                height: formulaEdit.height
                opacity: hasError ? root.styles.hintTextOpacity : root.styles.primaryTextOpacity
                width: (root.width - 3 * smallSpacing) * 1/3
                font.pointSize: root.styles.advancedFontSize
                horizontalAlignment: Text.AlignRight
                clip: true
                wrapMode: TextEdit.NoWrap
                font.italic: hasError
                verticalAlignment: Qt.AlignBottom

                property bool hasError: result === 'undefined' && formula !== ''

                MouseArea {
                    visible: parent.hasError
                    enabled: parent.hasError
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: snackBar.open(root.lastError)
                }
            }
    }

    Rectangle {
        width: root.width - 2 * smallSpacing
        height: 1
        color: formulaResult.hasError ? 'red' : 'black'
        opacity: 0.1
    }
}
