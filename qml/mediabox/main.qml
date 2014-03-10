import QtQuick 2.1

import NetworkDiscovery 1.0

import "movies.js" as Movies;

Rectangle {

    id: main

    width: 1080
    height: 1100

    state: "LOADING"

    property string mediaboxHost
    property int mediaboxPort

    property variant currentMovie

    NetworkDiscovery {
        id: networkDiscovery
        broadcastAddress: "192.168.0.255" // FIXME config, or can this be determined at run-time?
        broadcastPort: 5555
        onDiscoveredServer: {
            mediaboxHost = host
            mediaboxPort = port
            Movies.getMovies(
                function(data) {
                    for (var i = 0; i < data.entries.length; i++) {
                        var movie = data.entries[i].movie;
                        movie.genreNames = Movies.genres(movie.genres);
                        moviesModel.append(movie);
                    }
                    main.state = "MOVIES";
                },
                function(req) {
                    console.log("Failed to get movies: " + req.status)
                })
        }
    }

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

        color: "black"

        Rectangle {
            id: wrapper
            width : parent.width
            height: parent.height
            anchors.fill:parent

            color: parent.color

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
                spacing: 5
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
                        Movies.putMedia(
                            0,
                            mediaId,
                            function() {
                                console.log("Successfully played media")
                            },
                            function() {
                                console.log("Failed to play media")
                            })
                    }
                }
            }

            PersonView {
                id: movieCastView
                visible: false
                delegate: CastPersonDelegate {}

                Connections {
                    target: main
                    onCurrentMovieChanged: {
                        movieCastView.setPeople(currentMovie.credits.cast)
                    }
                }

                Keys.onPressed: {
                    if (visible && focus) {
                        if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
                            main.state = 'MOVIE'
                            event.accepted = true
                        }
                    }
                }
            }

            PersonView {
                id: movieCrewView
                visible: false
                delegate: CrewPersonDelegate {}

                Connections {
                    target: main
                    onCurrentMovieChanged: {
                        movieCrewView.setPeople(currentMovie.credits.crew)
                    }
                }

                Keys.onPressed: {
                    if (visible && focus) {
                        if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
                            main.state = 'MOVIE'
                            event.accepted = true
                        }
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
            networkDiscovery.discoverServer();
        }
    }
}
