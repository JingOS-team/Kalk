#include <QApplication>
#include <QDebug>
#include <QDir>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQuickControls2/QQuickStyle>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setOrganizationName(QStringLiteral("KDE"));
    app.setOrganizationDomain(QStringLiteral("kde.org"));
    app.setApplicationName(QStringLiteral("Kalk"));

    // create qml app engine
    QQmlApplicationEngine engine;

#ifdef QT_DEBUG
    engine.rootContext()->setContextProperty(QStringLiteral("debug"), true);
#else
    engine.rootContext()->setContextProperty(QStringLiteral("debug"), false);
#endif
    // setup qml imports
    engine.addImportPath(QStringLiteral("qrc:/"));

    // load main ui
    engine.load(QUrl(QStringLiteral("qrc:/ui/Main.qml")));

    return app.exec();
}
