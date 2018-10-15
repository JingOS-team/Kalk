import qbs 1.0

QtGuiApplication {
    readonly property bool isBundle: qbs.targetOS.contains("darwin") && bundle.isBundle

    name: "liri-calculator"
    consoleApplication: false

    Depends { name: "lirideployment" }
    Depends { name: "Qt"; submodules: ["qml", "quick", "svg", "quickcontrols2", "widgets"] }
    Depends { name: "ib"; condition: qbs.targetOS.contains("macos") }
    Depends { name: "LiriTranslations" }

    Properties {
        condition: qbs.targetOS.contains("darwin")
        bundle.identifierPrefix: "io.liri"
        bundle.identifier: "io.liri.Calculator"
        bundle.infoPlist: ({"CFBundleIconFile": "liri-calculator"})
    }

    files: [
        "main/*.cpp",
        "main/*.h",
        "engine/*.cpp",
        "filehandler/*.cpp",
        "filehandler/*.h",
        "icons/liri-calculator.icns",
    ]

    Qt.core.resourcePrefix: "/"
    Qt.core.resourceSourceBase: sourceDirectory

    Group {
        name: "Resource Data"
        files: [
            "engine/*.js",
            "engine/*.qml",
            "engine/qmldir",
            "icons/*.png",
            "ui/*.qml",
            "ui/qmldir",
        ]
        fileTags: ["qt.core.resource_data"]
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.binDir
        qbs.installSourceBase: destinationDirectory
        fileTagsFilter: isBundle ? ["bundle.content"] : ["application"]
    }

    Group {
        condition: qbs.targetOS.contains("unix") && !qbs.targetOS.contains("darwin") && !qbs.targetOS.contains("android")
        name: "Desktop File"
        files: ["../data/io.liri.Calculator.desktop.in"]
        fileTags: ["liri.desktop.template"]
    }

    Group {
        name: "Desktop File Translations"
        files: ["io.liri.Calculator_*.desktop"]
        prefix: "translations/"
        fileTags: ["liri.desktop.translations"]
    }

    Group {
        name: "Translations"
        files: ["*_*.ts"]
        prefix: "translations/"
    }

    Group {
        condition: qbs.targetOS.contains("unix") && !qbs.targetOS.contains("darwin") && !qbs.targetOS.contains("android")
        name: "AppStream Metadata"
        files: ["../data/io.liri.Calculator.appdata.xml"]
        qbs.install: true
        qbs.installDir: lirideployment.appDataDir
    }

    Group {
        condition: qbs.targetOS.contains("unix") && !qbs.targetOS.contains("darwin") && !qbs.targetOS.contains("android")
        name: "Icons"
        prefix: "../data/icons/"
        files: ["**/*.png", "**/*.svg"]
        qbs.install: true
        qbs.installSourceBase: prefix
        qbs.installDir: lirideployment.dataDir + "/icons/hicolor"
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.applicationsDir
        fileTagsFilter: "liri.desktop.file"
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/liri-calculator/translations"
        fileTagsFilter: "qm"
    }
}
