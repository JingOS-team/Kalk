/*
 * This file is part of Kalk
 * Copyright (C) 2020 Han Young <hanyoung@protonmail.com>
 *                    cahfofpai
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
    Kirigami.PlaceholderMessage {
        anchors.centerIn: parent
        text: i18n("History is empty")
        visible: listView.count == 0
    }
    actions {
        main: Kirigami.Action {
            iconName: "edit-clear-history"
            text: i18n("Clear history")
            onTriggered: historyManager.clearHistory();
        }
    }

    ListView{
        id: listView
        Layout.fillWidth: true
        model: historyManager
        delegate: Kirigami.AbstractListItem {
            highlighted: false
            Text {
                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
                color: Kirigami.Theme.activeTextColor
                text: model.display
                wrapMode: Text.Wrap
            }
        }
    }
}
