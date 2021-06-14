# DFT-onyx-flutter-package

This is not free software. This plugin uses the Onyx software development kits (SDKs) for Android and iOS. It requires a license agreement with:[Diamond Fortress Technologies, Inc.](https://diamondfortress.com/)

# Plugin Requirements

## Sample Project

To run the sample project, run the Example/lib/main.dart.

The sample app load to a screen that shows all of the onyx camera settings, and  provides the ability to start the onyx camera with any of the settings on the initial screen.

## Onyx controls

The OnyxCamera class's options contains all of onyx camera options, including the license key.  please see the [documentation](https://pub.dev/documentation/onyx_plugin/latest/onyx/OnyxOptions-class.html) for a complete list of the configuration options.

Once the settings are configured, simply call OnyxCamera.configureOnyx to set the onyx configurations.  and OnyxCamera.StartOnyx() to start the camera.

Listen for changes to the OnyxCamera state to determine when the onyx plugin is configured (state=configured), is returning results(state = success), or has an error (state=error).

```dart
OnyxCamera.state.addListener(() async {
    setState(() {});
    if (OnyxCamera.state.status == OnyxStatuses.configured) {
        await OnyxCamera.startOnyx();
    }
});
```

### Here's a bare bones implementation for getting started

```dart
OnyxCamera.state.addListener(() {
    if (OnyxCamera.state.status == OnyxStatuses.configured) {
        //starts onyx after it's configured
        OnyxCamera.startOnyx();
    }
    if (OnyxCamera.state.isError) {
        //handle any onyx related errors.  error messages are stored in the OnyxCamera.state.resultMessage variable.
    }
    if (OnyxCamera.state.status == OnyxStatuses.success) {
        //do something when the onyx camera sends back results.  OnyxCamera.Results holds the onyx results.
    }
});
//sets the license key
OnyxCamera.options.licenseKey = "xxxx";
//starts the onyx camera.
OnyxCamera.configureOnyx();
```

## Android Plugin

The minimum android version supported is 21.  More details for installing the plugin can be found at [pub.dev](https://pub.dev/packages/onyx_plugin/install).

Add the Onyx native package's repository and dependency references below to your app's android/app/build.gradle file.

```Groovy
android {
    lintOptions {
        disable 'InvalidPackage'
    }
}
repositories {
    maven {
        url 'http://nexus.diamondfortress.com/nexus/content/repositories/releases/'
    }
    maven {
        url 'http://nexus.diamondfortress.com/nexus/content/repositories/snapshots/'
    }
}
dependencies {
implementation 'androidx.constraintlayout:constraintlayout:2.0.4'
implementation 'com.google.android.gms:play-services-base:17.6.0'
implementation 'com.dft.android:onyx-camera:7.0.0'
}
```

The plugin also needs permission to write to external storage, so in the app's AndroidManifest.xml, make sure to add the line below.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```
