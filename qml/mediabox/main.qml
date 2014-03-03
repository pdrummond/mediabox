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
            PropertyChanges { target: loadingView;     visible: true  }
        },
        State {
            name: "MOVIES"
            PropertyChanges { target: loadingView;     visible: false }
            PropertyChanges { target: movieDetailView; visible: false }
            PropertyChanges { target: moviesListView;  visible: true  }
        },
        State {
            name: "MOVIE"
            PropertyChanges { target: moviesListView;  visible: false }
            PropertyChanges { target: movieDetailView; visible: true  }
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
                id: loadingView
                visible: false
                text: "Loading..."
                font.pointSize: 18
                anchors.centerIn: parent;
            }

            MediaDetail {
                id: movieDetailView
                visible: false
            }

            ListView {

                signal mediaSelected(int mediaId)

                id: moviesListView
                visible: false
                anchors.fill: parent
                anchors.margins: 5
                spacing:30
//                highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                model: moviesModel
                maximumFlickVelocity: 6000 //Flick speed on Android is slow without this
                cacheBuffer: 10000
                smooth: true
                add: Transition { //scale in animation whenever an item is added to list
                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                    NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                }

                delegate: MovieDelegate {
                    id: movieDelegate
                    onItemClicked: {
                        main.state = 'MOVIE'
                        moviesListView.mediaSelected(mediaId)
                    }
                }
            }
        }

        ListModel {
            id: moviesModel
        }

        Component.onCompleted: {
            Movies.getMovies()
        }
    }
}
