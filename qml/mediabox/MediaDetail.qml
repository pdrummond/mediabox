import QtQuick 2.0

import "movies.js" as Movies;

Rectangle {

    property string baseUrl: "http://image.tmdb.org/t/p/"

    width: parent.width
    height: 62

    focus: true

    anchors.fill: parent

    radius: 10
    color : "#d9d9cf"

    Connections {
        target: moviesListView
        onMediaSelected: {
            console.log("DETAIL VIEW CLICKED " + mediaId)
            Movies.getMovie(mediaId)
        }
    }

/*
    Image {
        id    : movieImage
        x     : 10
        source: baseUrl + "w342/" + poster_path
        height: 500;

        anchors {
            margins: 10
            top    : parent.top
        }
    }

    Item {

        anchors {
            margins: 10
            top    : parent.top
            left   : movieImage.right
            right  : parent.right
            bottom : parent.bottom

        }

        Text {
            id   : mediaTitle
            text : title + ' (' + release_date.substring(0,4) + ')'
            width: parent.width
            elide: Text.ElideRight
            font {
                pointSize: 16
                bold     : true
            }
        }

        Text {
            anchors {
                top: mediaTitle.bottom;
            }
            text    : overview;
            elide   : Text.ElideRight
            wrapMode: Text.Wrap
            width   : parent.width
            height  : parent.height - (mediaTitle.height + bottomText.height + 16)
            font.pointSize: 14
        }

        Text {
            id   : bottomText
            width: parent.width
            text : genreNames
            elide: Text.ElideRight
            anchors {
                bottom: parent.bottom
            }
            font {
                pointSize: 14
                italic   : true
            }
        }
    }
*/
    Component.onCompleted: {

    }

    Keys.onPressed: {
        if (visible) {
            if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
                main.state = 'MOVIES'
                event.accepted = true
            }
        }
    }

    function setMovie(movie) {
        console.log("DETAIL VIEW SET MOVIE " + movie.title + " " + movie.overview);
    }
}
