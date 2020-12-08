/*
 * This file is part of Kalk
 *
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
import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.13 as Kirigami

Kirigami.ScrollablePage {
    id: root
    title: i18n("Units Converter")

    Kirigami.CardsListView {
        id: typeView
        Loader {
            id: unitConvertorLoader
            source: "qrc:/qml/UnitConversion.qml"
        }
        topMargin: Kirigami.Units.gridUnit
        model: typeModel
        delegate: Kirigami.AbstractCard {
            id: listItem
            contentItem: Text {
                text: name
                color: Kirigami.Theme.textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
            }
            MouseArea {
                id: mouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    typeModel.currentIndex(index);
                    unitConvertorLoader.item["title"] = name;
                    applicationWindow().pageStack.layers.push(unitConvertorLoader.item);
                }
                onEntered: {
                    listItem.highlighted = true;
                }
                onExited: {
                    listItem.highlighted = false;
                }
            }
        }
    }
}
