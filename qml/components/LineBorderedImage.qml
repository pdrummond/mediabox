import QtQuick 2.0

/**
 * An image with a simple line border.
 */
Rectangle {

    property int borderWidth: 1

    property alias imageSource: image.source
    property alias imageWidth: image.width
    property alias imageHeight: image.height
    property alias fillMode: image.fillMode

    width: image.width + (2 * borderWidth)
    height: image.height + (2 * borderWidth)

    Rectangle {
        id: border
        anchors {
            fill: parent
            margins: borderWidth
        }
        color: parent.color
        Image {
            id: image
            smooth: true
            cache: true
        }
    }
}
