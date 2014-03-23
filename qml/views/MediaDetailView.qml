import QtQuick 2.0
import QtQuick.Controls 1.1

import MediaBox 1.0

// FIXME shouldn't this only be imported once on the main page!?
// FIXME this relative path is ugly
import "../js/movies.js" as Movies;

// FIXME whole thing needs to scroll vertically to fit content (maybe don't scroll title)
// FIXME maybe swipe left/right to show cast/crew/chapters/bookmarks and so on?

// FIXME title needs more padding like the cast/crew (but no border!)
// FIXME overview bottom border is not quite right wrt the top border

// FIXME need to defer presentation/transition until image loaded or something

// Things i learned - to have a margin, you must have an anchor! seems obvious in hindsight

// FIXME need to use titledview

// FIXME need to stop e.g. double-taps spawning two person views on top of each other

Item {

    property string baseUrl: "http://image.tmdb.org/t/p/"

    property int headerFontSize: 16

    // FIXME a better way?
    property int mediaId
    property variant currentMedia

    signal castActivated
    signal crewActivated
    signal playActivated

    height: 62

    Rectangle {
        id: contentWrapper
        color: "white"
        radius: 6
        anchors {
            fill: parent
//            margins: 10
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
            }

            Label {
                id: yearLabel
                anchors.left: titleLabel.right
                horizontalAlignment: Text.AlignRight
                font {
                    pointSize: headerFontSize
                    bold: true
                }
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
            id: artworkContainer
            anchors {
                left: parent.left
                right: parent.right
                top: headerContainer.bottom
                margins: 5
            }
            width: parent.width
            height: artwork.height

            LineBorderedImage {
                anchors.fill: parent
                id: artwork
                color: "black"
                borderWidth: 3
                radius: 6
//                imageSource: baseUrl + "w1280" + backdrop_path
                imageWidth: parent.width - (2 * borderWidth) // FIXME this adjustment should not be needed
                imageHeight: 500
                fillMode: Image.PreserveAspectCrop
            }
        }

        Rectangle {
            id: contentTopBorder
            color: "silver"
            anchors {
                top: artworkContainer.bottom
                left: parent.left
                right: parent.right
                margins: 5
            }
            height: 3
        }

        Rectangle {
            id: castWrapper
            color: "black"
            radius: 6

            anchors {
                left: parent.left
                right: parent.right
                top: contentTopBorder.bottom
                margins: 5
            }

            height: castContainer.height + (2 * castContainer.anchors.margins)

            Rectangle {
                id: castContainer
                radius: 6
                color: "white"
                anchors {
                    top: castWrapper.top
                    left: parent.left
                    right: parent.right
                    margins: 2
                }
                height: starringLabel.height + (2 * starringLabel.anchors.margins)

                Label {
                    id: starringLabel

                    anchors {
                        left: castContainer.left
                        top: castContainer.top
                        margins: 10
                    }

                    text: qsTr("Starring")

                    font.pointSize: headerFontSize
                }

                Label {
                    id: castLabel
                    anchors {
                        top: castContainer.top
                        left: starringLabel.right
                        right: parent.right
                        margins: 10
                    }
                    elide: Text.ElideRight
                    width: parent.width - (starringLabel.width + 2 * starringLabel.anchors.margins)
                    font {
                        pointSize: headerFontSize
                        bold: true
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: castActivated()
            }
        }

        Rectangle {
            id: crewWrapper
            color: "black"
            radius: 6

            anchors {
                left: parent.left
                right: parent.right
                top: castWrapper.bottom
                margins: 5
            }

            height: crewContainer.height + (2 * crewContainer.anchors.margins)

            Rectangle {
                id: crewContainer
                radius: 6
                color: "white"
                anchors {
                    top: crewWrapper.top
                    left: parent.left
                    right: parent.right
                    margins: 2
                }
                height: directedByLabel.height + (2 * directedByLabel.anchors.margins)

                Label {
                    id: directedByLabel

                    anchors {
                        left: crewContainer.left
                        top: crewContainer.top
                        margins: 10
                    }

                    text: qsTr("Directed by")

                    font.pointSize: headerFontSize
                }

                Label {
                    id: directorLabel
                    anchors {
                        top: crewContainer.top
                        left: directedByLabel.right
                        right: parent.right
                        margins: 10
                    }
                    elide: Text.ElideRight
                    width: parent.width - (directedByLabel.width + 2 * directedByLabel.anchors.margins)
                    font {
                        pointSize: headerFontSize
                        bold: true
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: crewActivated()
            }
        }

        Rectangle {
            id: overviewTopBorder
            color: "silver"
            anchors {
                top: crewWrapper.bottom
                left: parent.left
                right: parent.right
                margins: 5
            }
            height: 3
        }

        Rectangle {
            id: overviewWrapper
            width: parent.width
            height: overviewContainer.height + (2 * overviewContainer.anchors.margins)
            anchors {
                left: parent.left
                right: parent.right
                top: overviewTopBorder.bottom
                margins: 10
            }

            Rectangle {
                id: overviewContainer

                radius: 6
                color: "white"
                anchors {
                    top: overviewWrapper.top
                    left: parent.left
                    right: parent.right
                    margins: 20
                }
                height: overviewLabel.height //+ (2 * overviewLabel.anchors.margins)

                Label {
                    id: overviewLabel
                    width: parent.width
    //                height: parent.parent.height - (titleLabel.height + backdropImage.height + directionWrapper.height + castWrapper.height + genreWrapper.height + buttonsWrapper.height) // FIXME all the margins too
                    elide: Text.ElideRight
                    wrapMode: Text.Wrap
                    font.pointSize: headerFontSize
                }
            }
        }

        Rectangle {
            id: overviewBottomBorder
            color: "silver"
            anchors {
                top: overviewWrapper.bottom
                left: parent.left
                right: parent.right
                margins: 5
            }
            height: 3
        }

        Rectangle {
            id: genresWrapper
            anchors {
                top: overviewBottomBorder.bottom
                left: parent.left
                right: parent.right
                margins: 5
            }
            height: genresLabel.height + (2 * genresLabel.anchors.margins)

            Label {
                id: runtimeLabel
                anchors {
                    top: parent.top
                    left: parent.left
                }
                font {
                    pointSize: headerFontSize
                    bold: true
                }
            }

            Label {
                id: genresLabel
                anchors {
                    top: parent.top
                    left: runtimeLabel.right
                    right: parent.right
                    leftMargin: 5
                    rightMargin: 5
                }
                width: parent.width - runtimeLabel.width
                elide: Text.ElideRight
                font {
                    pointSize: headerFontSize
                    italic: true
                    bold: true
                }
                horizontalAlignment: Text.AlignRight
            }
        }

        Rectangle {
            id: genresBottomBorder
            color: "silver"
            anchors {
                top: genresWrapper.bottom
                left: parent.left
                right: parent.right
                margins: 5
            }
            height: 3
        }

        Rectangle {
            id: buttonsWrapper
            height: buttonsContainer.height + (2* buttonsContainer.anchors.margins)
            anchors {
                top: genresBottomBorder.bottom
                left: parent.left
                right: parent.right
                margins: 5
            }

            Rectangle {
                id: buttonsContainer
                height: playMediaButton.height + (2 * playMediaButton.anchors.margins)
                anchors {
                    fill: parent
                    left: parent.left
                    right: parent.right
                }

                Button {
                    width: 400
                    height: 200
                    anchors.margins: 20
                    anchors.verticalCenter: buttonsContainer.verticalCenter
                    anchors.horizontalCenter: buttonsContainer.horizontalCenter
                    id: playMediaButton
                    text: qsTr("Play")
                    iconSource: "qrc:/mediabox/qml/images/xxhdpi/ic_action_play.png"
                    onClicked: playActivated()
                }
            }
        }
    }

    onCurrentMediaChanged: {
        setMovie(currentMedia)
    }

    function setMovie(movie) {
        mediaId = movie.id;
        // FIXME needs to hide/show/animate or whatever nicely - right now it displays old details before new loads
        // 300, 780, 1280

        titleLabel.text = movie.title;
        yearLabel.text = '(' + movie.release_date.substring(0,4) + ')';

        artwork.imageSource = baseUrl + "w1280" + movie.backdrop_path

        overviewLabel.text = movie.overview;
        genresLabel.text = movie.genreNames;

        var i;

        var castValue = "";
        for (i = 0; i < movie.credits.cast.length; i++) {
            if (i > 0) {
                castValue += ", "
            }
            castValue += movie.credits.cast[i].name
        }
        castLabel.text = castValue

        var directorValue = ""
        var crew
        for (i = 0; i < movie.credits.crew.length; i++) {
            crew = movie.credits.crew[i]
            if (crew.job === "Director") {
                if (directorValue.length > 0) {
                    directorValue += ", "
                }
                directorValue += crew.name
            }
        }
        directorLabel.text = directorValue

        runtimeLabel.text = movie.runtime + qsTr("m");
    }
}
