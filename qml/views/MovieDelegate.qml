import QtQuick 2.0
import QtQuick.Controls 1.1

import MediaBox 1.0

// FIXME need to pull images from local cache rather than tmdb

/**
 * Delegate for rendering a movie in a list.
 */
Rectangle {

    id: container

    property string baseUrl: "http://image.tmdb.org/t/p/"

    property int headerFontSize: 16
    property int contentFontSize: 14
    property int footerFontSize: 12

    signal itemClicked(int mediaId)
    signal itemHeld(int mediaId)

    width: parent.width
    height: artwork.height + (2 * artwork.anchors.margins)
    color: "#d9d9cf"
    radius: 10

    LineBorderedImage {
        id: artwork
        anchors {
            left: parent.left;
            top: parent.top;
            bottom: parent.bottom
            margins: 10
        }
        color: "black"
        borderWidth: 3
        radius: 6
        imageSource: baseUrl + "w342" + poster_path
        imageWidth: 342
        imageHeight: 500
    }

    Rectangle {
        id: contentWrapper

        color: "white"
        radius: 6

        anchors {
            left: artwork.right
            top: parent.top;
            right: parent.right
            bottom: parent.bottom
            margins: 10
        }

        Rectangle {
            id: headerContainer
            color: parent.color
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                margins: 5
            }
            height: titleLabel.height + headerBorder.height

            Label {
                id: titleLabel
                width: parent.width - yearLabel.width
                elide: "ElideRight"
                font {
                    pointSize: headerFontSize
                    bold: true
                }
                text: title
            }

            Label {
                id: yearLabel
                anchors.left: titleLabel.right
                horizontalAlignment: Text.AlignRight
                font {
                    pointSize: headerFontSize
                    bold: true
                }
                text: '(' + release_date.substring(0,4) + ')'
            }

            Rectangle {
                id: headerBorder
                color: "silver"
                anchors {
                    top: titleLabel.bottom
                    left: parent.left
                    right: parent.right
                }
                height: 3
            }
        }

        Rectangle {
            id: contentContainer
            color: parent.color
            anchors {
                left: parent.left
                right: parent.right
                top: headerContainer.bottom
                bottom: footerContainer.top
                margins: 5
            }

            Label {
                anchors.fill: parent
                wrapMode: Text.Wrap
                elide: "ElideRight"
                font.pointSize: contentFontSize
                text: overview
            }
        }

        Rectangle {
            id: footerContainer
            color: parent.color
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: 5
            }
            height: runtimeLabel.height + footerBorder.height

            Rectangle {
                id: footerBorder
                color: "silver"
                anchors {
                    bottom: runtimeLabel.top
                    left: parent.left
                    right: parent.right
                    bottomMargin: 1
                }
                height: 3
            }

            Label {
                id: runtimeLabel
                font {
                    pointSize: footerFontSize
                    bold: true
                }
                text: runtime + qsTr("m") + " "
            }

            Label {
                id: genresLabel
                anchors.left: runtimeLabel.right
                width: parent.width - runtimeLabel.width
                elide: "ElideRight"
                horizontalAlignment: Text.AlignRight
                font {
                    pointSize: footerFontSize
                    italic: true
                }
                text: genreNames
            }
        }
    }

    MouseArea {

        anchors.fill: parent
        onClicked: {
            itemClicked(id)
            container.ListView.view.currentIndex = index
        }
//        onPressAndHold: {
//            itemHeld(id)
//        }

    }

//    GestureMouseArea {

//        anchors.fill: parent

//        onTap: {
//            console.log("TAP")
//        }

//        onHold: {
//            console.log("HOLD")
//        }

//        onSwipeLeft: {
//            console.log("SWIPE LEFT")
//        }

//        onSwipeRight: {
//            console.log("SWIPE RIGHT")
//        }
//    }
}
