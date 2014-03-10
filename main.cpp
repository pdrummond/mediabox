#include <QtGui/QGuiApplication>
#include <QtQml>

#include "qtquick2applicationviewer.h"

#include "networkdiscovery.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<NetworkDiscovery>("NetworkDiscovery", 1, 0, "NetworkDiscovery");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/mediabox/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
