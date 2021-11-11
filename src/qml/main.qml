
/*
 * This file is part of Kalk
 * Copyright (C) 2016 Pierre Jacquier <pierrejacquier39@gmail.com>
 * Copyright (C) 2020 Cahfofpai Han Young <hanyoung@protonmail.com>
 *               2021 Bob <pengbo·wu@jingos.com>
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

import org.kde.kirigami 2.15 as Kirigami
import jingos.display 1.0

Kirigami.ApplicationWindow {
    id: appWindow

    title: 'JingOS Calc'
    visible: true

    property real appScale: JDisplay.dp(1.0)
    property real appFontSize: JDisplay.sp(1.0)
    property int fontSize: 14 * appFontSize
    property int officalWidth: 1920
    property int officalHeight: 1200
    property int deviceWidth: 1954
    property int deviceHeight: 1303
    property real officalScale: appScale

    onVisibleChanged: {
        appWindow.globalToolBarStyle = ApplicationHeaderStyle.None
    }

    pageStack.initialPage: jingCalculationPage

    width: deviceWidth
    height: deviceHeight

    readonly property bool inPortrait: appWindow.width < appWindow.height

    JingCalculationPage {
        id: jingCalculationPage

        objectName: "calculation"
        visible: true
    }
}
