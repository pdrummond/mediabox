import QtQuick 2.0
import QtQuick.Controls 1.1

// FIXME allow to customise the text format

Rectangle {

    property alias text: captionLabel.text

    property int captionPointSize: 12

    property alias minimum: slider.minimumValue
    property alias maximum: slider.maximumValue
    property alias value: slider.value
    property alias step: slider.stepSize
    property alias tickmarks: slider.tickmarksEnabled

    Row {

        width: parent.width

        spacing: 5

        Label {
            id: captionLabel
            width: parent.width / 4
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            anchors {
                verticalCenter: parent.verticalCenter
            }
            font {
                pointSize: captionPointSize
            }
        }

        Slider {
            id: slider
            width: parent.width / 2
            anchors {
                verticalCenter: parent.verticalCenter
            }
        }

        Label {
            id: valueLabel
            width: parent.width / 4
            text: slider.value.toFixed(1)
            verticalAlignment: Text.AlignVCenter
            anchors {
                verticalCenter: parent.verticalCenter
            }
            font {
                pointSize: captionPointSize
                bold: true
            }
        }

    }
}
