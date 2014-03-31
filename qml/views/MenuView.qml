import QtQuick 2.2
import QtQuick.Layouts 1.1

// FIXME this is just a rough and ready placeholder used to test access to the various screens
// Needs a list model and clicked handling etc?

Rectangle {

    color: "black"

    GridLayout {
        anchors.fill: parent

        anchors.margins: 30

        columns: 3
        rows: 3
        columnSpacing: 24
        rowSpacing: 24

        MenuItemView {
            text: "MOVIES"
            gradientStart: "#8b3840"
            gradientStop: "#832b45"
            onItemClicked: stackView.push(moviesListView)
            height: width
        }

        MenuItemView {
            text: "TV"
            gradientStart: "#894235"
            gradientStop: "#85383f"
            onItemClicked: stackView.push(moviesListView)
            height: width
        }

        MenuItemView {
            text: "MUSIC"
            gradientStart: "#956237"
            gradientStop: "#8c523a"
            onItemClicked: stackView.push(moviesListView)
            height: width
        }

        MenuItemView {
            text: "MEDIA PLAYER"
            gradientStart: "#6b1058"
            gradientStop: "#65145f"
            onItemClicked: stackView.push(mediaPlayerView)
            height: width
        }

        MenuItemView {
            text: "VIDEO"
            gradientStart: "#81224e"
            gradientStop: "#761c51"
            onItemClicked: stackView.push(videoAdjustView)
            height: width
        }

        MenuItemView {
            text: "AUDIO"
            gradientStart: "#612f5e"
            gradientStop: "#5b2965"
            onItemClicked: stackView.push(audioEqualizerView)
            height: width
        }

        MenuItemView {
            text: "STATUS"
            gradientStart: "#431c6e"
            gradientStop: "#3a1d71"
            onItemClicked: stackView.push(movieGenresView)
            height: width
        }

        MenuItemView {
            text: "SETTINGS"
            gradientStart: "#39347a"
            gradientStop: "#2f347d"
            onItemClicked: stackView.push(movieGenresView)
            height: width
        }

        MenuItemView {
            text: "ABOUT"
            gradientStart: "#483e65"
            gradientStop: "#41426c"
            onItemClicked: stackView.push(movieGenresView)
            height: width
        }
    }
}
