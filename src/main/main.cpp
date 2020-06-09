#include <QApplication>
#include <QDebug>
#include <QDir>
#include <QIcon>
#include <QLibraryInfo>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStandardPaths>
#include <QTranslator>
#include <QtGlobal>
#include <QtQuickControls2/QQuickStyle>

#include "../filehandler/filehandler.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setOrganizationName(QStringLiteral("KDE"));
    app.setOrganizationDomain(QStringLiteral("kde.org"));
    app.setApplicationName(QStringLiteral("Kalk"));
    app.setDesktopFileName(QStringLiteral("io.kde.Kalk.desktop"));
    app.setWindowIcon(QIcon(QStringLiteral("accesories-calculator")));

    // Load Translations
    QTranslator qtTranslator;
    qtTranslator.load(QStringLiteral("qt_") + QLocale::system().name(), QLibraryInfo::location(QLibraryInfo::TranslationsPath));
    app.installTranslator(&qtTranslator);

    QTranslator translator;
#if (defined Q_OS_LINUX)
    const QString translationsPath =
        QStandardPaths::locate(QStandardPaths::GenericDataLocation, QStringLiteral("kalk/translations/"), QStandardPaths::LocateDirectory);
#elif (defined Q_OS_MACOS)
    const QString translationsPath = QDir(QCoreApplication::applicationDirPath()).absoluteFilePath(QStringLiteral("../Resources/data/translations/"));
#elif (defined Q_OS_WIN)
    const QString translationsPath = QDir(QCoreApplication::applicationDirPath()).absoluteFilePath(QStringLiteral("translations/"));
#else
#error "Platform not supported"
#endif
    if (translator.load(translationsPath + QStringLiteral("kalk_") + QLocale::system().name()))
        app.installTranslator(&translator);

    // Set the X11 WM_CLASS so X11 desktops can find the desktop file
    qputenv("RESOURCE_NAME", "org.kde.Kalk");

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
