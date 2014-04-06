import QtQuick 2.2
import QtQuick.Controls 1.1

Rectangle {

    id: container

    signal clicked

    property alias label: label.text
    property alias value: value.text

    property int fontSize: 16

    color: "black"
    radius: 6
    height: content.childrenRect.height + 4 // FIXME why? margins?

    Rectangle {
        id: content
        radius: 6
        color: "#f0f0f8"
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 2
        }
        height: childrenRect.height

        Label {
            id: label
            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 10
            }
            font.pointSize: fontSize
        }

        Label {
            id: value
            anchors {
                top: parent.top
                left: label.right
                right: parent.right
                leftMargin: 10
                rightMargin: 10
            }
            elide: Text.ElideRight
            width: parent.width - label.width
            font {
                pointSize: fontSize
                bold: true
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            interop.playKeyClick()
            container.clicked()
        }
    }
}
