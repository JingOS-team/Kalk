import qbs 1.0

Project {
    name: "Calculator"

    readonly property string version: "1.0.0"

    minimumQbsVersion: "1.6"

    qbsSearchPaths: ["qbs/shared"]

    references: [
        "src/src.qbs",
    ]
}
