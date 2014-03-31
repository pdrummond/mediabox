package uk.co.caprica.mediabox.android;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.media.AudioManager;
import android.util.Log;

/**
 * Extend the provided QtActivity base class to add required features.
 *
 * This class provides:
 *
 *  - ability to play native sound effects
 */
public class MediaBoxActivity extends org.qtproject.qt5.android.bindings.QtActivity {

    /**
     * Log tag.
     */
    private static final String TAG = "AndroidTest";

    /**
     * Activity instance.
     *
     * Unfortunately it has to be this way, i.e. the instance when it is created sets this static
     * field. However it does work as only one instance will ever be active at any one time.
     */
    private static MediaBoxActivity instance;

    /**
     * Create an activity.
     */
    public MediaBoxActivity() {
        this.instance = this;
    }

    /**
     * Interop function that plays a native sound effect.
     *
     * @param type type of sound effect to play
     */
    public static void playSoundEffect(int type) {
        Log.v(TAG, "[>] playSoundEffect(type=" + type + ")");
        AudioManager audioManager = (AudioManager) instance.getSystemService(Context.AUDIO_SERVICE);
        audioManager.playSoundEffect(type);
        Log.v(TAG, "[<] playSoundEffect()");
    }
}
