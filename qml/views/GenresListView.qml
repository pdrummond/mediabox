import QtQuick 2.2
import QtQuick.Controls 1.1

// FIXME this will be something more general than GenresListView, e.g. ToggleListView or something
//       with a delegate passed in
// FIXME this needs to work like GMail's selection

ListView {

    id: view

    spacing: 3

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
                interop.playKeyClick()
                view.model.setProperty(index, "toggled", !view.model.get(index).toggled)
            }
            onPressAndHold: {
                for (var i = 0; i < genresModel.count; i++) {
                    view.model.setProperty(i, "toggled", false);
                }
                view.model.setProperty(index, "toggled", true);
            }
        }
    }
}
