import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.0

import MediaBox 1.0

import "js/movies.js" as Movies;

// FIXME need to refactor the Rectangles of the individual page views to Item
// FIXME need to replace the menu and status bar placeholders with something useful (e.g. at least search and genres should be easily available)

ApplicationWindow {

    id: main

//    color: "#d9d9cf"
    color: "silver"

    width: 1080
    height: 1100

    title: "MediaBox"

    property string mediaboxHost
    property int mediaboxPort

    property variant currentMedia

    AndroidInterop {
        id: interop
    }

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
                    stackView.push(mainMenuView)
                },
                function(req) {
                    console.log("Failed to get movies: " + req.status)
                })
        }
    }

    property Component loadingView: Rectangle {
        color: "black"
        Text {
            text: "Loading..."
            color: "white"
            font.pointSize: 18
            anchors.centerIn: parent
        }
    }

    property Component mainMenuView: MenuView {
    }

    property Component moviesListView: MoviesListView {
        model: moviesModel
        onMediaSelected: {
            var movie = moviesModel.get(selectedIndex)

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

            // FIXME is this the best way
            currentMedia = movie

            stackView.push(movieDetailView)
        }
    }

    property Component movieDetailView: MediaDetailView {
        currentMedia: main.currentMedia
        onCastActivated: stackView.push(movieCastView)
        onCrewActivated: stackView.push(movieCrewView)
        onPlayActivated: {
            Movies.putMedia(
                0,
                currentMedia.id,
                function() {
                    stackView.push(mediaPlayerView)
                    console.log("Successfully played media")
                },
                function() {
                    console.log("Failed to play media")
                })
        }
    }

    property Component movieCastView: PersonView {
        model: castModel
        delegate: CastPersonDelegate {}
    }

    property Component movieCrewView: PersonView {
        model: crewModel
        delegate: CrewPersonDelegate {}
    }

    property Component movieGenresView: GenresListView {
        model: genresModel
    }

    property Component audioEqualizerView: AudioEqualizerView {
    }

    property Component videoAdjustView: VideoAdjustView {
    }

    property Component mediaPlayerView: MediaPlayerView {
    }

    StackView {
        id: stackView
        anchors.fill: parent
        focus: true
        initialItem: loadingView

        Keys.onReleased: {
            if (event.key === Qt.Key_Back || (event.key === Qt.Key_Left && (event.modifiers & Qt.AltModifier))) {
                event.accepted = true
                if (stackView.depth > 2) {
                    stackView.pop()
                }
                else {
                    Qt.quit() // FIXME weather example does not quit?
                }
            }
        }
    }

    // FIXME obviously placeholder for now
    statusBar: StatusBar {
        visible: false

        width: parent.width
        opacity: label.text !== "" ? 1 : 0
//        height: label.text !== "" ? 65 * ApplicationInfo.ratio : 0

        Behavior on height { NumberAnimation {easing.type: Easing.OutSine}}
        Behavior on opacity { NumberAnimation {}}

        style: StatusBarStyle {
            padding { left: 0; right: 0 ; top: 0 ; bottom: 0}
            property Component background: Rectangle {
//                implicitHeight: 65 * ApplicationInfo.ratio
                implicitHeight: 100
                implicitWidth: root.width
                color: ApplicationInfo.colors.smokeGray
                Rectangle {
                    width: parent.width
                    height: 1
                    color: Qt.darker(parent.color, 1.5)
                }
                Rectangle {
                    y: 1
                    width: parent.width
                    height: 1
                    color: "white"
                }
            }
        }
        Label {
            id: label
            font.pointSize: 16
            text: "Now playing: Blade Runner"
            color: "black"
            anchors {
                fill: parent
                margins: 10
            }
        }
    }

    // FIXME placeholder only of course
    menuBar: MenuBar {
        Menu {
            title: "Movies"
            MenuItem {
                text: "Genres..."
                onTriggered: {
                    // FIXME need to change the menu etc...
                    stackView.push(movieGenresView)
                }
            }
            MenuItem {
                text: "Audio..."
                onTriggered: {
                    // FIXME need to change the menu etc...
                    stackView.push(audioEqualizerView)
                }
            }
            MenuItem {
                text: "Video..."
                onTriggered: {
                    // FIXME need to change the menu etc...
                    stackView.push(videoAdjustView)
                }
            }
        }
    }

    ListModel {
        id: moviesModel
    }

    ListModel {
        id: genresModel
        onDataChanged: {
            // FIXME code dupe, and is this the best way?

            var genres = [];
            for (var i = 0; i < count; i++) {
                var g = get(i)
                if (g.toggled) {
                    genres.push(g.genre)
                }
            }

            Movies.getMovies(
                {genres: genres},
                function(data) {
//                    moviesListView.positionViewAtBeginning()
                    moviesModel.clear();
                    for (var i = 0; i < data.entries.length; i++) {
                        var movie = data.entries[i].movie;
                        movie.genreNames = Movies.genres(movie.genres);
                        moviesModel.append(movie);
                    }
                },
                function(req) {
                    console.log("Failed to get movies: " + req.status)
                })

        }
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
}
