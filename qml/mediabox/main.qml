import QtQuick 2.1
import "movies.js" as Movies;

Rectangle {
    width: 640
    height: 800

    Rectangle {
        anchors.fill:parent;

        Rectangle {
            id: wrapper
            width : parent.width
            height: parent.height
            anchors.fill:parent

            Text {
                text: "Loading..."
                font.pointSize: 10
                anchors.centerIn: parent;
                opacity: model.count == 0?1:0; //Hide loading when model is loaded.
            }

            ListView {
                id: listView
                anchors.fill: parent
                anchors.margins: 5
                spacing:30
                model: model
                maximumFlickVelocity: 6000 //Flick speed on Android is slow without this
                cacheBuffer: 10000
                smooth: true
                clip:true
                add: Transition { //scale in animation whenever an item is added to list
                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                    NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                }
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
