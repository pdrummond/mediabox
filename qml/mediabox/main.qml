import QtQuick 2.1
import "movies.js" as Movies;

Rectangle {
    width: 640
    height: 800
    property string baseUrl: "http://image.tmdb.org/t/p/";

    Rectangle {
        anchors.fill:parent;

        Rectangle {
            id: wrapper
            width:parent.width;
            height:parent.height;
            anchors.fill:parent;

            Text {
                text: "Loading..."
                font.pointSize: 10
                anchors.centerIn: parent;
                opacity: model.count == 0?1:0; //Hide loading when model is loaded.
            }


            ListView {
                id: listView
                anchors.fill: parent;
                anchors.margins: 5;
                spacing:30;
                model: model
                maximumFlickVelocity: 6000 //Flick speed on Android is slow without this
                cacheBuffer: 10000
                smooth: true
                clip:true;
                add: Transition { //scale in animation whenever an item is added to list
                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                    NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                }
                delegate: Rectangle {
                    radius:10;
                    width:parent.width;
                    height: 530;
                    color: "#d9d9cf"
                    Image {
                        id:movieImage;
                        x:10
                        anchors {
                            margins: 10;
                            top:parent.top;
                        }
                        source: baseUrl + "w342/" + poster_path;
                        height: 500;

                        /*
                        The following provides image fading.
                        Whenever the source is changed, set the opacity to 0.
                        Whenever the opacity changes, kick off animation to gradually
                        increase opacity to 1 (fade in).
                    */
                        onSourceChanged: { opacity = 0;}
                        NumberAnimation on opacity { to: 1;duration: 2000}
                    }

                    Text {
                        anchors {
                            margins:10;
                            top:parent.top;
                            left:movieImage.right;
                            right:parent.right;
                            bottom:parent.bottom;

                        }
                        text: title;
                        font.pointSize: 14
                        font.bold: true;
                    }
                }
            }
        }

        ListModel {
            id: model
        }

        Component.onCompleted:{
            Movies.downloadMovies();
        }
    }
}
