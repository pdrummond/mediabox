import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtMultimedia 5.0

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

// FIXME need to pull images from local cache rather than tmdb

Rectangle {

    property string baseUrl: "http://image.tmdb.org/t/p/"

    property int headerFontSize: 16
    property int contentFontSize: 14
    property int footerFontSize: 12

    signal itemClicked(int mediaId)
    signal itemHeld(int mediaId)

    width: parent.width

    // FIXME is there a better way? this is imageHeight + 2 * borderWidth + 2 * margins
    height: 500 + 6 + 10

    color: "#d9d9cf"
    radius: 10

    RowLayout {
        id: content

        anchors.margins: 5
        anchors.fill: parent
        spacing: 5

        LineBorderedImage {
            color: "black"
            borderWidth: 3
            radius: 6
            imageSource: baseUrl + "w342" + poster_path
            imageWidth: 342
            imageHeight: 500
            Layout.alignment: Qt.AlignTop
        }

        ColumnLayout {

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                anchors.fill: parent

                color: "white"
                radius: 6

                Rectangle {
                    id: headerContainer
                    color: parent.color
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                        margins: 5
                    }

                    height: Math.max(titleLabel.height, yearLabel.height)
                    width: parent.width

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
                }

                Rectangle {
                    id: contentContainer
                    color: parent.color
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: headerContainer.bottom
                        margins: 5
                    }
                    height: parent.height - (headerContainer.height + footerContainer.height + (2 * (headerContainer.anchors.margins + footerContainer.anchors.margins)))

                    Label {
                        anchors.fill: parent
                        wrapMode: Text.Wrap
                        elide: "ElideRight"
                        font {
                            pointSize: contentFontSize
                        }
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
                    height: Math.max(runtimeLabel.height, genresLabel.height)

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
