import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import "movies.js" as Movies;

// FIXME set titleLabel and yearLabel from model

TitledView {

    property int buttonWidth: 400
    property int buttonHeight: 180

    property int skipDelta: 30000

    header: Rectangle {

        width: parent.width
        height: childrenRect.height

        Label {
            id: titleLabel
            font {
                pointSize: 16
                bold: true
            }
            elide: Text.ElideRight
            width: parent.width - (yearLabel.width + yearLabel.anchors.leftMargin)
        }

        Label {
            id: yearLabel
            anchors {
                left: titleLabel.right
                leftMargin: 5
            }
            font {
                pointSize: 16
                bold: true
            }
            elide: Text.ElideRight
        }
    }

    content: ColumnLayout {

        spacing: 5

        anchors {
            fill: parent
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Button {
                id: playPauseButton
                width: buttonWidth
                height: buttonHeight
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Play")
                iconSource: "xxhdpi/ic_action_play.png"
                onClicked: {
                    Movies.putControl(0, "control", "play", function() {}, function() {})
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Button {
                id: toggleMuteButton
                width: buttonWidth
                height: buttonHeight
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Mute")
                iconSource: "xxhdpi/ic_action_volume_on.png"
                onClicked: {
                    Movies.putControl(0, "volume", "mute", function() {}, function() {})
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {

                spacing: 5

                anchors.fill: parent

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Button {
                        id: rewindButton
                        width: buttonWidth
                        height: buttonHeight
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Rewind")
                        iconSource: "xxhdpi/ic_action_rewind.png"
                        onClicked: {
                            Movies.putControl(0, "time", "-" + skipDelta, function() {}, function() {})
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Button {
                        id: skipButton
                        width: buttonWidth
                        height: buttonHeight
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Skip")
                        iconSource: "xxhdpi/ic_action_fast_forward.png"
                        onClicked: {
                            Movies.putControl(0, "time", "+" + skipDelta, function() {}, function() {})
                        }
                    }
                }

            }

        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {

                spacing: 5

                anchors.fill: parent

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Button {
                        id: previousButton
                        width: buttonWidth
                        height: buttonHeight
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Previous")
                        iconSource: "xxhdpi/ic_action_previous.png"
                        onClicked: {
                            Movies.putControl(0, "chapter", "previous", function() {}, function() {})
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Button {
                        id: nextButton
                        width: buttonWidth
                        height: buttonHeight
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Next")
                        iconSource: "xxhdpi/ic_action_next.png"
                        onClicked: {
                            Movies.putControl(0, "chapter", "next", function() {}, function() {})
                        }
                    }
                }

            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Button {
                id: stopButton
                width: buttonWidth
                height: buttonHeight
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Stop")
                iconSource: "xxhdpi/ic_action_stop.png"
                onClicked: {
                    Movies.putControl(0, "control", "stop", function() {}, function() {})
                }
            }
        }
    }

    onBack: {
        main.state = 'MOVIE'
    }
}
