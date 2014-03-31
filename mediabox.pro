cache()

TEMPLATE = app
QT      += qml quick gui network androidextras
TARGET   = MediaBox

INCLUDEPATH +=                                         \
    $$PWD/cpp

HEADERS +=                                             \
    $$PWD/cpp/networkdiscovery.h                       \
    $$PWD/cpp/androidinterop.h

SOURCES +=                                             \
    $$PWD/main.cpp                                     \
    $$PWD/cpp/networkdiscovery.cpp                     \
    $$PWD/cpp/androidinterop.cpp

APP_FILES +=                                           \
    $$PWD/qml/main.qml                                 \
    $$PWD/qml/components/LineBorderedImage.qml         \
    $$PWD/qml/components/PersonView.qml                \
    $$PWD/qml/components/StandardSlider.qml            \
    $$PWD/qml/components/TitledView.qml                \
    $$PWD/qml/views/AudioEqualizerView.qml             \
    $$PWD/qml/views/BasePage.qml                       \
    $$PWD/qml/views/CastPersonDelegate.qml             \
    $$PWD/qml/views/CrewPersonDelegate.qml             \
    $$PWD/qml/views/GenresListView.qml                 \
    $$PWD/qml/views/MediaDetailView.qml                \
    $$PWD/qml/views/MediaPlayerView.qml                \
    $$PWD/qml/views/MenuItemView.qml                   \
    $$PWD/qml/views/MenuView.qml                       \
    $$PWD/qml/views/MovieDelegate.qml                  \
    $$PWD/qml/views/MoviesListView.qml                 \
    $$PWD/qml/views/VideoAdjustView.qml

APP_FILES +=                                           \
    $$PWD/qml/js/movies.js

APP_FILES +=                                           \
    $$PWD/qml/images/xxhdpi/ic_action_camera.png       \
    $$PWD/qml/images/xxhdpi/ic_action_cast.png         \
    $$PWD/qml/images/xxhdpi/ic_action_fast_forward.png \
    $$PWD/qml/images/xxhdpi/ic_action_headphones.png   \
    $$PWD/qml/images/xxhdpi/ic_action_next.png         \
    $$PWD/qml/images/xxhdpi/ic_action_overflow.png     \
    $$PWD/qml/images/xxhdpi/ic_action_pause.png        \
    $$PWD/qml/images/xxhdpi/ic_action_play.png         \
    $$PWD/qml/images/xxhdpi/ic_action_previous.png     \
    $$PWD/qml/images/xxhdpi/ic_action_rewind.png       \
    $$PWD/qml/images/xxhdpi/ic_action_search.png       \
    $$PWD/qml/images/xxhdpi/ic_action_stop.png         \
    $$PWD/qml/images/xxhdpi/ic_action_video.png        \
    $$PWD/qml/images/xxhdpi/ic_action_volume_muted.png \
    $$PWD/qml/images/xxhdpi/ic_action_volume_on.png    \
    $$PWD/qml/images/xxhdpi/ic_drawer.png

APP_FILES +=                                                         \
    android/src/uk/co/caprica/mediabox/android/MediaBoxActivity.java

OTHER_FILES +=                  \
    android/AndroidManifest.xml \
    $$APP_FILES

GENERATED_RESOURCE_FILE = $$OUT_PWD/mediabox.qrc

RESOURCE_CONTENT =    \
    "<RCC>"           \
    "    <qresource>"

for (resourceFile, APP_FILES) {
    resourceFileAbsolutePath = $$absolute_path($$resourceFile)
    relativePathIn = $$relative_path($$resourceFileAbsolutePath, $$_PRO_FILE_PWD_)
    relativePathOut = $$relative_path($$resourceFileAbsolutePath, $$OUT_PWD)
    RESOURCE_CONTENT += "        <file alias=\"mediabox/$$relativePathIn\">$$relativePathOut</file>"
}

RESOURCE_CONTENT +=    \
    "    </qresource>" \
    "</RCC>"

write_file($$GENERATED_RESOURCE_FILE, RESOURCE_CONTENT) | error("Aborting.")

RESOURCES += $$GENERATED_RESOURCE_FILE

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
