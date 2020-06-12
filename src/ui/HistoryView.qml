import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.12 as Kirigami

Kirigami.ScrollablePage {
    title: i18n("history")
    Button {
        id: clearHistoryBtn
        anchors.right: parent.right
        text: i18n("Clear History")
        onClicked: historyManager.clearHistory()
    }

    ListView{
        model: historyManager
        delegate: Label {
            font.pointSize: root.height / 36
            text: model.display
        }
    }
}
