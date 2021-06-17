//
//  OnyxConfigurationBuilder.h
//  OnyxCamera
//
//  Created by Matthew Wheatley on 2/3/18.
//  Copyright © 2018 Diamond Fortress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OnyxConfiguration.h"
#import "Onyx.h"

@interface OnyxConfigurationBuilder : NSObject {
    
}

@property OnyxConfiguration* onyxConfig;

/**
 * This sets the view controller from which to launch Onyx (required)
 */
-(OnyxConfigurationBuilder*(^)(UIViewController*))setViewController;

/**
 * This sets the Onyx license key (required)
 */
-(OnyxConfigurationBuilder*(^)(NSString*))setLicenseKey;

/**
 * This sets the background color of the area below the capture area
 */
-(OnyxConfigurationBuilder*(^)(NSString*))setBackgroundColorHexString;

/**
 * This method sets whether or not to return imagery for the raw fingerprint image in the OnyxResult.
 */
-(OnyxConfigurationBuilder*(^)(bool))setReturnRawImage;

/**
 * This method sets whether or not to return imagery for the gray-scale raw fingerprint image in the OnyxResult.
 */
-(OnyxConfigurationBuilder*(^)(bool))setReturnGrayRawImage;

/**
 * This method sets whether or not to return imagery for the processed fingerprint image in the OnyxResult.
 */
-(OnyxConfigurationBuilder*(^)(bool))setReturnProcessedImage;

/**
 * This method sets whether or not to return imagery for the enhanced fingerprint image in the OnyxResult.
 */
-(OnyxConfigurationBuilder*(^)(bool))setReturnEnhancedImage;

/**
 * This method sets whether or not to return imagery for the black and white processed fingerprint image in the OnyxResult.
 */
-(OnyxConfigurationBuilder*(^)(bool))setReturnBlackWhiteProcessedImage;

/**
 * This method sets whether or not to return Onyx fingerprint template in the OnyxResult.
 */
-(OnyxConfigurationBuilder*(^)(bool))setReturnFingerprintTemplate;

/**
 * This method sets whether or not to return the WSQ image in the OnyxResult.
 */
-(OnyxConfigurationBuilder*(^)(bool))setReturnWSQ;

/**
 * This method sets whether or not to return a gray-scale raw WSQ image in the OnyxResult.
 */
-(OnyxConfigurationBuilder*(^)(bool))setReturnGrayRawWSQ;

/**
 * This method sets whether or not the capture task should segment the fingerprint image.
 */
//todo
-(OnyxConfigurationBuilder*(^)(bool))setShouldSegment;

/**
 * This method sets whether or not to return ISO figneprint tempalte in the OnyxResult.
 */
-(OnyxConfigurationBuilder*(^)(bool))setReturnISOFingerprintTemplate;

/**
 * This method sets the rotation amount for the image.
 * only 90 degree rotations are supported for speed reasons.
 */
-(OnyxConfigurationBuilder*(^)(int))setImageRotation;

/**
 * This method sets whether or not to set the crop to the whole finger.
 */
//todo
-(OnyxConfigurationBuilder*(^)(bool))setWholeFingerCrop;

/**
 * This method sets the crop size for the capture image.
 */
-(OnyxConfigurationBuilder*(^)(CGSize))setCropSize;

/**
 * This method sets the crop factor for the capture image.
 */
-(OnyxConfigurationBuilder*(^)(float))setCropFactor;

/**
 * This method sets whether or not to show the spinner while waiting for Onyx setup
 */
-(OnyxConfigurationBuilder*(^)(bool))setShowLoadingSpinner;

/**
 * This method sets whether or not to use Onyx LIVE liveness detection
 */
-(OnyxConfigurationBuilder*(^)(bool))setUseOnyxLive;

/**
 * This method sets the flash mode on (true) or off (false)
 */
-(OnyxConfigurationBuilder*(^)(bool))setUseFlash;

/**
 * THis method set the LED Brightness
 */
-(OnyxConfigurationBuilder*(^)(float))setLEDBrightness;

/**
 * This method sets the capture mode on (true) or off (false)
 */
-(OnyxConfigurationBuilder*(^)(bool))setUseManualCapture;

/**
 * This method sets whether or not to show the manual capture text
 */
-(OnyxConfigurationBuilder*(^)(bool))setShowManualCaptureText;

/**
 * This method sets the text to display for manual capture (localization)
 */
-(OnyxConfigurationBuilder*(^)(NSString*))setManualCaptureText;

/**
 * This method sets the {@link com.dft.onyxcamera.ui.reticles.Reticle.Orientation}
 */
-(OnyxConfigurationBuilder*(^)(ReticleOrientation))setReticleOrientation;

/**
 * This method sets the angle of the reticle
 * positive values rotate clockwise
 */
//todo
-(OnyxConfigurationBuilder*(^)(float))setReticleAngle;

/**
 * This method sets the scale of the reticle
 */
//todo
-(OnyxConfigurationBuilder*(^)(float))setReticleScale;

/**
 * This method sets the text to use for the back button (localization)
 */
-(OnyxConfigurationBuilder*(^)(NSString*))setBackButtonText;

/**
 * This method sets the customer information text to be displayed on the capture screen.
 */
-(OnyxConfigurationBuilder*(^)(NSString*))setInfoText;

/**
 * This method sets the text color to use for the custom information
 */
-(OnyxConfigurationBuilder*(^)(NSString*))setInfoTextColorHexString;

/**
 * This method sets the image data to be displayed on the capture screen
 */
-(OnyxConfigurationBuilder*(^)(NSString*))setBase64ImageData;

/**
 * This method sets the finger detect mode.
 */
-(OnyxConfigurationBuilder*(^)(FingerDetectMode))setFingerDetectMode;

/**
 * This sets the OnyxSuccess event handler.
 */
-(OnyxConfigurationBuilder*(^)(void(^)(OnyxResult*)))setSuccessCallback;

/**
 * This sets the ErrorCallback event handler.
 */
-(OnyxConfigurationBuilder*(^)(void(^)(OnyxError*)))setErrorCallback;

/**
 * This sets the OnyxCallback event handler.
 * The callback returns the Onyx object used to start Onyx.
 */
-(OnyxConfigurationBuilder*(^)(void(^)(Onyx*)))setOnyxCallback;

/**
 * This method builds the OnyxConfiguration object with the specified parameters, and
 * checks that all configuration setup is complete before returning the Onyx object
 */
-(void)buildOnyxConfiguration;

@end
