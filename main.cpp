#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickWindow>
#include <QtQml>

#include "androidinterop.h"
#include "networkdiscovery.h"

static const char* qmlComponents[] = {
    "LineBorderedImage",
    "PersonView",
    "StandardSlider",
    "TitledView"
};

static const char* qmlViews[] = {
    "AudioEqualizerView",
    "CastPersonDelegate",
    "CrewPersonDelegate",
    "GenresListView",
    "MediaDetailView",
    "MediaPlayerView",
    "MenuItemView",
    "MenuView",
    "MovieDelegate",
    "MoviesListView",
    "VideoAdjustView"
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Caprica");
    app.setApplicationName("MediaBox");

    const char *uri = "MediaBox";
    // @uri MediaBox

    qmlRegisterType<AndroidInterop>(uri, 1, 0, "AndroidInterop");
    qmlRegisterType<NetworkDiscovery>(uri, 1, 0, "NetworkDiscovery");

    for (int i = 0; i < int(sizeof(qmlComponents)/sizeof(qmlComponents[0])); i++) {
        qmlRegisterType(QUrl(QString("qrc:/mediabox/qml/components/%1.qml").arg(qmlComponents[i])), uri, 1, 0, qmlComponents[i]);
    }

    for (int i = 0; i < int(sizeof(qmlViews)/sizeof(qmlViews[0])); i++) {
        qmlRegisterType(QUrl(QString("qrc:/mediabox/qml/views/%1.qml").arg(qmlViews[i])), uri, 1, 0, qmlViews[i]);
    }

    QQmlApplicationEngine engine(QUrl("qrc:/mediabox/qml/main.qml"));
    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
    if (!window) {
        qWarning("Error: Your root item has to be a Window.");
        return -1;
    }
    window->show();

    return app.exec();
}
