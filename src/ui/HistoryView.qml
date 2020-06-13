import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.12 as Kirigami

Kirigami.ScrollablePage {
    title: i18n("history")
    Button {
        id: clearHistoryBtn
        enabled: listView.count !== 0
        anchors.right: parent.right
        text: i18n("Clear History")
        width: root.width / 4
        height: root.height / 20
        contentItem: Text {
            text: clearHistoryBtn.text
            opacity: enabled ? 1 : 0.3
            font.pointSize: root.height / 72
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            border.color: Kirigami.Theme.activeBackgroundColor
            border.width: root.height / 144
            radius: root.height / 10
            opacity: enabled ? 1 : 0.3
        }

        onClicked: historyManager.clearHistory()
    }

    ListView{
        id: listView
        model: historyManager
        delegate: Text {
            width: parent.width
            font.pointSize: root.height / 36
            text: model.display
            wrapMode: Text.Wrap
        }
    }
}
