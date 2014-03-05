import QtQuick 2.0
import QtQuick.Controls 1.1

import "movies.js" as Movies;

// FIXME maybe swipe left/right to show cast/crew/chapters/bookmarks and so on?

Rectangle {

    property string baseUrl: "http://image.tmdb.org/t/p/"

    // FIXME can I have a property for the Javascript object "movie" ?
    property int mediaId

    height: 62

    anchors.fill: parent
    anchors.margins: 5

    radius: 10
    color : "#d9d9cf"

    Connections {
        target: moviesListView
        onMediaSelected: {
            Movies.getMovie(mediaId)
        }
    }

    Label {
        id: titleLabel
        width: parent.width
        elide: Text.ElideRight
        font {
            pointSize: 16
            bold: true
        }
    }

    Image {
        id: backdropImage
        width: parent.width
//        height: 300 // FIXME?
        anchors {
            margins: 10
            top: titleLabel.bottom
        }
        fillMode: Image.PreserveAspectCrop
        smooth: true
        cache: true

//        asynchronous: true
    }

    // FIXME maybe a GridLayout for these...

    Rectangle {
        id: directionWrapper
        width: parent.width
        height: directedByLabel.height + 20
        color: "white"
        radius: 2
        anchors {
            topMargin: 10
            leftMargin: 10
            rightMargin: 10
            top: backdropImage.bottom
        }

        Label {
            id: directedByLabel
            text: "Directed by"
            font.pointSize: 14
        }

        Label {
            id: directorLabel
            width: parent.width - (directedByLabel.width + 10)
            elide: Text.ElideRight
            anchors {
                leftMargin: 10
                left: directedByLabel.right
            }
            font {
                pointSize: 14
                bold: true
            }

        }

        MouseArea {
            width: parent.width
            height: parent.height
            onClicked: {
                console.log("SHOW CREW DETAILED VIEW!")
            }
        }
    }

    Rectangle {
        id: castWrapper
        width: parent.width
        height: starringLabel.height + 20
        color: "white"
        radius: 2
        anchors {
            topMargin: 10
            leftMargin: 10
            rightMargin: 10
            top: directionWrapper.bottom
        }

        Label {
            id: starringLabel
            text: "Starring"
            font.pointSize: 14
        }

        Label {
            id: castLabel
            width: parent.width - (starringLabel.width + 10)
            elide: Text.ElideRight
            anchors {
                leftMargin: 10
                left: starringLabel.right
            }
            font {
                pointSize: 14
                bold: true
            }
        }

        MouseArea {
            width: parent.width
            height: parent.height
            onClicked: {
                console.log("SHOW CAST DETAILED VIEW!")
            }
        }
    }

    Rectangle {
        id: genreWrapper
        width: parent.width
        height: genresLabel.height + 20
        color: "white"
        radius: 2
        anchors {
            topMargin: 10
            leftMargin: 10
            rightMargin: 10
            top: castWrapper.bottom
        }

        Label {
            id: genreLabel
            font.pointSize: 14
            text: "Genre"
        }

        Label {
            id: genresLabel
            width: parent.width - (genreLabel.width + 10)
            elide: Text.ElideRight
            anchors {
                leftMargin: 10
                left: genreLabel.right
            }

            font {
                pointSize: 14
                bold: true
                italic: true
            }
        }
    }

    // FIXME would be good to scroll the overview up/down if it doesn't fit

    Rectangle {
        id: overviewWrapper
        width: parent.width
        height: overviewLabel.height
        anchors {
            margins: 10
            top: genreWrapper.bottom
        }

        Label {
            id: overviewLabel
            width: parent.width
            height: parent.parent.height - (titleLabel.height + backdropImage.height + directionWrapper.height + castWrapper.height + genreWrapper.height + buttonsWrapper.height) // FIXME all the margins too
            elide: Text.ElideRight
            wrapMode: Text.Wrap
            font.pointSize: 14
        }
    }

    Rectangle {
        id: buttonsWrapper
        width: parent.width
        height: playMediaButton.height + 40
        anchors {
            margins: 10
            top: overviewWrapper.bottom
        }

        Button {
            width: 400
            height: 200
            anchors.margins: 20
            id: playMediaButton
            text: "Play"
            onClicked: {
                Movies.putMedia(0, mediaId)
            }
        }

        Button {
            width: 400
            height: 200
            anchors.margins: 20
            id: resumeMediaButton
            anchors.right: parent.right
            text: "Resume"
            onClicked: {
                // FIXME play from last position (if there is one)
                Movies.putMedia(0, mediaId)
            }
        }

    }

/*
            Text {
                id: runtimeText
                anchors.top: directedBy.bottom
                width: parent.width
                elide: Text.ElideRight
                font {
                    pointSize: 14
                }
            }
*/
//        }

    Keys.onPressed: {
        if (visible && focus) {
            if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
                main.state = 'MOVIES'
                event.accepted = true
            }
        }
    }

    function setMovie(movie) {
        mediaId = movie.id;
        // FIXME needs to hide/show/animate or whatever nicely - right now it displays old details before new loads
        // 300, 780, 1280
        backdropImage.source = baseUrl + "w1280/" + movie.backdrop_path
        titleLabel.text = movie.title + ' (' + movie.release_date.substring(0,4) + ')'
        overviewLabel.text = movie.overview;
        genresLabel.text = movie.genreNames;

        for (var i = 0; i < movie.credits.crew.length; i++) {
            var crew = movie.credits.crew[i];
            if (crew.job === "Director") {
                directorLabel.text = crew.name;
            }
        }

        var castValue = "";
        for (i = 0; i < movie.credits.cast.length; i++) {
            var cast = movie.credits.cast[i];
            if (i > 0) {
                castValue += ", "
            }

            castValue += cast.name
        }
        castLabel.text = castValue

//        runtimeText.text = movie.runtime + " minutes";
    }
}
