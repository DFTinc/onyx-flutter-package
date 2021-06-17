//
//  CaptureNetOutputs.h
//  OnyxCamera
//
//  Created by Will Lucas on 8/11/19.
//  Copyright © 2019 Diamond Fortress. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const int BATCH_SIZE;
extern const int IMAGE_WIDTH;
extern const int IMAGE_HEIGHT;
extern const int IMAGE_DEPTH;
extern const int OUTPUT_DEPTH;

NS_ASSUME_NONNULL_BEGIN

@interface CaptureNetOutputs : NSObject

@property NSData *maskData;
@property NSData *markerData;

- (instancetype)initWithOutputs:(NSData *)mask marker:(NSData *)marker;

@end

NS_ASSUME_NONNULL_END
