/*
 * This file is part of Kalk
 *
 * Copyright (C) 2020 Han Young <hanyoung@protonmail.com>
 *                    Cahfofpai
 *               2021 Bob <pengbo·wu@jingos.com>
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
#include <QSurfaceFormat>

#include <KAboutData>
#include <KLocalizedContext>
#include <KLocalizedString>

#include "historymanager.h"
#include "mathengine.h"
#include "typemodel.h"
#include "unitmodel.h"
#include <japplicationqt.h>

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    JApplicationQt japp;
    japp.enableBackgroud(false);
    QSurfaceFormat format = QSurfaceFormat::defaultFormat();
    format.setDepthBufferSize(0);
    format.setStencilBufferSize(0);
    QSurfaceFormat::setDefaultFormat(format);

    auto *historyManager = new HistoryManager();
    auto *typeModel = new TypeModel();
    auto *unitModel = new UnitModel();
    auto *mathEngine = new MathEngine();
    QObject::connect(typeModel, &TypeModel::categoryChanged, unitModel, &UnitModel::changeUnit);
    // create qml app engine
    QQmlApplicationEngine engine;
    KLocalizedString::setApplicationDomain("kalk");

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.rootContext()->setContextProperty("historyManager", historyManager);
    engine.rootContext()->setContextProperty("typeModel", typeModel);
    engine.rootContext()->setContextProperty("unitModel", unitModel);
    engine.rootContext()->setContextProperty("mathEngine", mathEngine);

    KAboutData aboutData("kalk", i18n("Calculator"), "0.1", i18n("Calculator in Kirigami"), KAboutLicense::GPL, i18n("© 2020 KDE Community"));

    KAboutData::setApplicationData(aboutData);

#ifdef QT_DEBUG
    engine.rootContext()->setContextProperty(QStringLiteral("debug"), true);
#else
    engine.rootContext()->setContextProperty(QStringLiteral("debug"), false);
#endif
    // load main ui
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
