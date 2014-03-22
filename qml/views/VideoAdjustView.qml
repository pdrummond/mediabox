import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import MediaBox 1.0

// FIXME placeholder WIP
// FIXME ideally the constants would come from the web-services as config rather than being hard-coded here

TitledView {

    property real minimumHue : 0.0
    property real maximumHue : 360.0

    property real minimumSaturation : 0.0
    property real maximumSaturation : 3.0

    property real minimumBrightness : 0.0
    property real maximumBrigthness : 2.0

    property real minimumContrast : 0.0
    property real maximumContrast : 2.0

    property real minimumGamma : 0.01
    property real maximumGamma : 10.0

    header: Rectangle {

        width: parent.width
        height: childrenRect.height

        Label {
            text: "Video Adjust"
            font {
                pointSize: 16
                bold: true
            }
        }
    }

    content: ColumnLayout {

        anchors {
            fill: parent
        }

        spacing: 5

        Row {

            Label {
                text: qsTr("Enable")

            }

            Switch {
                checked: false
            }
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Hue")
            minimum: minimumHue
            maximum: maximumHue
            step: 0.0
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Saturation")
            minimum: minimumSaturation
            maximum: maximumSaturation
            value: 1.0
            step: 0.1
            tickmarks: true
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Brightness")
            minimum: minimumBrightness
            maximum: maximumBrigthness
            value: 1.0
            step: 0.1
            tickmarks: true
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Contrast")
            minimum: minimumContrast
            maximum: maximumContrast
            value: 1.0
            step: 0.1
            tickmarks: true
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Gamma")
            minimum: minimumGamma
            maximum: maximumGamma
            value: 1.0
            step: 0.1
        }
    }
}
