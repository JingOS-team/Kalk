import QtQuick 2.0
import org.kde.kirigami 2.11 as Kirigami
import QtQuick.Controls 2.1 as Controls
import QtQuick.Layouts 1.1
Item {
    ButtonsView {
        id: numericPad
        width: parent.width
        labels: ['7', '8', '9', '4', '5', '6', '1', '2', '3', '0', '.', 'C']
        targets: ['7', '8', '9', '4', '5', '6', '1', '2', '3', '0', '.', 'DEL']
        onButtonClicked: conversionPage.append(strToAppend);
        onButtonLongPressed: conversionPage.clear();
    }
    // Don't know why we need this, but otherwise program crashes
    ButtonsView {
        visible: false
        labels: ['','','','','','','','','','','','','','','']
    }
}


