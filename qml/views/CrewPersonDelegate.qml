import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import MediaBox 1.0

// FIXME need to pull images from local cache rather than tmdb
// FIXME the only difference between Cast and Crew delegates is where the text properties come from, can this be combined into one delegate?
// FIXME show crew department?
// FIXME should show each person only once, even if they have multiple different job credits?

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
                font.bold: true
                anchors.margins: 10
                elide: Text.ElideRight
                text: name
            }

            Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignBottom
                anchors.margins: 10
                font.italic: true
                elide: Text.ElideRight
                text: job
            }
        }
    }
}
