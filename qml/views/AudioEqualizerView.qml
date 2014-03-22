import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import MediaBox 1.0

// FIXME placeholder WIP
// FIXME need to get the frequencies from the web-service rather than hard-coding here

TitledView {

    property real minimumAmp : -20.0
    property real maximumAmp : 20.0

    header: Rectangle {

        width: parent.width
        height: childrenRect.height

        Label {
            text: "Audio Equalizer"
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

        Row {

            Label {
                text: qsTr("Preset")
            }
        }


        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "Preamp"
            minimum: minimumAmp
            maximum: maximumAmp
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "60 Hz"
            minimum: minimumAmp
            maximum: maximumAmp
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "170 Hz"
            minimum: minimumAmp
            maximum: maximumAmp
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "310 Hz"
            minimum: minimumAmp
            maximum: maximumAmp
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "600 Hz"
            minimum: minimumAmp
            maximum: maximumAmp
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "1 kHz"
            minimum: minimumAmp
            maximum: maximumAmp
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "3 kHz"
            minimum: minimumAmp
            maximum: maximumAmp
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "6 kHz"
            minimum: minimumAmp
            maximum: maximumAmp
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "12 kHz"
            minimum: minimumAmp
            maximum: maximumAmp
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "14 kHz"
            minimum: minimumAmp
            maximum: maximumAmp
        }

        StandardSlider {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "16 kHz"
            minimum: minimumAmp
            maximum: maximumAmp
        }

    }
}
