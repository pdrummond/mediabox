#ifndef ANDROIDINTEROP_H
#define ANDROIDINTEROP_H

#include <QObject>

/**
 * @brief Provide access to functions available on the Android platform but not exposed by Qt.
 */
class AndroidInterop : public QObject {

    Q_OBJECT

public:

    /**
     * @brief Constructor
     *
     * @param parent
     */
    explicit AndroidInterop(QObject *parent = 0);

    /**
     * @brief Play the standard "key click" sound effect.
     */
    Q_INVOKABLE void playKeyClick();

private:

    /**
     * @brief Play a standard sound effect.
     *
     * @param type type of sound effect to play
     */
    void playSoundEffect(int type);

    /**
     * @brief Fully qualified name of the Java class implementing the interop functions.
     */
    static const char *JAVA_CLASS_NAME;

    /**
     * @brief Constant values for sound effect types.
     *
     * Defined here: https://github.com/android/platform_frameworks_base/blob/master/media/java/android/media/AudioManager.java
     */
    static const int FX_KEY_CLICK = 0;
    static const int FX_FOCUS_NAVIGATION_UP = 1;
    static const int FX_FOCUS_NAVIGATION_DOWN = 2;
    static const int FX_FOCUS_NAVIGATION_LEFT = 3;
    static const int FX_FOCUS_NAVIGATION_RIGHT = 4;
    static const int FX_KEYPRESS_STANDARD = 5;
    static const int FX_KEYPRESS_SPACEBAR = 6;
    static const int FX_KEYPRESS_DELETE = 7;
    static const int FX_KEYPRESS_RETURN = 8;
    static const int FX_KEYPRESS_INVALID = 9;

signals:

public slots:

};

#endif // ANDROIDINTEROP_H
