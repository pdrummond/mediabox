#include "androidinterop.h"

#include <QAndroidJniObject>

const char* AndroidInterop::JAVA_CLASS_NAME = "uk/co/caprica/mediabox/android/MediaBoxActivity";

AndroidInterop::AndroidInterop(QObject *parent) : QObject(parent) {
}

void AndroidInterop::playKeyClick() {
    playSoundEffect(FX_KEY_CLICK);
}

void AndroidInterop::playSoundEffect(int type) {
#ifdef Q_OS_ANDROID
    QAndroidJniObject::callStaticMethod<void>(
        JAVA_CLASS_NAME,
        "playSoundEffect",
        "(I)V",
        type
    );
#endif
}
