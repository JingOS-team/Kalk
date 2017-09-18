import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0

IconButton {
    implicitHeight: 40
    implicitWidth: 40
    iconSize: 20
    iconColor: 'black'
    opacity: root.styles.secondaryTextOpacity
    hoverEnabled: true
    ToolTip.delay: 400
    ToolTip.timeout: 5000
    ToolTip.visible: hovered
}
