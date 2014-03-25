import QtQuick 2.0

Item {

    id: page

    property Component pageComponent

    Loader {
        sourceComponent: pageComponent
        anchors.fill: parent
        Rectangle {
            z: -1
            anchors.fill: parent
            color: "white"
        }
    }
}
