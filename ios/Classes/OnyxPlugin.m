#import "OnyxPlugin.h"





@implementation OnyxPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"com.dft.onyx_plugin/methodChannel"
            binaryMessenger:[registrar messenger]];
    OnyxPlugin* instance = [[OnyxPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result { 
  if ([@"startOnyx" isEqualToString:call.method]) {
      [self startOnyx];
  //  result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } 
  else  if ([@"configureOnyx" isEqualToString:call.method]) {
     OnyxConfigurationBuilder* onyxConfigBuilder = [[OnyxConfigurationBuilder alloc] init];
     onyxConfigBuilder//.setViewController(self)
       .setLicenseKey([call.arguments[@"licenseKey"] stringValue])
      .setReturnRawImage([call.arguments[@"isReturnRawImage"] boolValue])
        .setReturnProcessedImage([call.arguments[@"isProcessedImageReturned"] boolValue])
        .setReturnWSQ([call.arguments[@"isWSQImageReturned"] boolValue])
        .setReturnFingerprintTemplate([call.arguments[@"isWSQImageReturned"] boolValue])
        .setReturnISOFingerprintTemplate([call.arguments[@"isFingerprintTemplateImageReturned"] boolValue])
      .setUseOnyxLive([call.arguments[@"isOnyxLive"] boolValue]);
      //  .setReticleOrientation((ReticleOrientation)_reticleOrientation.selectedSegmentIndex)
       // .setShowLoadingSpinner(YES)
        //.setSuccessCallback([self onyxSuccessCallback])
        //.setErrorCallback([self onyxErrorCallback])
      //  .setOnyxCallback([self onyxCallback]);
      [onyxConfigBuilder buildOnyxConfiguration];
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

- (void) startOnyx{

}

@end
