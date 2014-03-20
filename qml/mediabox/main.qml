import QtQuick 2.1
import QtQuick.Controls 1.1

import NetworkDiscovery 1.0

import "movies.js" as Movies;

Rectangle {

    id: main

    width: 1080
    height: 1100

    focus: true

    property string mediaboxHost
    property int mediaboxPort

    NetworkDiscovery {
        id: networkDiscovery
        broadcastAddress: "192.168.0.255" // FIXME config, or can this be determined at run-time?
        broadcastPort: 5555
        onDiscoveredServer: {
            mediaboxHost = host
            mediaboxPort = port

            Movies.getMoviesInfo(
                function(data) {
                    genresModel.clear();
                    yearsModel.clear();
                    var i;
                    for (i = 0; i < data.genres.length; i++) {
                        genresModel.append({genre: data.genres[i], toggled: false});
                    }
                    for (i = 0; i < data.years.length; i++) {
                        yearsModel.append({year: data.years[i], toggled: false});
                    }
                },
                function(req) {
                })

            Movies.getMovies(
                {},
                function(data) {
//                    moviesListView.positionViewAtBeginning()
                    moviesModel.clear();
                    for (var i = 0; i < data.entries.length; i++) {
                        var movie = data.entries[i].movie;
                        movie.genreNames = Movies.genres(movie.genres);
                        moviesModel.append(movie);
                    }
                    stackView.push(moviesListView)
                },
                function(req) {
                    console.log("Failed to get movies: " + req.status)
                })
        }
    }

    Rectangle {
        id: loadingView
        color: "black"
        Text {
            text: "Loading..."
            color: "white"
            font.pointSize: 18
            anchors.centerIn: parent
        }
    }

    MoviesListView {
        id: moviesListView
        model: moviesModel
        onMediaSelected: {
            var movie = moviesListView.model.get(selectedIndex)

            movieCastView.positionViewAtBeginning()
            movieCrewView.positionViewAtBeginning()

            castModel.clear()
            crewModel.clear()

            var i
            var person

            var cast = movie.credits.cast
            for (i = 0; i < cast.length; i++) {
                person = cast[i]
                if (person.profile_path) { // FIXME the delegate should take care of this
                    castModel.append(person)
                }
            }

            var crew = movie.credits.crew
            for (i = 0; i < crew.length; i++) {
                person = crew[i]
                if (person.profile_path) { // FIXME the delegate should take care of this
                    crewModel.append(person)
                }
            }

            stackView.push(movieDetailView)
        }
    }

    MediaDetail {
        id: movieDetailView

        onCastActivated: stackView.push(movieCastView)
        onCrewActivated: stackView.push(movieCrewView)
    }

    PersonView {
        id: movieCastView
        model: castModel
        delegate: CastPersonDelegate {}

        Connections {
            target: castModel
            onDataChanged: positionViewAtBeginning()
        }
    }

    PersonView {
        id: movieCrewView
        model: crewModel
        delegate: CrewPersonDelegate {}
    }

    MediaPlayerView {
        id: mediaPlayerView
    }

    Rectangle {
        color: "black"
        anchors.fill: parent
        StackView {
            id: stackView
            anchors {
                fill: parent
                margins: 5
            }
            initialItem: loadingView
        }
    }

    ListModel {
        id: moviesModel
    }

    ListModel {
        id: genresModel
    }

    ListModel {
        id: yearsModel
    }

    ListModel {
        id: castModel
    }

    ListModel {
        id: crewModel
    }

    Component.onCompleted: {
        networkDiscovery.discoverServer();
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
            // Depth greater than 2 because the first item is the loading screen
            if (stackView.depth > 2) {
                stackView.pop()
            }
            else {
                Qt.quit()
            }
            event.accepted = true
        }
    }
}
