import QtQuick 2.0

ListView {

    width: parent.width
    height: parent.height

    anchors.fill: parent

    maximumFlickVelocity: 6000 //Flick speed on Android is slow without this
    cacheBuffer: 10000
    smooth: true

    model: ListModel {
        id: peopleModel
    }

    function setPeople(people) {
        peopleModel.clear()
        var person;
        for (var i = 0; i < people.length; i++) {
            person = people[i];
            if (person.profile_path) { // FIXME!
                peopleModel.append(person)
            }
        }
    }
}
