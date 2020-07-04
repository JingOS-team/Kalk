/*
 * This file is part of Kalk
 * Copyright (C) 2020 Han Young <hanyoung@protonmail.com>
 *
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 */
import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.12 as Kirigami

Kirigami.ScrollablePage {
    title: i18n("History")
    Button {
        id: clearHistoryBtn
        enabled: listView.count !== 0
        anchors.right: parent.right
        text: i18n("Clear History")
        icon.name: "edit-clear-history"
        width: root.width / 4
        height: root.height / 20
//        contentItem: Text {
//            text: clearHistoryBtn.text
//            opacity: enabled ? 1 : 0.3
//            font.pointSize: root.height / 72
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter
//        }

//        background: Rectangle {
//            border.color: Kirigami.Theme.activeBackgroundColor
//            border.width: root.height / 144
//            color: "transparent"
//            radius: root.height / 10
//            opacity: enabled ? 1 : 0.3
//        }

        onClicked: historyManager.clearHistory()
    }

    ListView{
        id: listView
        model: historyManager
        delegate: Text {
            width: parent.width
            font.pointSize: root.height / 36
            color: Kirigami.Theme.activeTextColor
            text: model.display
            wrapMode: Text.Wrap
        }
    }
}
