import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
// import Fluid.Controls 1.0 as FluidControls

ToolButton {
    implicitHeight: 40
    implicitWidth: 40
    icon.width: 20
    icon.height: 20
    icon.color: 'black'
    opacity: root.styles.secondaryTextOpacity
    hoverEnabled: true
    ToolTip.delay: 400
    ToolTip.timeout: 5000
    ToolTip.visible: hovered
}
