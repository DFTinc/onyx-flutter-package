//
//  Onyx.h
//  OnyxDemo
//
//  Created by Devan Buggay on 6/11/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface OnyxMatch : NSObject

/*!
 * This function will attempt to match two templates and return a score.
 * @author Devan Buggay
 *
 * @param d1 first template data
 * @param d2 second template data
 * @return a match score [0, 1] 0.1 is acceptable. 
 */
+ (double) match:(NSData *)d1 with:(NSData *)d2;

/*!
 * This function will attempt to match a WSQ Image to a fingerprint template by scaling the WSQ Image
 * @author Matthew Wheatley
 *
 * @param referenceData template data of the reference fingerprint
 * @param wsqData data for the WSQ Image to match against the reference template
 * @param scales aray of float values to scale the WSQ image
 * @return a match score [0, 1] 0.1 is acceptable.
 */
+ (double) pyramidMatch:(NSData *)referenceData withImage:(UIImage *)probeImage scales:(NSArray *) scaleArray;

/*!
 * Get FingerprintTemplate from NSData
 * @author Devan Buggay
 *
 * @param d NSData of template
 * @return a pointer to a FingerprintTemplate.
 */
//+ (FingerprintTemplate) fingerprintTemplateForData:(NSData *) d;

/*!
 * This NSData from FingerprintTemplate
 * @author Devan Buggay
 *
 * @param t a pointer to a FingerprintTemplate
 * @return a pointer to a NSData object
 */
//+ (NSData *) dataForFingerprintTemplate:(FingerprintTemplate) t;

/*!
 * Get onyx-core version
 * @author Devan Buggay
 *
 */
+ (NSString *) onyxcoreversion;

@end
