#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "playlistmodel.h"
#include "player.h"
#include <QQmlContext>
#include <QObject>
#include "translator.h"
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    Player controller;
    Translator translator;
    QQmlApplicationEngine engine;
    QQmlContext *rootContext = engine.rootContext();
    rootContext->setContextProperty("Playlist",controller.playlist);
    rootContext->setContextProperty("PlaylistModel",controller.playlistModel);
    rootContext->setContextProperty("player",&controller);
    rootContext->setContextProperty("Translator",&translator);

    qmlRegisterType<PlaylistModel>("myType.PlaylistModel",1,0,"MyPlayList");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
