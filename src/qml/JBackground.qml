/*
 * Copyright (C) 2021 Beijing Jingling Information System Technology Co., Ltd. All rights reserved.
 *
 * Authors:
 * Bob <pengbo·wu@jingos.com>
 *
 */
import QtQuick 2.0
import QtGraphicalEffects 1.12

Rectangle {
    id: root

    anchors.fill: parent

    Image {
        id: backImage

        width: parent.width
        height: parent.height

        visible: false
        smooth: true
    }
    FastBlur {
        anchors.fill: backImage
        source: backImage
        radius: 128
    }
    Rectangle {
        color: "#ddffffff"
        width: parent.width
        height: parent.height
    }
}

