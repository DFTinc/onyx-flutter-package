//
//  CaptureNetController.h
//  OnyxCamera
//
//  Created by Will Lucas on 8/11/19.
//  Copyright © 2019 Diamond Fortress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFLTensorFlowLite.h"

#import "CaptureNetOutputs.h"

NS_ASSUME_NONNULL_BEGIN

@interface CaptureNetController : NSObject

- (instancetype)init;

- (CaptureNetOutputs *)runInference:(NSData *)imageData error:(NSError**) error;

@end

NS_ASSUME_NONNULL_END
