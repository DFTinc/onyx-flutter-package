//
//  OnyxResult.h
//  OnyxCamera
//
//  Created by Matthew Wheatley on 2/3/18.
//  Copyright © 2018 Diamond Fortress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CaptureMetrics.h"

@interface OnyxResult : NSObject
@property NSMutableArray* rawFingerprintImages;
@property NSMutableArray* processedFingerprintImages;
@property NSMutableArray* enhancedFingerprintImages;
@property NSMutableArray* blackWhiteProcessedFingerprintImages;
@property NSMutableArray* wsqData;
@property NSMutableArray* fingerprintTemplates;
@property NSMutableArray* ISOFingerprintTemplates;
@property CaptureMetrics* captureMetrics;

- (NSMutableArray*) getRawFingerprintImages;

- (NSMutableArray*) getProcessedFingerprintImages;

- (NSMutableArray*) getEnhancedFingerprintImages;

- (NSMutableArray*) getBlackWhiteProcessedFingerprintImages;

- (NSMutableArray*) getWsqData;

- (NSMutableArray*) getFingerprintTemplates;

- (NSMutableArray*) getISOFingerprintTemplates;

- (CaptureMetrics*) getMetrics;

- (NSMutableArray*) getFingerprintImageUris:(NSMutableArray*)images;
- (NSMutableArray*) getBase64EncodedStrings:(NSMutableArray*)data;

@end
