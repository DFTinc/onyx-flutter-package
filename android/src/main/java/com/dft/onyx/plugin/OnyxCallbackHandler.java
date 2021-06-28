
package com.dft.onyx.plugin;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.dft.onyxcamera.config.Onyx;
import com.dft.onyxcamera.config.OnyxConfiguration;
import com.dft.onyxcamera.config.OnyxConfigurationBuilder;
import com.dft.onyxcamera.config.OnyxError;
import com.dft.onyxcamera.config.OnyxResult;
import com.dft.onyxcamera.ui.reticles.Reticle;
import com.dft.onyxcamera.util.UploadMatchResult;
import com.dft.onyxcamera.config.OnyxConfiguration.LayoutPreference;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import 	org.json.JSONObject;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.dft.onyxcamera.util.UploadMatchResult;
/**
 * OnyxPlugin
 */
public class OnyxCallbackHandler implements MethodCallHandler {
    public static Onyx configuredOnyx;
    public static Activity OnyxActivity;

    public OnyxCallbackHandler() {
        super();
    }

    // The fingerprint template valid when setReturnFingerprintTemplate(true) on
    // config
    // private ArrayList<FingerprintTemplate> fingerprintTemplates;
    /// The function that's triggered by the onyx success event.
    private OnyxConfiguration.SuccessCallback successCallback = new OnyxConfiguration.SuccessCallback() {
        @Override
        public void onSuccess(OnyxResult onyxResult) {
            Map<String, Object> args = OnyxCallbackHelpers.getOnyxResultsMap(onyxResult);

            if (onyxResult.getMetrics() != null && onyxResult.getMetrics().getTransactionId() != null) {
                String transactionId = onyxResult.getMetrics().getTransactionId();
                OnyxPlugin.getActivity().runOnUiThread(() -> {
                    Log.i("OnyxPlugin", "creating matches.");
                    UploadMatchResult uploadMatchResult = new UploadMatchResult(OnyxPlugin.applicatonContext,
                            transactionId, false, "INES");
                    uploadMatchResult.uploadMatchResult();
                    args.put("hasMatches",  uploadMatchResult.isSuccessfulMatch());
                    Log.i("OnyxPlugin", "Matches Uploaded.");
                });
                args.put("transactionId", transactionId);
            }
            if (OnyxActivity != null) {
                OnyxActivity.finish();
            }
            OnyxPlugin.getActivity().runOnUiThread(() -> {
                OnyxPlugin.channel.invokeMethod("onyx_success", args);
            });
        }
    };

    /* ONYX-RESULT */

    // The processed fingerprint Bitmap images indexed 0-3 for each finger , 0-3
    // print indicies
    // private ArrayList<Bitmap> processedFingerprintImages;

    // Wave-Length Scalar Quantization for greyscale prints
    // The WSQ data as a byte array
    // private ArrayList<byte[]> wsqData;
    /// The function that's triggered by the onyx error event.
    private OnyxConfiguration.ErrorCallback errorCallback = new OnyxConfiguration.ErrorCallback() {
        @Override
        public void onError(OnyxError onyxError) {
            Log.i("OnyxPlugin", onyxError.getErrorMessage());
            Map<String, Object> args = new HashMap<>();
            args.put("errorMessage", onyxError.getErrorMessage());
            if (OnyxActivity != null) {
                OnyxActivity.finish();
            }
            OnyxPlugin.getActivity().runOnUiThread(() -> {
                OnyxPlugin.channel.invokeMethod("onyx_error", args);
            });
        }
    };
    private OnyxConfiguration.OnyxCallback onyxCallback = new OnyxConfiguration.OnyxCallback() {
        @Override
        public void onConfigured(Onyx onyx) {
            configuredOnyx = onyx;
            if (configuredOnyx != null) {
                OnyxPlugin.getActivity().runOnUiThread(() -> {
                    OnyxPlugin.channel.invokeMethod("onyx_configured", null);
                    Log.i("OnyxPlugin", "onyx configured");
                });
            }
        }
    };

    // #region The callback methods

    /// This should return a flutter callback result
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        try {
            switch (call.method) {
            case "startOnyx": {
                startOnyx();
                result.success("Onyx Started");
                break;
            }
            case "configureOnyx": {
                configureOnyx(call);
                result.success("Onyx Configured");
                break;
            }
            default: {
                result.notImplemented();
                break;
            }
            }
        } catch (Exception ex) {
            Log.i("OnyxPlugin", "Exception: " + ex.getMessage(), ex);
            result.error("1", ex.getMessage(), ex);
        }
    }

    // #region The channel event methods.
    /// starts onyx
    private void startOnyx() {
        Log.i("OnyxPlugin", "Onyx starting");
        OnyxPlugin.getActivity().startActivityForResult(
                new Intent(OnyxPlugin.getActivity(), OnyxActivity.class), 1337);
        Log.i("OnyxPlugin", "Onyx started");
    }

    /// configures onyx.
    private void configureOnyx(@NonNull MethodCall call) {
        Log.i("OnyxPlugin", "Onyx Configuration started");
        OnyxConfigurationBuilder onyxConfigurationBuilder = new OnyxConfigurationBuilder()
                .setActivity(OnyxPlugin.getActivity()).setLicenseKey(call.argument("licenseKey"))
                .setReturnRawImage(OnyxCallbackHelpers.getBoolValue(call, "isReturnRawImage"))
                .setReturnProcessedImage(OnyxCallbackHelpers.getBoolValue(call, "isProcessedImageReturned"))
                .setReturnEnhancedImage(OnyxCallbackHelpers.getBoolValue(call, "isEnhancedImageReturned"))
                .setReturnFullFrameImage(OnyxCallbackHelpers.getBoolValue(call, "isFullFrameImageReturned"))
                .setReturnWSQ(OnyxCallbackHelpers.getBoolValue(call, "isWSQImageReturned"))
                .setReturnFingerprintTemplate(
                        OnyxCallbackHelpers.getBoolValue(call, "isFingerprintTemplateImageReturned"))
        .setReturnPGMFormatByteArray( OnyxCallbackHelpers.getBoolValue(call, "isPGMFormatByteArrayReturned"))
                .setShouldConvertToISOTemplate( OnyxCallbackHelpers.getBoolValue(call, "isConvertToISOTemplate"))
                .setThresholdProcessedImage(OnyxCallbackHelpers.getBoolValue(call, "isImageThreshold"))
                .setShowLoadingSpinner(OnyxCallbackHelpers.getBoolValue(call, "isLoadingSpinnerShown"))
                .setUseOnyxLive(OnyxCallbackHelpers.getBoolValue(call, "isOnyxLive"))
                .setComputeNfiqMetrics(OnyxCallbackHelpers.getBoolValue(call, "isNFIQMetrics"))
                .setUseFlash(OnyxCallbackHelpers.getBoolValue(call, "isUseFlash"))
        .setUseFourFingerReticle(OnyxCallbackHelpers.getBoolValue(call, "isFourFingerReticleUsed"))

                
                .setPerformQualityCheckMatch(OnyxCallbackHelpers.getBoolValue(call, "isPerformQualityCheckMatch"))

                .setUploadMetrics(OnyxCallbackHelpers.getBoolValue(call, "isUploadMetrics"))
                 .setReturnOnlyHighQualityImages(OnyxCallbackHelpers.getBoolValue(call, "isOnlyHighQualityImageReturned"))

        .setReturnOnyxErrorOnNFIQScore5(OnyxCallbackHelpers.getBoolValue(call, "isErrorOnNFIQ5Score"))
      .setEnableShutterSound(OnyxCallbackHelpers.getBoolValue(call, "isShutterSoundEnabled"))
       .setUseCamera2PreviewStreaming(OnyxCallbackHelpers.getBoolValue(call, "isCamera2PreviewStreamingUsed"))
                .setImageRotation(OnyxCallbackHelpers.getIntValue(call, "imageRotation"))
                .setCropSize(OnyxCallbackHelpers.getDoubleValue(call, "cropSizeWidth"),
                        OnyxCallbackHelpers.getDoubleValue(call, "cropSizeHeight"))
                .setCropFactor(OnyxCallbackHelpers.getFloatValue(call, "cropFactor"))

                .setCaptureDistanceRange(19.5f, 29.5f).setSuccessCallback(successCallback)
                .setErrorCallback(errorCallback).setOnyxCallback(onyxCallback);
        // reticleOrientation must come before the reticleAngle property.
        String reticleOrientationText = call.argument("reticleOrientation");
        Reticle.Orientation reticleOrientation =
                // gets the matching enum, or defaults to left.
                Arrays.stream(Reticle.Orientation.values())
                        .filter(e -> e.name().equalsIgnoreCase(reticleOrientationText)).findAny()
                        .orElse(Reticle.Orientation.LEFT);
        onyxConfigurationBuilder.setReticleOrientation(reticleOrientation);

        try {
            onyxConfigurationBuilder.setTargetPixelsPerInch(OnyxCallbackHelpers.getDoubleValue(call, "targetPPI"));
        } catch (Exception ex) {
            // yes. we're assuming the error is due to the targetPPI being null.
            onyxConfigurationBuilder.setTargetPixelsPerInch(-1.0);
        }
        // Reticle Angle overrides Reticle Orientation so have to set this separately
        String reticleAngleText = call.argument("reticleAngle");
        if (reticleAngleText != null && !reticleAngleText.equals("")) {
            onyxConfigurationBuilder.setReticleAngle(OnyxCallbackHelpers.getFloatValue(call, "reticleAngle"));
        }
        if (OnyxCallbackHelpers.getBoolValue(call, "isManualCapture")) {
            onyxConfigurationBuilder.setUseManualCapture(true);
        }
        if(call.argument("FullFrameScaleFactor") != null && call.argument("FullFrameScaleFactor") != "") {
              try{
            onyxConfigurationBuilder.setFullFrameScaleFactor(OnyxCallbackHelpers.getFloatValue(call, "FullFrameScaleFactor"));
              }
               catch(Exception e){}
        }
        Log.i("OnyxPlugin", "layoutPreference: " + call.argument("layoutPreference"));
        if(call.argument("layoutPreference") == "FULL") {
            onyxConfigurationBuilder.setLayoutPreference(LayoutPreference.FULL);
        }
        else if(call.argument("layoutPreference") == "UPPER_THIRD") {
            onyxConfigurationBuilder.setLayoutPreference(LayoutPreference.UPPER_THIRD);
        }

        if(call.argument("uniqueUserId") != null && call.argument("uniqueUserId") != "") {
            onyxConfigurationBuilder.setUniqueUserID(call.argument("uniqueUserId"));
        }
        if(call.argument("lensFocusDistanceCamera2") != null && call.argument("lensFocusDistanceCamera2") != "") {
            try{
                float lensFocusDistanceCamera2Value=OnyxCallbackHelpers.getFloatValue(call, "lensFocusDistanceCamera2");
            onyxConfigurationBuilder.setLensFocusDistanceCamera2(lensFocusDistanceCamera2Value);
            }
            catch(Exception e){}
        }
        if(call.argument("thumbScaleFactor") != null && call.argument("thumbScaleFactor") != "") {
              try{
            onyxConfigurationBuilder.setThumbScaleFactor(OnyxCallbackHelpers.getDoubleValue(call, "thumbScaleFactor")); }
            catch(Exception e){}
        }

        onyxConfigurationBuilder.buildOnyxConfiguration();
        Log.i("OnyxPlugin", "Onyx Configuration Built");
    }
    // #endregion
}
