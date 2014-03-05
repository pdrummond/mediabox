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
            text: "Play"
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
            text: "Pause"
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
            text: "Stop"
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
            text: "Previous"
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
            text: "Next"
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
            text: "Slower"
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
            text: "Normal"
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
            text: "Faster"
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
            text: "Step"
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
            text: "Rewind"
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
            text: "Skip"
            onClicked: {
                Movies.putControl(0, "time", "+30000")
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
