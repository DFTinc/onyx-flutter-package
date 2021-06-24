#import "OnyxPlugin.h"



@implementation OnyxPlugin

 static FlutterMethodChannel* channel;


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
 channel = [FlutterMethodChannel
      methodChannelWithName:@"com.dft.onyx_plugin/methodChannel"
            binaryMessenger:[registrar messenger]];
    OnyxPlugin* instance = [[OnyxPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result { 
  if ([@"startOnyx" isEqualToString:call.method]) {
    //  [self startOnyx];
  //  result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } 
  else  if ([@"configureOnyx" isEqualToString:call.method]) {
      UIViewController *parentViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;

      while (parentViewController.presentedViewController != nil){
          parentViewController = parentViewController.presentedViewController;
      }
      
     OnyxConfigurationBuilder* onyxConfigBuilder = [[OnyxConfigurationBuilder alloc] init];
     onyxConfigBuilder.setViewController(parentViewController)
       .setLicenseKey(call.arguments[@"licenseKey"])
      .setReturnRawImage([call.arguments[@"isReturnRawImage"] boolValue])
        .setReturnProcessedImage([call.arguments[@"isProcessedImageReturned"] boolValue])
        .setReturnWSQ([call.arguments[@"isWSQImageReturned"] boolValue])
        .setReturnFingerprintTemplate([call.arguments[@"isWSQImageReturned"] boolValue])
        .setReturnISOFingerprintTemplate([call.arguments[@"isFingerprintTemplateImageReturned"] boolValue])
      .setUseOnyxLive([call.arguments[@"isOnyxLive"] boolValue])
      //  .setReticleOrientation(ReticleOrientation.Left)
        .setShowLoadingSpinner(YES)
      
        .setSuccessCallback([self onyxSuccessCallback])
        .setErrorCallback([self onyxErrorCallback])
        .setOnyxCallback([self onyxCallback]);
         [onyxConfigBuilder buildOnyxConfiguration];

  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

#pragma mark - Onyx Callbacks

-(void(^)(Onyx* configuredOnyx))onyxCallback {
    return ^(Onyx* configuredOnyx) {
        NSLog(@"Onyx Callback");
        self.onyx= configuredOnyx;
        dispatch_async(dispatch_get_main_queue(), ^{
            [channel invokeMethod:@"onyx_configured"
                             arguments:nil
            ];
            UIViewController *parentViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;

            while (parentViewController.presentedViewController != nil){
                parentViewController = parentViewController.presentedViewController;
            }
            [configuredOnyx capture:parentViewController];
        });

    };
}

-(void(^)(OnyxResult* onyxResult))onyxSuccessCallback {
    return ^(OnyxResult* onyxResult) {
        NSLog(@"Onyx Success Callback");

        self->_onyxResult = onyxResult;
      //  [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
     //       [self performSegueWithIdentifier:@"segueToOnyxResult" sender:onyxResult];
      //  }];
    };
}

-(void(^)(OnyxError* onyxError)) onyxErrorCallback {
    return ^(OnyxError* onyxError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
                NSLog(@"Onyx Error Callback");
                [channel invokeMethod:@"onyx_error"
                                 arguments:@{
                                     @"errorMessage" :  onyxError.errorMessage//,
                                     //@"args" : [NSString stringWithFormat:@"Hello Listener! %d", time]
                                 }
                ];
          //  channel.invokeMethod(
            //            [self stopSpinnner];
          //  UIAlertController *alertController = [UIAlertController
                                   //       alertControllerWithTitle:@"ONYX Error"
                                  //        message:[NSString stringWithFormat:@"ErrorCode: %d, ErrorMessage:%@, Error:%@", onyxError.error, onyxError.errorMessage, onyxError.exception]
                                   //       preferredStyle:UIAlertControllerStyleAlert];//

           // UIAlertAction *okAction = [UIAlertAction
            //            actionWithTitle:@"OK"
              //                    style:UIAlertActionStyleDefault
             //                   handler:nil];

         //   [alertController addAction:okAction];

         //   [self presentViewController:alertController animated:YES completion:nil];
        });
            
    };
}

@end
