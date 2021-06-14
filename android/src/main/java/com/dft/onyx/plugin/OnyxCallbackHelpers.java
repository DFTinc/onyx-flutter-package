package com.dft.onyx.plugin;

import android.graphics.Bitmap;
import android.util.Log;

import androidx.annotation.NonNull;

import com.dft.onyx.FingerprintTemplate;
import com.dft.onyx.NfiqMetrics;
import com.dft.onyxcamera.config.OnyxResult;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONObject;
import org.json.JSONArray;

import io.flutter.plugin.common.MethodCall;

/// the callback helper classes
public class OnyxCallbackHelpers {
    OnyxCallbackHelpers() {
        super();
    }

    /// Gets the bool value from a call parameter
    public static Boolean getBoolValue(@NonNull MethodCall call, String propertyName) {
        String boolValue = call.argument(propertyName);
        Log.i("OnyxPlugin", propertyName + " " + boolValue);
        return Boolean.parseBoolean(boolValue);
    }

    /// Gets the integer value from a call parameter
    public static Integer getIntValue(@NonNull MethodCall call, String propertyName) {
        String result = call.argument(propertyName);
        Log.i("OnyxPlugin", propertyName + " " + result);
        return Integer.valueOf(result);
    }

    /// Gets the double value from a call parameter
    public static Double getDoubleValue(@NonNull MethodCall call, String propertyName) {
        String result = call.argument(propertyName);
        Log.i("OnyxPlugin", propertyName + " " + result);
        return Double.valueOf(result);
    }

    /// Gets the float value from a call parameter
    public static Float getFloatValue(@NonNull MethodCall call, String propertyName) {
        String result = call.argument(propertyName);
        Log.i("OnyxPlugin", propertyName + " " + result);
        return Float.valueOf(result);
    }

    /// maps a list of bitmap values to a channel message's arguments.
    public static void addBitmapsArg(Map<String, Object> args, String argumentName, ArrayList<Bitmap> bitmaps) {
        if (bitmaps == null || bitmaps.isEmpty()) {
            return;
        }
        ArrayList<Object> argValue = new ArrayList<>();
        for (Bitmap bmImage : bitmaps) {
            if (bmImage != null) {
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                bmImage.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
                argValue.add(outputStream.toByteArray());
            }
        }
        if (!argValue.isEmpty()) {
            args.put(argumentName, argValue);
        }
    }

    /// populates a map with the onyx results.
    public static Map<String, Object> getOnyxResultsMap(OnyxResult onyxResult) {
        Map<String, Object> args = new HashMap<>();
        JSONObject jsonResult = new JSONObject();
        OnyxCallbackHelpers.addBitmapsArg(args, "rawFingerprintImages", onyxResult.getRawFingerprintImages());
        OnyxCallbackHelpers.addBitmapsArg(args, "processedFingerprintImages", onyxResult.getProcessedFingerprintImages());
        OnyxCallbackHelpers.addBitmapsArg(args, "enhancedFingerprintImages", onyxResult.getEnhancedFingerprintImages());
        args.put("wsqData", onyxResult.getWsqData());
        args.put("pgmData", onyxResult.getPgmData());
        if(onyxResult.getFullFrameImage() != null){
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        onyxResult.getFullFrameImage().compress(Bitmap.CompressFormat.PNG, 100, outputStream);
        args.put("fullFrameImage",   outputStream.toByteArray());
        }
        args.put("fingerprintTemplates",   getTemplateMaps(onyxResult.getFingerprintTemplates()));
         if (onyxResult.getMetrics() != null) {
             com.dft.onyxcamera.ui.CaptureMetrics metrics=onyxResult.getMetrics();
             args.put("livenessConfidence", metrics.getLivenessConfidence());
             args.put("focusQuality", metrics.getFocusQuality());
             if (metrics.getNfiqMetrics() != null) {
                 ArrayList<Object> nfiqScores = new ArrayList<>();
                 ArrayList<Object> mlpScores = new ArrayList<>();
                 List<NfiqMetrics> nfiqMetricsList = metrics.getNfiqMetrics();
                 for (int i = 0; i < nfiqMetricsList.size(); i++) {
                     if (nfiqMetricsList.get(i) != null) {
                         String nfiqScore = "";
                         String mlpScore = "";
                         nfiqScore = String.valueOf(nfiqMetricsList.get(i).getNfiqScore());
                         mlpScore =  String.valueOf(nfiqMetricsList.get(i).getMlpScore());
                         if (nfiqScore != "") {
                             nfiqScores.add(nfiqScore);
                         }
                         if (mlpScore != "") {
                             mlpScores.add(mlpScore);
                         }
                     }
                 }
                 args.put("nfiqScores", nfiqScores);
                 args.put("mlpScores", mlpScores);
             }
         }
        return args;
    }
    
    private static  ArrayList<Object>  getTemplateMaps(ArrayList<FingerprintTemplate> templates){
        ArrayList<Object> results = new ArrayList<>();
        for (FingerprintTemplate finger : templates) {
            if(!finger.isEmpty()) {
                Map<String, Object> fingerMap = new HashMap<>();
                fingerMap.put("image", finger.getData());
                fingerMap.put("nfiqScore", finger.getNfiqScore());
                fingerMap.put("quality", finger.getQuality());
                fingerMap.put("customId", finger.getCustomId());
                fingerMap.put("location", finger.getFingerLocation().toString());
                results.add(fingerMap);
            }
        }
        return results;
    }
}