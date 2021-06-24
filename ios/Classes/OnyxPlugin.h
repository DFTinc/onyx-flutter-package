 #import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>
#import <OnyxCamera/Onyx.h>
#import <OnyxCamera/OnyxConfigurationBuilder.h>
#import <OnyxCamera/OnyxConfiguration.h>
#import <OnyxCamera/CaptureNetController.h>
#import <OnyxCamera/OnyxViewController.h>
#import <OnyxCamera/OnyxEnums.h>

@interface OnyxPlugin : NSObject<FlutterPlugin>

//@property FlutterMethodChannel* channel;
@property OnyxResult* onyxResult;
@property  Onyx* onyx;
-(void(^)(OnyxResult* onyxResult))onyxSuccessCallback;

-(void(^)(OnyxError* onyxError)) onyxErrorCallback;

-(void(^)(Onyx* configuredOnyx))onyxCallback;

@end
