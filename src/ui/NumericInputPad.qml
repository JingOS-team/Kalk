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


