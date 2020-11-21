import QtQuick 2.0
import org.kde.kirigami 2.13 as Kirigami
Kirigami.AboutPage {
    id: aboutPage
    visible: false
    title: i18n("About")
    aboutData: {
        "displayName": i18n("Calculator"),
        "productName": "kirigami/calculator",
        "componentName": "kalk",
        "shortDescription": i18n("Calculator built with Kirigami."),
        "homepage": "https://invent.kde.org/plasma-mobile/kalk",
        "bugAddress": "https://invent.kde.org/plasma-mobile/kalk",
        "version": "v0.1",
        "otherText": "",
        "copyrightStatement": i18n("© 2020 Plasma Development Team"),
        "desktopFileName": "org.kde.calculator",
        "authors": [
                    {
                        "name": i18n("Han Young"),
                        "emailAddress": "hanyoung@protonmail.com",
                    },
                    {
                        "name": i18n("cahfofpai"),
                    }
                ],
        "licenses": [
                    {
                        "name": "GPL v3",
                        "text": "long, boring, license text",
                        "spdx": "GPL-v3.0",
                    }
                ]
    }
}
