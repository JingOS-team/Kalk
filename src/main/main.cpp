/*
 * This file is part of Kalk
 *
 * Copyright (C) 2020 Han Young <hanyoung@protonmail.com>
 *                    Cahfofpai
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
#include <QApplication>
#include <QDebug>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <KAboutData>
#include <KLocalizedContext>
#include <KLocalizedString>

#include "Parser/driver.h"
#include "historymanager.h"
#include "typemodel.h"
#include "unitmodel.h"
int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    auto *historyManager = new HistoryManager();
    auto *typeModel = new TypeModel();
    auto *unitModel = new UnitModel();
    QObject::connect(typeModel, &TypeModel::categoryChanged, unitModel, &UnitModel::changeUnit);
    // create qml app engine
    QQmlApplicationEngine engine;
    KLocalizedString::setApplicationDomain("kalk");
    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));

    engine.rootContext()->setContextProperty("historyManager", historyManager);
    engine.rootContext()->setContextProperty("typeModel", typeModel);
    engine.rootContext()->setContextProperty("unitModel", unitModel);
    KAboutData aboutData("kalk", "Calculator", "0.1", "Calculator in Kirigami", KAboutLicense::GPL, i18n("© 2020 KDE Community"));
    KAboutData::setApplicationData(aboutData);

#ifdef QT_DEBUG
    engine.rootContext()->setContextProperty(QStringLiteral("debug"), true);
#else
    engine.rootContext()->setContextProperty(QStringLiteral("debug"), false);
#endif
    // setup qml imports
    engine.addImportPath(QStringLiteral("qrc:/"));

    // load main ui
    engine.load(QUrl(QStringLiteral("qrc:/ui/main.qml")));

    return app.exec();
}
