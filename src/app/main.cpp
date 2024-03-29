#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>

#include "applicationmanager.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Material");

    ApplicationManager applicationManager;
#ifdef Q_MOBILE_PLATFORM
    applicationManager.systemCheats();
#endif
    QObject::connect(&app, SIGNAL(aboutToQuit()), &applicationManager, SLOT(onAboutToQuit()));
    QObject::connect(&app, SIGNAL(applicationStateChanged(Qt::ApplicationState)), &applicationManager, SLOT(onApplicationStateChanged(Qt::ApplicationState)));

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    applicationManager.addContextProperty(&engine, context);
    engine.load(QUrl(QLatin1String("qrc:/qml/Main.qml")));
    if(engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
