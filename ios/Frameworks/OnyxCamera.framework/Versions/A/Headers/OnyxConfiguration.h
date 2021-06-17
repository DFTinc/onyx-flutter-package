//
//  OnyxConfiguration.h
//  OnyxCamera
//
//  Created by Matthew Wheatley on 2/3/18.
//  Copyright © 2018 Diamond Fortress. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OnyxEnums.h"
#import "OnyxResult.h"
#import "OnyxError.h"

@class Onyx;

@interface OnyxConfiguration : NSObject {
    
}

/**
 * This method sets the ViewController
 */
@property UIViewController *viewController;

/**
 * This method sets the Onyx license key.
 */
@property NSString *licenseKey;

/**
 * This property sets the background color.
 */
@property NSString *backgroundColorHexString;

/**
 * This property sets whether or not to return the raw fingerprint image in the OnyxResult.
 */
@property bool returnRawFingerprintImage;

/**
 * This property sets whether or not to return the gray-scale raw fingerprint image in the OnyxResult.
 */
@property bool returnGrayRawFingerprintImage;

/**
 * This property sets whether or not to return the processed fingerprint image in the OnyxResult.
 */
@property bool returnProcessedFingerprintImage;

/**
 * This property sets whether or not to return the enhanced fingerprint image in the OnyxResult.
 */
@property bool returnEnhancedFingerprintImage;

/**
 * This property sets whether or not to return the black and white processed fingerprint image in the OnyxResult.
 */
@property bool returnBlackWhiteProcessedFingerprintImage;

/**
 * This property sets whether or not to return the fingerprint template in the OnyxResult.
 */
@property bool returnFingerprintTemplate;

/**
 * This property sets whether or not to return the WSQ image in the OnyxResult.
 */
@property bool returnWsq;

/**
 * This property sets whether or not to return the gray-scale WSQ fingerprint image in the OnyxResult.
 */
@property bool returnGrayRawWsq;

/**
 * This method sets whether or not the capture task should segment the fingerprint image.
 */
@property bool shouldSegment;

/**
 * This property sets whether or not to return the ISO fingerprint template in the OnyxResult
 */
@property bool returnISOFingerprintTemplate;

/**
 * This method sets the rotation amount for the image.
 * rotation an integer specifying the rotation amount (0, 90, 180, or 270 degrees).
 * only 90 degree rotations are supported for speed reasons.
 */
@property int rotation;

/**
 * This method sets the crop to the whole finger.
 * wholeFingerCrop a Bool specifying to crop the whole finger.
 */
@property bool wholeFingerCrop;

/**
 * This method sets the crop size for the capture image.
 */
@property CGSize cropSize;

/**
 * This method sets the crop factor for the capture image.
 */
@property float cropFactor;

/**
 * This methods sets that the Onyx spinner should be shown.
 */
@property bool showSpinner;

/**
 * This method sets the layout preference for the OnyxFragment
 */
@property LayoutPreference layoutPreference;

/**
 * This method sets the method of capture to be a manual capture of the fingerprint
 */
@property bool useManualCapture;

/**
 * This method indicates which finger detect mode to use.
 */
@property FingerDetectMode fingerDetectMode;

/**
 * This property determines if the manual capture text will be displayed or not
 */
@property bool showManualCaptureText;

/**
 * Instructions to display for manual capture (localization)
 */
@property NSString* manualCaptureText;

/**
 * This method sets whether to use remote storage as part of the configuration
 */
@property bool useRemoteStorage;

/**
 * This method sets whether to use remote storage as part of the configuration
 */
@property bool useLiveness;

/**
 * This method sets whether to use the flash
 */
@property bool useFlash;

/**
 * This method sets the flash brightness level
 */
@property float LEDBrightness;

/**
 * This method sets the orientation of the reticle {@link Reticle.Orientation}
 */
@property ReticleOrientation reticleOrientation;

/**
 * This method sets the angle of the reticle
 * angle the degree angle to rotate the reticle
 * positive values rotate clockwise
 */
@property float reticleAngle;

/**
 * This method sets the scale of the reticle
 */
@property float reticleScale;

/**
 * Overrides the reticle orientation to use the angle passed in to reticleAngle
 */
@property bool overrideReticleOrientation;

/**
 * Text to display for the back button (localization)
 */
@property NSString* backButtonText;

/**
 * Custom text to display on capture screen
 */
@property NSString* infoText;

/**
 * Text color for custom information as a hex string value
 */
@property NSString* infoTextColorHexString;

/**
 * Image URI to display
 */
@property NSString* base64ImageData;

/**
 * This sets the OnyxSuccess event handler.
 * successCallback (required) the event handler for the SuccessCallback.
 */
@property void(^successCallback)(OnyxResult* onyxResult);

/**
 * This sets the ErrorCallback event handler.
 * errorCallback (required) the event handler for the ErrorCallback.
 */
@property void(^errorCallback)(OnyxError* onyxError);

/**
 * This sets the OnyxCallback event handler.
 * The callback returns the Onyx object used to start Onyx.
 */
@property void(^onyxCallback)(Onyx* onyx);

/**
 * Returns instance of OnyxConfiguration. If no instance is found it creates one.
 */
//+(OnyxConfiguration*)sharedInstance;

@end
