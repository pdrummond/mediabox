import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import MediaBox 1.0

Rectangle {

    property alias text: cellText.text
    property alias foreground: cellText.color
    property alias gradientStart: gradientStart.color
    property alias gradientStop: gradientStop.color

    signal itemClicked()

    Layout.fillHeight: true
    Layout.fillWidth: true

    radius: 8

    gradient: Gradient {
        GradientStop {
            id: gradientStart
            position: 0.0
            color: "white"
        }
        GradientStop {
            id: gradientStop
            position: 1.0
            color: "black"
        }
    }

    Label {
        id: cellText
        anchors.fill: parent
        color: "white"
        font.pointSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            // FIXME this predicate would not go here...
            if (!stackView.busy) {
                interop.playKeyClick()
                itemClicked()
            }
        }
    }
}
