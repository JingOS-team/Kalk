/*
 * This file is part of Liri Calculator
 *
 * Copyright (C) 2016 Pierre Jacquier <pierrejacquier39@gmail.com>
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

#include <QtGlobal>
#include <QApplication>
#include <QDir>
#include <QIcon>
#include <QLibraryInfo>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QQmlContext>
#include <QDebug>
#include <QStandardPaths>
#include <QTranslator>

#include "../filehandler/filehandler.h"

int main(int argc, char *argv[])
{
    // Set Material Design QtQuick Controls 2 style
    QQuickStyle::setStyle(QStringLiteral("Material"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    app.setOrganizationName(QStringLiteral("Liri"));
    app.setOrganizationDomain(QStringLiteral("liri.io"));
    app.setApplicationName(QStringLiteral("Calculator"));
    app.setDesktopFileName(QStringLiteral("io.liri.Calculator.desktop"));
    app.setWindowIcon(QIcon(QStringLiteral("qrc:/icons/icon.png")));

    // Load Translations
    QTranslator qtTranslator;
    qtTranslator.load(QStringLiteral("qt_") + QLocale::system().name(),
                      QLibraryInfo::location(QLibraryInfo::TranslationsPath));
    app.installTranslator(&qtTranslator);

    QTranslator translator;
#if (defined Q_OS_LINUX)
    const QString translationsPath = QStandardPaths::locate(
        QStandardPaths::GenericDataLocation, QStringLiteral("liri-calculator/translations/"),
        QStandardPaths::LocateDirectory);
#elif (defined Q_OS_MACOS)
    const QString translationsPath =
        QDir(QCoreApplication::applicationDirPath())
            .absoluteFilePath(QStringLiteral("../Resources/data/translations/"));
#elif (defined Q_OS_WIN)
    const QString translationsPath = QDir(QCoreApplication::applicationDirPath())
                                         .absoluteFilePath(QStringLiteral("translations/"));
#else
#error "Platform not supported"
#endif
    if (translator.load(translationsPath + QStringLiteral("liri-calculator_") + QLocale::system().name()))
        app.installTranslator(&translator);

    // Set the X11 WM_CLASS so X11 desktops can find the desktop file
    qputenv("RESOURCE_NAME", "io.liri.Calculator");

    // create qml app engine
    QQmlApplicationEngine engine;

    #ifdef QT_DEBUG
        engine.rootContext()->setContextProperty(QStringLiteral("debug"), true);
    #else
       engine.rootContext()->setContextProperty(QStringLiteral("debug"), false);
    #endif

    qmlRegisterType<FileHandler>("filehandler", 1, 0, "FileHandler");

    // setup qml imports
    engine.addImportPath(QStringLiteral("qrc:/"));

    // load main ui
    engine.load(QUrl(QStringLiteral("qrc:/ui/Main.qml")));

    return app.exec();
}
