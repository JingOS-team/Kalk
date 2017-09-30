import qbs 1.0

QtGuiApplication {
    readonly property bool isBundle: qbs.targetOS.contains("darwin") && bundle.isBundle

    name: "liri-calculator"
    consoleApplication: false

    bundle.identifierPrefix: "io.liri"
    bundle.identifier: "io.liri.Calculator"

    Depends { name: "lirideployment" }
    Depends { name: "Qt"; submodules: ["qml", "quick", "svg", "quickcontrols2", "widgets"] }
    Depends { name: "ib"; condition: qbs.targetOS.contains("macos") }

    files: [
        "main/*.cpp",
        "main/*.h",
        "main/*.qrc",
        "engine/*.cpp",
        "engine/*.qrc",
        "filehandler/*.cpp",
        "filehandler/*.h",
        "ui/*.qrc",
        "icons/*.qrc",
        "icons/liri-calculator.icns",
    ]

    Group {
        qbs.install: true
        qbs.installDir: {
            if (qbs.targetOS.contains("linux"))
                return lirideployment.binDir;
            else
                return "";
        }
        qbs.installSourceBase: isBundle ? product.buildDirectory : ""
        fileTagsFilter: isBundle ? ["bundle.content"] : ["application"]
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "Desktop File"
        files: ["../data/io.liri.Calculator.desktop"]
        qbs.install: true
        qbs.installDir: lirideployment.applicationsDir
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "AppStream Metadata"
        files: ["../data/io.liri.Calculator.appdata.xml"]
        qbs.install: true
        qbs.installDir: lirideployment.appDataDir
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "Icon 16x16"
        files: ["../data/icons/16x16/io.liri.Calculator.png"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/icons/hicolor/16x16/apps"
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "Icon 32x32"
        files: ["../data/icons/32x32/io.liri.Calculator.png"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/icons/hicolor/32x32/apps"
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "Icon 64x64"
        files: ["../data/icons/64x64/io.liri.Calculator.png"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/icons/hicolor/64x64/apps"
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "Icon 128x128"
        files: ["../data/icons/128x128/io.liri.Calculator.png"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/icons/hicolor/128x128/apps"
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "Icon 192x192"
        files: ["../data/icons/192x192/io.liri.Calculator.png"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/icons/hicolor/192x192/apps"
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "Icon 256x256"
        files: ["../data/icons/256x256/io.liri.Calculator.png"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/icons/hicolor/256x256/apps"
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "Icon 512x512"
        files: ["../data/icons/512x512/io.liri.Calculator.png"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/icons/hicolor/512x512/apps"
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "Icon 1024x1024"
        files: ["../data/icons/1024x1024/io.liri.Calculator.png"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/icons/hicolor/1024x1024/apps"
    }

    Group {
        condition: qbs.targetOS.contains("linux")
        name: "Icon 2048x2048"
        files: ["../data/icons/2048x2048/io.liri.Calculator.png"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/icons/hicolor/2048x2048/apps"
    }
}
