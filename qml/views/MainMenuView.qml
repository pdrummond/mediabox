import QtQuick 2.2
import QtQuick.Layouts 1.1

// FIXME this is just a rough and ready placeholder used to test access to the various screens
// Needs a list model and clicked handling etc?

Rectangle {

    color: "black"

    GridLayout {
        anchors.fill: parent

        columns: 2
        columnSpacing: 5
        rowSpacing: 5

        MediaTypesItem {
            color: "red"
            foreground: "black"
            text: "Movies"
            onItemClicked: stackView.push(moviesListView)
            height: width
        }

        MediaTypesItem {
            color: "yellow"
            foreground: "black"
            text: "Video"
            onItemClicked: stackView.push(videoAdjustView)
            height: width
        }

        MediaTypesItem {
            color: "green"
            foreground: "black"
            text: "Audio"
            onItemClicked: stackView.push(audioEqualizerView)
            height: width
        }

        MediaTypesItem {
            color: "blue"
            foreground: "black"
            text: "Genres"
            onItemClicked: stackView.push(movieGenresView)
            height: width
        }
    }
}
