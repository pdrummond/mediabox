import QtQuick 2.1
import "movies.js" as Movies;

Rectangle {

    id: main

    width: 640
    height: 800

    state: "LOADING"

    states: [
        State {
            name: "LOADING"
            PropertyChanges { target: loading;     visible: true  }
        },
        State {
            name: "MOVIES"
            PropertyChanges { target: loading;     visible: false }
            PropertyChanges { target: movieDetail; visible: false }
            PropertyChanges { target: moviesList;  visible: true  }
        },
        State {
            name: "MOVIE"
            PropertyChanges { target: moviesList;  visible: false }
            PropertyChanges { target: movieDetail; visible: true  }
        }
    ]

    Rectangle {
        anchors.fill:parent;

        Rectangle {
            id: wrapper
            width : parent.width
            height: parent.height
            anchors.fill:parent

            Text {
                id: loading
                visible: false
                text: "Loading..."
                font.pointSize: 18
                anchors.centerIn: parent;
            }

            MediaDetail {
                id: movieDetail
                visible: false
            }

            ListView {
                id: moviesList
                visible: false
                anchors.fill: parent
                anchors.margins: 5
                spacing:30
//                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                model: model
                maximumFlickVelocity: 6000 //Flick speed on Android is slow without this
                cacheBuffer: 10000
                smooth: true
//                clip:true
//                add: Transition { //scale in animation whenever an item is added to list
//                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
//                    NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
//                }
                delegate: MovieDelegate {}
            }
        }

        ListModel {
            id: model
        }

        Component.onCompleted: {
            Movies.downloadMovies()
        }
    }
}
