import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import MediaBox 1.0

Rectangle {

    property alias text: cellText.text
    property alias foreground: cellText.color

    signal itemClicked()

    Layout.fillHeight: true
    Layout.fillWidth: true

    radius: 8

    Label {
        id: cellText
        anchors.fill: parent
        font.pointSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            interop.playKeyClick()
            itemClicked()
        }
    }
}
