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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import org.kde.kirigami 2.13 as Kirigami
Column {
    width: root.width
    padding: smallSpacing
    spacing: smallSpacing

    Row {
        width: parent.width
        height: formulaEdit.height
        spacing: smallSpacing

        TextEdit {
            id: formulaEdit
            text: formula
            width: (root.width - 3 * smallSpacing) * 2/3
            font.pointSize: root.height / 9
            opacity: 1
            selectByMouse: true
            wrapMode: TextEdit.WrapAnywhere
            Text {
                id: formulaResult
                text: hasError ? i18n("Error") : formula === '' ? '' : result
                color: hasError ? 'red' : 'black'
                height: formulaEdit.height
                opacity: hasError ? root.styles.hintTextOpacity : root.styles.primaryTextOpacity
                width: (root.width - 3 * smallSpacing) * 1/3
                font.pointSize: root.height / 9
                horizontalAlignment: Text.AlignRight
                clip: true
                wrapMode: TextEdit.NoWrap
                font.italic: hasError
                verticalAlignment: Qt.AlignBottom

                property bool hasError: result === 'undefined' && formula !== ''

                MouseArea {
                    visible: parent.hasError
                    enabled: parent.hasError
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: snackBar.open(root.lastError)
                }
            }
        }

        Rectangle {
            width: root.width - 2 * smallSpacing
            height: 1
            color: formulaResult.hasError ? 'red' : 'black'
            opacity: 0.1
        }
    }
}
