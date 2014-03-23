import QtQuick 2.0

import MediaBox 1.0

ListView {

    signal mediaSelected(int selectedIndex)

    clip: true
    spacing: 3
    maximumFlickVelocity: 6000 //Flick speed on Android is slow without this
    cacheBuffer: 10000
    smooth: true

    delegate: MovieDelegate {
        id: movieDelegate
        onItemClicked: {
            currentIndex = index
            mediaSelected(index) // FIXME should the caller just use somethnig like listview.oncurrentindexchanged?
        }
//        onItemHeld: {
//            main.state = 'MEDIA_PLAYER'
//            Movies.putMedia(
//                0,
//                mediaId,
//                function() {
//                    console.log("Successfully played media")
//                },
//                function() {
//                    console.log("Failed to play media")
//                })
//        }
    }
}
