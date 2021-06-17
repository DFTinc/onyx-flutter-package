//
//  ONXFingerGuideView.h
//  IDFingerScanApp
//
//  Created by zaknixon on 6/29/13.
//  Copyright (c) 2013 Diamond Fortress Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureNetOutputs.h"
#import "OnyxConfiguration.h"
#import "OnyxEnums.h"

/**
 Class that represents a guide view used to help 
 user's properly position their finger in the camera's view.
 */
@interface FingerGuideView : UIView {
    UILabel *captureLabel;
    UILabel *tooFarLabel;
    UILabel *tooCloseLabel;
}

@property (nonatomic) CGRect frame;
@property (assign) BOOL isAnimating;

/** 
 Color of the guide geometry.
 */
@property (nonatomic,strong) UIColor *color;
@property CaptureDepth captureDepth;
@property float height;
@property float offset;

/*!
 *@brief The FingerGuideView's OnyxConfiguration
 */
@property OnyxConfiguration *onyxConfig;

@end
