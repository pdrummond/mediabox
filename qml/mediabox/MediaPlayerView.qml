import QtQuick 2.0
import QtQuick.Controls 1.1

import "movies.js" as Movies;

Rectangle {
    width: 100
    height: 62

    anchors.fill: parent
    anchors.margins: 10

    radius: 10
    color : "#d9d9cf"

    Rectangle {
        anchors.fill: parent
        anchors.margins: 20
        color: parent.color

        Button {
            id: playButton
            width: 300
            height: 150
            anchors.leftMargin: 20
            anchors.topMargin: 20
            text: qsTr("Play")
            iconSource: "xxhdpi/ic_action_play.png"
            onClicked: {
                Movies.putControl(0, "control", "play")
            }
        }

        Button {
            id: pauseButton
            width: 300
            height: 150
            anchors.left: playButton.right
            anchors.leftMargin: 20
            anchors.topMargin: 20
            text: qsTr("Pause")
            iconSource: "xxhdpi/ic_action_pause.png"
            onClicked: {
                Movies.putControl(0, "control", "pause")
            }
        }

        Button {
            id: stopButton
            width: 300
            height: 150
            anchors.left: pauseButton.right
            anchors.leftMargin: 20
            anchors.topMargin: 20
            iconSource: "xxhdpi/ic_action_stop.png"
            text: qsTr("Stop")
            onClicked: {
                Movies.putControl(0, "control", "stop")
                main.state = "MOVIE"
            }
        }

        Button {
            id: previousChapterButton
            width: 300
            height: 150
            anchors.top: playButton.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            iconSource: "xxhdpi/ic_action_previous.png"
            text: qsTr("Previous")
            onClicked: {
                Movies.putControl(0, "chapter", "previous")
            }
        }

        Button {
            id: nextChapterButton
            width: 300
            height: 150
            anchors.top: playButton.bottom
            anchors.left: previousChapterButton.right
            anchors.leftMargin: 20
            anchors.topMargin: 20
            iconSource: "xxhdpi/ic_action_next.png"
            text: qsTr("Next")
            onClicked: {
                Movies.putControl(0, "chapter", "next")
            }
        }

        Button {
            id: slowerRateButton
            width: 300
            height: 150
            anchors.top: previousChapterButton.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            text: qsTr("Slower")
            onClicked: {
                Movies.putControl(0, "rate", "decrease")
            }
        }

        Button {
            id: normalRateButton
            width: 300
            height: 150
            anchors.top: previousChapterButton.bottom
            anchors.left: slowerRateButton.right
            anchors.leftMargin: 20
            anchors.topMargin: 20
            text: qsTr("Normal")
            onClicked: {
                Movies.putControl(0, "rate", "reset")
            }
        }

        Button {
            id: fasterRateButton
            width: 300
            height: 150
            anchors.top: previousChapterButton.bottom
            anchors.left: normalRateButton.right
            anchors.leftMargin: 20
            anchors.topMargin: 20
            text: qsTr("Faster")
            onClicked: {
                Movies.putControl(0, "rate", "increase")
            }
        }

        Button {
            id: stepRateButton
            width: 300
            height: 150
            anchors.top: slowerRateButton.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            text: qsTr("Step")
            onClicked: {
                Movies.putControl(0, "rate", "step")
            }
        }

        Button {
            id: rewindButton
            width: 300
            height: 150
            anchors.top: stepRateButton.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            iconSource: "xxhdpi/ic_action_rewind.png"
            text: qsTr("Rewind")
            onClicked: {
                Movies.putControl(0, "time", "-30000")
            }
        }

        Button {
            id: skipButton
            width: 300
            height: 150
            anchors.top: stepRateButton.bottom
            anchors.left: rewindButton.right
            anchors.leftMargin: 20
            anchors.topMargin: 20
            iconSource: "xxhdpi/ic_action_fast_forward.png"
            text: qsTr("Skip")
            onClicked: {
                Movies.putControl(0, "time", "+30000")
            }
        }

        Button {
            id: muteButton
            width: 620
            height: 150
            anchors.top: skipButton.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            iconSource: "xxhdpi/ic_action_volume_on.png"
            text: qsTr("Mute On")
            checkable: true
            onClicked: {
                Movies.putControl(0, "volume", "mute")
            }
        }
    }

    Keys.onPressed: {
        if (visible && focus) { // FIXME is this necessary with proper management of focus property?
            if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
                main.state = 'MOVIE'
                event.accepted = true
            }
        }
    }
}
