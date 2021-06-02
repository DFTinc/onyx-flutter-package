package com.dft.onyx.plugin;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodChannel;

/**
 * OnyxPlugin
 */
public class OnyxPlugin implements FlutterPlugin, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native
    /// Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine
    /// and unregister it
    /// when the Flutter Engine is detached from the Activity
    public static MethodChannel channel;
    private static OnyxCallbackHandler channelCallbackHandler = new OnyxCallbackHandler();
    /// Only set activity for v2 embedder. Always access activity from getActivity()
    /// method.
    private static Activity _activity;

    public OnyxPlugin() {
        super();
    }

    // don't get the channel without going through this method.
    public static MethodChannel getChannel() {
        return channel;
    }

    // sets the channel.
    private void setChannel(MethodChannel channel) {
        channel = channel;
    }

    // don't get the activity without going through this method.
    public static Activity getActivity() {
        return _activity;
    }

    // Activity functions

    // sets the activity.
    private void setActivity(Activity activity) {
        _activity = activity;
    }

    public static Context applicatonContext;

    /// FlutterPlugin overrides.
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        applicatonContext = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "com.dft.onyx_plugin/methodChannel");
        channel.setMethodCallHandler(new OnyxCallbackHandler());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        applicatonContext = null;
        channel = null;
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        setActivity(binding.getActivity());
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        setActivity(null);
    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
        setActivity(binding.getActivity());
    }

    @Override
    public void onDetachedFromActivity() {
        setActivity(null);
    }

}