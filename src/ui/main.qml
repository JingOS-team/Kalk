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
    controlsVisible: false
    height: Kirigami.Units.gridUnit * 45
    width: Kirigami.Units.gridUnit * 27

    Kirigami.SwipeNavigator {
        anchors.fill: parent
        
        CalculationPage {}

        HistoryView {
            icon.name: "shallow-history"
            id: historyView
            visible: false
        }
        
        UnitConversion {
            icon.name: "gtk-convert"
            id: unitConversion
        }

        Kirigami.AboutPage {
            icon.name: "help-about"
            id: aboutPage
            visible: false
            title: i18n("About")
            aboutData: {
                "displayName": i18n("Calculator"),
                "productName": "kirigami/calculator",
                "componentName": "kalk",
                "shortDescription": i18n("Calculator built with Kirigami."),
                "homepage": "https://invent.kde.org/hanyoung/kalk",
                "bugAddress": "https://invent.kde.org/hanyoung/kalk",
                "version": "v0.1",
                "otherText": "",
                "copyrightStatement": i18n("© 2020 Plasma Development Team"),
                "desktopFileName": "org.kde.calculator",
                "authors": [
                            {
                                "name": i18n("Han Young"),
                                "emailAddress": "hanyoung@protonmail.com",
                            },
                            {
                                "name": i18n("cahfofpai"),
                            }
                        ],
                "licenses": [
                            {
                                "name": "GPL v3",
                                "text": "long, boring, license text",
                                "spdx": "GPL-v3.0",
                            }
                        ]
            }
        }

    }
}
