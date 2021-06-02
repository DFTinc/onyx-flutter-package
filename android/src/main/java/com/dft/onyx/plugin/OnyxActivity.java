package com.dft.onyx.plugin;

import android.app.Activity;
import android.os.Bundle;

import com.dft.onyxcamera.config.Onyx;
import com.dft.onyxcamera.config.OnyxResult;
/**
 * Example activity for running Onyx that has been previously configured.
 */

public class OnyxActivity extends Activity {
    private Onyx configuredOnyx;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }   
    
    @Override
    public void onResume() {
        super.onResume();
        // Setting the activity being used to run Onyx here so that it can be finished
        // from
        // the SuccessCallback in OnyxSetupActivity
        OnyxCallbackHandler.OnyxActivity = this;
        // Get the configured Onyx that was returned from the OnyxCallback
        configuredOnyx = OnyxCallbackHandler.configuredOnyx;

        // Creates Onyx in this activity
        configuredOnyx.create(this);

        // Make Onyx start the capture process
        // Important: configuredOnyx.capture() must occur after configuredOnyx.create()
        // has been called
        if (!configuredOnyx.getOnyxConfig().isManualCapture()) {
            // Start the capture with auto capture process
            configuredOnyx.capture();
        }

    }

    private static OnyxResult _onyxResult;

    // gets the onyx result
    public static OnyxResult getOnyxResult() { return _onyxResult; }

//sets the onyx result.
    public static void setOnyxResult(OnyxResult onyxResult) { _onyxResult = onyxResult; }
        private static OnyxResult onyxResult;
}
