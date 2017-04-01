import QtQuick 2.7

Item {
    Shortcut {
        sequence: "Ctrl+D"
        onActivated: {
            if (!advanced) {
                setAdvanced(true)
            }
        }
    }

    Shortcut {
        sequence: "Ctrl+S"
        onActivated: saveFile()
    }

    Shortcut {
        sequence: "Ctrl+O"
        onActivated: openFile()
    }

    Shortcut {
        sequence: "Ctrl+H"
        onActivated: toogleHistory()
        enabled: !advanced
    }

    Shortcut {
        sequence: "Ctrl+E"
        onActivated: toogleExpanded()
        enabled: !advanced
    }
}
