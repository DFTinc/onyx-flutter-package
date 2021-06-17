//
//  OnyxViewController.h
//  OnyxCamera
//
//  Created by Devan Buggay on 6/16/14.
//  Copyright (c) 2014 dft. All rights reserved.
//
#ifdef __cplusplus
#import <opencv2/imgcodecs/ios.h>
#endif

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "OnyxConfiguration.h"
#import "CaptureNetController.h"

#define fingerStepSize 15
#define fingerStepPadding 10
#define QUALITY_THRESHOLD 6
#define FINGER_DETECTION true

@class ProcessedFingerprint;
@class FingerGuideView;
@class StepIndicatorView;

/*!
 @class OnyxViewController
 @abstract View controller housing the Onyx camera tech
 */
@interface OnyxViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate, UIGestureRecognizerDelegate> {
    // AVFoundation
    AVCaptureDevice *inputDevice;
    AVCaptureSession *captureSession;
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
    AVCaptureStillImageOutput *stillImageOutput;
    AVCaptureVideoDataOutput *captureOutput;
    dispatch_queue_t captureQueue;
    dispatch_queue_t captureNetQueue;
    NSMutableArray *processedFingerprints;
    NSMutableArray *prints;
    CGRect camFrame;
    NSInteger stableFrames;
    NSInteger neededStableFrames;
    NSInteger stage;
    NSInteger failures;
    BOOL complete;
    BOOL matched;
    BOOL capturePreview;
    bool cameraBool;
    NSArray *steps;
    NSMutableArray *stepIndicatorViews;
    FingerGuideView *fingerGuideView;
    UIImageView *logoImageView;
    UIView *fingertipView;
    UIView *imagePreview;
    UIImage *fingerImage;
    UIImage *gifImage;
    UIImage *brandImage;
    UIImage *leftInfo;
    UIImage *rightInfo;
    UIImageView *infoView;
    UIImageView *sidebarView;
    UIPageViewController *pageViewController;
    NSArray *pageTitles;
    NSArray *pageImages;
    UIView *flashBackground;
    UIView *flash;
    UIActivityIndicatorView *activityIndicatorView;
}

/*!
 * @brief Holds the medianWidthEMA of a finger
 */
@property double medianWidthEMA;

/*!
 * @brief The OnyxViewController's delegate
 */
@property (strong, nonatomic) id delegate;

/*!
 *@brief The OnyxViewController's configuration
 */
@property OnyxConfiguration *onyxConfig;

/*!
 * @brief The onyx-core's version number
 */
@property (readonly) NSString *onyxcoreversion;

/*!
 * @brief Option to show match score at end of enrollment [default: false]
 */
@property bool showMatchScore;

/*!
 * @brief Option to change LED brightness for camera
 */
//@property float LEDBrightness; // (0.0, 1.0]

/*!
 * @brief Option 
 */
@property bool useAutoFocus;

@property NSArray *scaleFactors;

@property UILabel *infoLabel1;
@property UILabel *infoLabel2;

/*!
 * @brief Text for a custom label in the info view.
 */
@property NSString *infoText;

/*!
 * @brief Boolean for showing debug info on screen
 */
@property bool showDebug;

@property float focusMeasurementRequirement;

@property int frameCount;

@property bool isProcessingManualCapture;

/*!
 * Set capturePreview to true
 * @author Devan Buggay
 *
 * @return void
 */
- (void)capture;

/*!
 * Set up AVFoundation if inputDevice exists
 * @author Devan Buggay
 *
 * @return void
 */
- (void)setupAVFoundation;

/*!
 * Capture a still image from input device
 * @author Devan Buggay
 *
 * @return void
 */
- (void)captureStill;
/*!
 * Reset the focus and exposure of the camera. If iOS 8+, lock focus.
 * @author Devan Buggay
 *
 * @return void
 */
- (void)resetFocusAndExposure;
/*!
 * Start the process indicator
 * @author Devan Buggay
 *
 * @return void
 */
- (void)startProcessIndicator;
/*!
 * Stop the process indicator
 * @author Devan Buggay
 *
 * @return void
 */
- (void)stopProcessIndicator;

@end

#pragma mark - OnyxViewControllerDelegate
// OnyxViewController Delegate methods
@protocol OnyxViewControllerDelegate
- (void) Onyx:(OnyxViewController *)controller didOutputProcessedFingerprint:(NSMutableArray *)processedFingerprints;
/*!
 * @return NSError
 */
- (void) Onyx:(OnyxViewController *)controller errorCallback:(NSError* )error;
- (void) Onyx:(OnyxViewController *)controller onCancel:(NSError*)error;
@end
