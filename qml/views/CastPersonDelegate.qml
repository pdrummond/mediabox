import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import MediaBox 1.0

// FIXME need to pull images from local cache rather than tmdb

Rectangle {

    property string baseUrl: "http://image.tmdb.org/t/p/"

    width: parent.width

    // FIXME is there a better way? this is imageHeight + 2 * borderWidth + 2 * margins
    height: 278 + 6 + 10

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
            imageSource: baseUrl + "w185" + profile_path
            imageWidth: 185
            imageHeight: 278
            Layout.alignment: Qt.AlignTop
        }

        ColumnLayout {

            Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                anchors.margins: 10
                font.bold: true
                elide: Text.ElideRight
                text: name
            }

            Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignBottom
                anchors.margins: 10
                font.italic: true
                elide: Text.ElideRight
                text: character
            }
        }
    }
}
