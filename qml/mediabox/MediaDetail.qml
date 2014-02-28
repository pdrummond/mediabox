import QtQuick 2.0

Rectangle {
    width: 100
    height: 62

    focus: true

    anchors.fill: parent

    Text {
        width: parent.width
        text: "Media Detail View"
    }

    Keys.onPressed: {
        if (visible) {
            if (event.key === Qt.Key_Back || event.key === Qt.Key_Escape) {
                main.state = 'MOVIES'
                event.accepted = true
            }
        }
    }

}
