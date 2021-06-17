//
//  OnyxError.h
//  OnyxCamera
//
//  Created by Matthew Wheatley on 2/3/18.
//  Copyright © 2018 Diamond Fortress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnyxEnums.h"

@interface OnyxError : NSObject

/*!
 * @brief The enumeration specifying the type of error that occurred.
 */
@property Error error;
/*!
 * @brief A string containing details about the error.
 */
@property NSString* errorMessage;
/**
 * The NSError that was caught (it can be null).
 */
@property NSError* exception;

@end
