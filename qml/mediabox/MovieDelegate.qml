import QtQuick 2.0

import QtMultimedia 5.0

Rectangle {

    property string baseUrl: "http://image.tmdb.org/t/p/"

    signal itemClicked(int mediaId)
    signal itemHeld(int mediaId)

    radius: 10
    width : parent.width
    height: 530
    color : "#d9d9cf"

    Image {
        id    : movieImage
        x     : 10
        source: baseUrl + "w342/" + poster_path
        height: 500;

        anchors {
            margins: 10
            top    : parent.top
        }
        smooth: true
        cache: true

//        asynchronous: true

        /*
            The following provides image fading.

            Whenever the source is changed, set the opacity to 0.

            Whenever the opacity changes, kick off animation to gradually increase opacity to 1 (fade in).
        */
        onSourceChanged: { opacity = 0;}
        NumberAnimation on opacity { to: 1;duration: 2000}
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

    MouseArea {
        anchors.fill: parent
        onClicked: {
            itemClicked(id)
        }
        onPressAndHold: {
            itemHeld(id)
        }
    }
}
