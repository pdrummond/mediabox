import QtQuick 2.0

ListView {
    spacing: 5
    clip: true
    maximumFlickVelocity: 6000 //Flick speed on Android is slow without this
    cacheBuffer: 10000
    smooth: true
}
