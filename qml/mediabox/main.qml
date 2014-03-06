import QtQuick 2.1

import "movies.js" as Movies;

Rectangle {

    id: main

    width: 1080
    height: 900

    state: "LOADING"

    property variant currentMovie

    // FIXME probably a viewstack would be better than this
    states: [
        State {
            name: "LOADING"
            PropertyChanges { target: loadingView;     visible: true  }
        },
        State {
            name: "MOVIES"
            PropertyChanges { target: loadingView;     visible: false }
            PropertyChanges { target: movieDetailView; visible: false }
            PropertyChanges { target: movieCastView;   visible: false }
            PropertyChanges { target: movieCrewView;   visible: false }
            PropertyChanges { target: mediaPlayerView; visible: false }
            PropertyChanges { target: moviesListView;  visible: true; focus: true }
        },
        State {
            name: "MOVIE"
            PropertyChanges { target: movieDetailView; visible: false }
            PropertyChanges { target: movieCastView;   visible: false }
            PropertyChanges { target: movieCrewView;   visible: false }
            PropertyChanges { target: mediaPlayerView; visible: false }
            PropertyChanges { target: movieDetailView; visible: true; focus: true }
        },
        State {
            name: "CAST"
            PropertyChanges { target: moviesListView;  visible: false }
            PropertyChanges { target: movieDetailView; visible: false }
            PropertyChanges { target: movieCrewView;   visible: false }
            PropertyChanges { target: mediaPlayerView; visible: false }
            PropertyChanges { target: movieCastView;   visible: true; focus: true }
        },
        State {
            name: "CREW"
            PropertyChanges { target: moviesListView;  visible: false }
            PropertyChanges { target: movieDetailView; visible: false }
            PropertyChanges { target: movieCastView;   visible: false }
            PropertyChanges { target: mediaPlayerView; visible: false }
            PropertyChanges { target: movieCrewView;   visible: true; focus: true }
        },
        State {
            name: "MEDIA_PLAYER"
            PropertyChanges { target: moviesListView;  visible: false }
            PropertyChanges { target: movieDetailView; visible: false }
            PropertyChanges { target: movieCastView;   visible: false }
            PropertyChanges { target: movieCrewView;   visible: false }
            PropertyChanges { target: mediaPlayerView; visible: true; focus: true }
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
                        // FIXME experimenting with the best way to do this...
                        moviesListView.currentIndex = index
                        currentMovie = moviesListView.model.get(index)
                        main.state = 'MOVIE'
                        moviesListView.mediaSelected(mediaId)
                    }
                    onItemHeld: {
                        main.state = 'MEDIA_PLAYER'
                        Movies.putMedia(0, mediaId)
                    }
                }
            }

            PersonView {
                id: movieCastView
                delegate: CastPersonDelegate {}

                Connections {
                    target: main
                    onCurrentMovieChanged: {
                        movieCastView.setPeople(currentMovie.credits.cast)
                    }
                }
            }

            PersonView {
                id: movieCrewView
                delegate: CrewPersonDelegate {}

                Connections {
                    target: main
                    onCurrentMovieChanged: {
                        movieCrewView.setPeople(currentMovie.credits.crew)
                    }
                }
            }

            MediaPlayerView {
                id: mediaPlayerView
                visible: false
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
