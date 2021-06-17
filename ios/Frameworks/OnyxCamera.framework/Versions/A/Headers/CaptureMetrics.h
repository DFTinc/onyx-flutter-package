//
//  CaptureMetrics.h
//  OnyxCamera
//
//  Created by Matthew Wheatley on 5/6/18.
//  Copyright © 2018 Diamond Fortress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NfiqMetrics.h"

@interface CaptureMetrics : NSObject
@property float livenessConfidence;
@property NSMutableArray* nfiqMetrics;
@property float focusQuality;
@property float distanceToCenter;

- (float) getLivenessConfidence;
- (float) getFocusQuality;
- (float) getDistanceToCenter;
- (NSMutableArray *) getNfiqMetrics;

@end
