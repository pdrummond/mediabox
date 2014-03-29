import QtQuick 2.2

ListView {
    spacing: 3
    clip: true
    maximumFlickVelocity: 6000 //Flick speed on Android is slow without this
    cacheBuffer: 10000
    smooth: true
}
