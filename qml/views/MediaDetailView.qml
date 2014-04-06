import QtQuick 2.2
import QtQuick.Controls 1.1

import MediaBox 1.0

// FIXME shouldn't this only be imported once on the main page!?
// FIXME this relative path is ugly
import "../js/movies.js" as Movies;

// FIXME need to defer presentation/transition until image loaded or something

TitledView {

    property int headerFontSize: 16
    property int overviewFontSize: 14

    // FIXME a better way?
    property int mediaId
    property variant currentMedia

    signal castActivated
    signal crewActivated
    signal playActivated

    header: Rectangle {

        width: parent.width
        height: childrenRect.height

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
    }

    content: Rectangle {
        id: contentWrapperNew
        anchors.fill: parent

        Rectangle {
            id: artworkContainer
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
            width: parent.width
            height: artwork.height

            LineBorderedImage {
                id: artwork
                anchors.fill: parent
                color: "black"
                borderWidth: 3
                radius: 6
                imageWidth: parent.width - (2 * borderWidth) // FIXME this adjustment should not be needed
                imageHeight: 500
                fillMode: Image.PreserveAspectCrop
            }
        }

        LabelValueButton {
            id: castView
            anchors {
                left: parent.left
                right: parent.right
                top: artworkContainer.bottom
                topMargin: 10
            }
            label: qsTr("Starring")
            onClicked: castActivated()
        }

        LabelValueButton {
            id: crewView
            anchors {
                left: parent.left
                right: parent.right
                top: castView.bottom
                topMargin: 10
            }
            label: qsTr("Directed by")
            onClicked: crewActivated()
        }

        Rectangle {
            id: overviewTopBorder
            anchors {
                left: parent.left
                right: parent.right
                top: crewView.bottom
                topMargin: 10
            }
            height: 3
            color: "silver"
        }

        Rectangle {
            id: overviewContainer
            color: "white"
            anchors {
                left: parent.left
                right: parent.right
                top: overviewTopBorder.bottom
                bottom: overviewBottomBorder.top
            }
            clip: true

            // FIXME the width of the flickable text should be reduced to accommodate the scrollbar *when it is visible*, or should have some margin to leave space for it
            Flickable {
                id: overviewFlickable
                anchors.fill: parent
                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.StopAtBounds
                contentWidth: overviewLabel.width
                contentHeight: overviewLabel.height

                Label {
                    id: overviewLabel
                    width: overviewContainer.width
                    wrapMode: Text.Wrap
                    font.pointSize: overviewFontSize
                }
            }

            Rectangle {
                id: scrollbar
                color: "#60000000"
                anchors.right: overviewFlickable.right
                y: overviewFlickable.visibleArea.yPosition * overviewFlickable.height
                width: 10
                height: overviewFlickable.visibleArea.heightRatio * overviewFlickable.height
                visible: overviewFlickable.height < overviewFlickable.contentItem.height
            }
        }

        Rectangle {
            id: overviewBottomBorder
            anchors {
                left: parent.left
                right: parent.right
                bottom: bottomInfoBorder.top
                bottomMargin: 10
            }
            height: 3
            color: "silver"
        }

        Rectangle {
            id: bottomInfoBorder
            anchors {
                left: parent.left
                right: parent.right
                bottom: bottomInfoContainer.top
            }
            height: 3
            color: "silver"
        }

        Rectangle {
            id: bottomInfoContainer
            anchors {
                left: parent.left
                right: parent.right
                bottom: buttonContainerBorder.top
            }
            height: childrenRect.height

            Label {
                id: runtimeLabel
                anchors {
                    top: parent.top
                    left: parent.left
                    leftMargin: 5
                    rightMargin: 5
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
            id: buttonContainerBorder
            anchors {
                left: parent.left
                right: parent.right
                bottom: buttonContainer.top
                bottomMargin: 10
            }
            height: 3
            color: "silver"
        }

        Rectangle {
            id: buttonContainer
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: childrenRect.height

            Button {
                id: playMediaButton
                width: 400
                height: 200
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                text: qsTr("Play")
                iconSource: "qrc:/mediabox/qml/images/xxhdpi/ic_action_play.png"
                onClicked: playActivated()
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

        artwork.imageSource = "http://" + main.mediaboxHost + ":" + main.mediaboxPort + "/mediabox/movie/" + mediaId + "/backdrop";
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
        castView.value = castValue

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
        crewView.value = directorValue

        runtimeLabel.text = movie.runtime + qsTr("m");
    }
}
