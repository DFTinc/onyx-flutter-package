//
//  NfiqMetrics.h
//  OnyxCamera
//
//  Created by Matthew Wheatley on 5/6/18.
//  Copyright © 2018 Diamond Fortress. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NfiqMetrics : NSObject
@property int nfiqScore;
@property float mlpScore;

- (int) getNfiqScore;
- (float) getMlpScore;
@end
