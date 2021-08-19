# Onyx Flutter Package

This is not free software. This plugin uses the Onyx software development kits (SDKs) for Android and iOS. It requires a license agreement with:[Diamond Fortress Technologies, Inc.](https://diamondfortress.com/)

--------

## Package Requirements

### Sample Project

To run the sample project, run `Example/lib/main.dart`.  The sample app load to a screen that shows all of the onyx camera settings, and provides the ability to start the onyx camera with any of the settings on the initial screen.

### Onyx controls

The `OnyxCamera` class's options contains all of onyx camera options, including the license key.  please see the [documentation](https://pub.dev/documentation/onyx_plugin/latest/onyx/OnyxOptions-class.html) for a complete list of the configuration options.

Once the settings are configured, simply call `OnyxCamera.configureOnyx` to set the onyx configurations, and `OnyxCamera.StartOnyx()` to start the camera.

Listen for changes to the OnyxCamera state to determine when the onyx package is configured (`state=configured`), is returning results(`state=success`), or has an error (`state=error`).

>```dart
>OnyxCamera.state.addListener(() async {
>    setState(() {});
>    if (OnyxCamera.state.status == OnyxStatuses.configured) {
>        await OnyxCamera.startOnyx();
>    }
>});

##### Here's a bare bones implementation for getting started

>```dart
>OnyxCamera.state.addListener(() {
>    if (OnyxCamera.state.status == OnyxStatuses.configured) {
>        //starts onyx after it's configured
>        OnyxCamera.startOnyx();
>    }
>    if (OnyxCamera.state.isError) {
>        //handle any onyx related errors.  error messages are stored in the OnyxCamera.state.resultMessage variable.
>    }
>    if (OnyxCamera.state.status == OnyxStatuses.success) {
>        //do something when the onyx camera sends back results.  OnyxCamera.Results holds the onyx results.
>    }
>});
>//sets the license key
>OnyxCamera.options.licenseKey = "xxxx";
>//starts the onyx camera.
>OnyxCamera.configureOnyx();

--------

## Android setup

The minimum android version supported is `21`.  More details for installing the plugin can be found at [pub.dev](https://pub.dev/packages/onyx_plugin/install).

Add the Onyx native package's repository and dependency references below to your app's `android/app/build.gradle` file.

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
    implementation 'com.dft.android:onyx-camera:7.1.1'
}
```

The plugin also needs permission to write to external storage, so in the app's `AndroidManifest.xml`, make sure to add the line below.

>```xml
><manifest xmlns:android="http://schemas.android.com/apk/res/android">
><uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

--------

## iOS setup

### Onyx must Run on a device, and **will NOT run on an emulator!**

### Set the iOS version to 11.
- [ ] Insure that the `./iOS/PodFile` specifies ios version 11 or later.

```
# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
```

--------

#### Adjust iOS project properties from `XCode`

- [ ]  Disable Bitcode
  >
  >- Select the root directory and go to `Build Settings`
  >- Search for `bitcode`
  >- Set `Enable Bitcode` to `No`

- [ ] Add 4 files to your project's xcodeproj properties. **Otherwise the OnyxCamera will crash!**

  **Steps to add the files to the project**
  >
  > - Select your xcodeproj file from the naviagtion pane on the left
  > - Select `Build Phases`
  >- Expand `Copy Bunde Resources`
  >- Click the `+`
  >- Click `Add Other...`
  >- A Finder window will launch
  >- Navigate to `Pods/OnyxCamera/OnyxCamera/Assets/` source the resource files from here

  **Files To Add**
  >
  >- onyx_4f_logo_v2.png
  >- onyx_4f_logo_v2@2x.png
  >- capturenet.tflite
  >- qualitynet.tflite

--------

#### Adjust the app permissions

- [ ] Open the project's `Info.plist` file, and paste the following lines at the bottom of the `<dict>` element.

    ```XML
   <key>NSCameraUsageDescription</key>
   <string>Capture fingerprint image</string>
  <key>NSPhotoLibraryAddUsageDescription</key>
  <string>Save Onyx Image Results</string>
  <key>NSPhotoLibraryUsageDescription</key>
  <string>Save Pictures</string>

--------

#### Add the navigation controller to the iOS/Runner/AppDelegate file

```objective-c
#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "OnyxPlugin.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    //New Code
    FlutterViewController *flutterViewController =(FlutterViewController*)self.window.rootViewController;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:flutterViewController];
    [navigationController setNavigationBarHidden:YES];    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    OnyxPlugin.flutterViewController=flutterViewController;
    
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end
```
