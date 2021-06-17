//
//  OnyxEnums.h
//  OnyxCamera
//
//  Created by Matthew Wheatley on 2/4/18.
//  Copyright © 2018 Diamond Fortress. All rights reserved.
//


/*!
 * @typedef onyxFingers
 * @brief List of fingers. 1 - Thumb, 2 - Pointer, 5 - Pinky
 */
typedef enum onyxFingers {
    left_1,
    left_2,
    left_3,
    left_4,
    left_5,
    right_1,
    right_2,
    right_3,
    right_4,
    right_5
} OnyxFinger;

typedef enum Error {
    /**
     * This error occurs when the camera fails to auto-focus.
     */
    AUTOFOCUS_FAILURE,
    
    /**
     * This error occurs whenever the camera sub-system fails.
     */
    CAMERA_FAILURE,
    
    /**
     * This error occurs when the license validation fails.
     */
    LICENSING_FAILURE,
    
    /**
     * This error occurs when permissions have not been granted.
     */
    PERMISSIONS_FAILURE,
    
    /**
     * This error occurs when there is an error encountered during capture.
     */
    FINGERPRINT_CAPTURE_FAILURE,
    
    /**
     * This error occurs when there is a successful capture, but the resulting image is
     * of too low quality (NFIQ Score = 5)
     */
    FINGERPRINT_TOO_LOW_QUALITY,
    /**
     * This error occurs if there is an error communicating with the liveness detection
     * server.  Check if there is an internet connection, and if not, advise client to
     * connect to the internet, or to try a different internet connection.
     */
    LIVENESS_FAILURE
} Error;

typedef enum LayoutPreference {
    UPPER_THIRD,
    FULL
} LayoutPreference;

typedef enum ReticleOrientation {
    LEFT,
    RIGHT,
    THUMB_PORTRAIT
} ReticleOrientation;

typedef enum ImageRotation {
    ROTATE_NONE = 0,
    ROTATE_90_COUNTER_CLOCKWISE = 90,
    ROTATE_180 = 180,
    ROTATE_90_CLOCKWISE = 270 // 270
} ImageRotation;

typedef enum FingerDetectMode {
    DEAD_FINGER,
    LIVE_FINGER
} FingerDetectMode;

typedef enum CaptureDepth : NSUInteger {
    BACKGROUND,
    CAPTURE,
    TOO_CLOSE,
    TOO_FAR
} CaptureDepth;