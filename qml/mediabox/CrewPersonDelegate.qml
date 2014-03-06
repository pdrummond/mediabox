import QtQuick 2.0
import QtQuick.Controls 1.1

// FIXME maybe simple grid layout?
// FIXME show crew department?
// FIXME need to pull images from local cache rather than tmdb

Rectangle {

    property string baseUrl: "http://image.tmdb.org/t/p/"

    width: parent.width
    height: crewProfileImage.height

    Image {
        id : crewProfileImage
        source: baseUrl + "w185" + profile_path
        width: 185
        smooth: true
        cache: true
    }

    Label {
        id: crewLabel
        width: (parent.width - (crewProfileImage.width + 40)) / 2
        height: crewProfileImage.height
        anchors {
            left: crewProfileImage.right
            leftMargin: 20
        }
        font.pointSize: 14
        elide: Text.ElideRight
        text: name
    }

    Label {
        id: jobLabel
        width: (parent.width - (crewProfileImage.width + 40)) / 2
        height: crewProfileImage.height
        anchors {
            left: crewLabel.left
            leftMargin: 20
        }
        font {
            pointSize: 14
            bold: true
            italic: true
        }
        elide: Text.ElideRight
        text: job
    }
}
