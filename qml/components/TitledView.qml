import QtQuick 2.0
import QtQuick.Controls 1.1

/**
 * Top-level view with a title, border and default styling.
 */
Rectangle {

    property int contentMargin: 10
    property int contentPadding: 5
    property int borderSize: 3
    property int headerSpacing: 5
    property int contentRadius: 6
    property color borderColour: "silver"
    property color contentBackground: "white"

    property alias header: headerContainer.data
    property alias content: contentContainer.data

    color: "white"

    Rectangle {
        color: contentBackground
        radius: contentRadius
        anchors {
            fill: parent
            margins: contentMargin
        }

        Rectangle {
            color: parent.color
            anchors {
                fill: parent
                margins: contentPadding
            }

            Rectangle {
                id: headerContainer
                color: parent.color
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                height: childrenRect.height
            }

            Rectangle {
                id: headerBorder
                color: borderColour
                anchors {
                    top: headerContainer.bottom
                    left: parent.left
                    right: parent.right
                }
                height: borderSize
            }

            Rectangle {
                id: contentContainer
                color: parent.color
                anchors {
                    left: parent.left
                    right: parent.right
                    top: headerBorder.bottom
                    bottom: parent.bottom
                    topMargin: headerSpacing
                }
//                height: childrenRect.height
            }
        }
    }
}
