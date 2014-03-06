import QtQuick 2.0
import QtQuick.Controls 1.1

// FIXME maybe simple grid layout?
// FIXME need to pull images from local cache rather than tmdb

Rectangle {

    property string baseUrl: "http://image.tmdb.org/t/p/"

    width: parent.width
    height: castProfileImage.height

    Image {
        id : castProfileImage
        source: baseUrl + "w185" + profile_path
        width: 185
        smooth: true
        cache: true
    }

    Label {
        id: castLabel
        width: (parent.width - (castProfileImage.width + asLabel.width + 40)) / 2
        height: castProfileImage.height
        anchors {
            left: castProfileImage.right
            leftMargin: 20
        }
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 14
        elide: Text.ElideRight
        text: name
    }

    Label {
        id: asLabel
        height: castProfileImage.height
        anchors {
            left: castLabel.right
            leftMargin: 20
            rightMargin: 20
        }
        verticalAlignment: Text.AlignVCenter
        font {
            pointSize: 14
            bold: true
            italic: true
        }
        text: qsTr("as")
    }

    Label {
        id: characterLabel
        width: (parent.width - (castProfileImage.width + asLabel.width + 40)) / 2
        height: castProfileImage.height
        anchors {
            left: asLabel.right
            leftMargin: 20
        }
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 14
        elide: Text.ElideRight
        text: character
    }
}
