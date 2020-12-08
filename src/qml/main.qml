/*
 * This file is part of Kalk
 * Copyright (C) 2016 Pierre Jacquier <pierrejacquier39@gmail.com>
 *
 *               2020 Cahfofpai
 *                    Han Young <hanyoung@protonmail.com>
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
import QtQuick.Controls 2.1 as Controls
import Qt.labs.platform 1.0
import Qt.labs.settings 1.0
import org.kde.kirigami 2.13 as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: 'Kalk'
    visible: true
    height: Kirigami.Units.gridUnit * 30
    width: Kirigami.Units.gridUnit * 20
    readonly property int columnWidth: Kirigami.Units.gridUnit * 13
    wideScreen: width > columnWidth * 3

    function switchToPage(page) {
        while (pageStack.depth > 0) pageStack.pop();
        pageStack.push(page);
    }

    Kirigami.PagePool {
        id: mainPagePool
    }

    globalDrawer: Kirigami.GlobalDrawer {
        isMenu: true
        actions: [
            Kirigami.PagePoolAction {
                text: i18n("Calculator")
                iconName: "accessories-calculator"
                pagePool: mainPagePool
                page: "qrc:/qml/CalculationPage.qml"
            },
            Kirigami.PagePoolAction {
                text: i18n("History")
                iconName: "shallow-history"
                page: "qrc:/qml/HistoryView.qml"
                pagePool: mainPagePool
            },
            Kirigami.PagePoolAction {
                text: i18n("Convertor")
                iconName: "gtk-convert"
                page: "qrc:/qml/UnitTypeGrid.qml"
                pagePool: mainPagePool
            },
            Kirigami.PagePoolAction {
                text: i18n("About")
                iconName: "help-about"
                page: "qrc:/qml/AboutPage.qml"
                pagePool: mainPagePool
            }
        ]
    }

    pageStack.initialPage: mainPagePool.loadPage("qrc:/qml/CalculationPage.qml")
}
