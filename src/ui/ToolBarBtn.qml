import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1 as Controls
import org.kde.kirigami 2.11 as Kirigami

Controls.ToolButton {
    property var page: initialPage
    id: btn
    autoExclusive: true
    text: ''
    checkable: true
    contentItem: Text {
        text: btn.text
        font.bold: true
        color: Kirigami.Theme.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    onCheckedChanged: {
        if(checked){
            switchToPage(page)
            btn.contentItem.color = Kirigami.Theme.activeTextColor
        }
        else {
            btn.contentItem.color = Kirigami.Theme.textColor
        }
    }
}
