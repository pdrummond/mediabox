import QtQuick 2.0
import QtQuick.Controls 1.1

// FIXME wrap in a rectangle?
// FIXME this will be something more general than GenresListView, e.g. ToggleListView or something
//       with a delegate passed in
// FIXME this needs to work like GMail's selection

ListView {

    id: view

    spacing: 5

    delegate: Rectangle {

        color: !toggled ? "white" : "lightsteelblue"

        radius: 5

        width: parent.width
        height: 200

        Label {
            id: label
            anchors.fill: parent
            text: genre
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                view.model.setProperty(index, "toggled", !view.model.get(index).toggled);
            }
            onPressAndHold: {
                for (var i = 0; i < genresModel.count; i++) {
                    view.model.setProperty(i, "toggled", false);
                }
                view.model.setProperty(index, "toggled", true);
            }
        }
    }

    Keys.onPressed: {
        if (visible && focus) {
            if (event.key === Qt.Key_Back || event.key === Qt.Key_Backspace) {
                main.state = 'TYPES'
                event.accepted = true
            }
        }
    }
}
