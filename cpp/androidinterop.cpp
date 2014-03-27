#include "androidinterop.h"

#include <QAndroidJniObject>

const char* AndroidInterop::JAVA_CLASS_NAME = "uk/co/caprica/mediabox/android/MediaBoxActivity";

AndroidInterop::AndroidInterop(QObject *parent) : QObject(parent) {
}

void AndroidInterop::playKeyClick() {
    playSoundEffect(FX_KEY_CLICK);
}

void AndroidInterop::playSoundEffect(int type) {
    // FIXME for now we have to have an object return type to prevent SIGSEGV on return or so it seems
    //       i.e. the JNI signature should be "(I)V" ?
    QAndroidJniObject::callStaticObjectMethod(
        JAVA_CLASS_NAME,
        "playSoundEffect",
        "(I)Ljava/lang/String;",
        type
    );
}
