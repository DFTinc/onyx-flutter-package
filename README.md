# DFT-onyx-flutter-package

The onyx flutter plugin repo for Diamond Fortress Technologies, Inc.

The flutter demo project can be found in the onyx_plugin/example folder.

# Plugin Requirements

## Android

Minimum android version supported is 21.

Add the Onyx native package's repository and depenency references belo to your app's android/app/build.gradle file.

'''
android {
...
lintOptions {
disable 'InvalidPackage'
}
...
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
//implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
implementation 'androidx.constraintlayout:constraintlayout:2.0.4'
implementation 'com.google.android.gms:play-services-base:17.6.0'
implementation 'com.dft.android:onyx-camera:7.0.0'
}
'''

The plugin also needs permission to write to external storage, so in the app's AndroidManifest.xml, make sure to add the line below.

'''
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
...
'''
