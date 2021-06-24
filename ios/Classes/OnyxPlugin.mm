#import "OnyxPlugin.h"
#import "OnyxCameraPluginViewController.h"


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
    //  OnyxCameraPluginViewController *onyxCameraPluginViewController= [[OnyxCameraPluginViewController alloc] init];
     OnyxConfigurationBuilder* onyxConfigBuilder = [[OnyxConfigurationBuilder alloc] init];
     onyxConfigBuilder.setViewController(parentViewController)
       .setLicenseKey(call.arguments[@"licenseKey"])
      .setReturnRawImage([call.arguments[@"isReturnRawImage"] boolValue])
        .setReturnProcessedImage([call.arguments[@"isProcessedImageReturned"] boolValue])
        .setReturnWSQ([call.arguments[@"isWSQImageReturned"] boolValue])
        .setReturnFingerprintTemplate([call.arguments[@"isFingerprintTemplateImageReturned"] boolValue])
        .setReturnISOFingerprintTemplate([call.arguments[@"isConvertToISOTemplate"] boolValue])
      .setUseOnyxLive([call.arguments[@"isOnyxLive"] boolValue])
        .setReticleOrientation((ReticleOrientation)0)
        .setShowLoadingSpinner([call.arguments[@"isLoadingSpinnerShown"] boolValue])
      
        .setSuccessCallback([self onyxSuccessCallback])
        .setErrorCallback([self onyxErrorCallback])
        .setOnyxCallback([self onyxCallback]);

         /*
     * Legacy params
     *
     * NOTE: subject of change
     */
onyxConfigBuilder
    //.setReturnGrayRawImage(_returnGrayRawImage.on)
    .setReturnEnhancedImage([call.arguments[@"isEnhancedImageReturned"] boolValue])
      
    //.setReturnBlackWhiteProcessedImage(_returnBlackWhiteProcessedImage.on)
    //.setReturnGrayRawWSQ(_returnGrayRawWsq.on)
    .setUseFlash(YES)
    .setUseManualCapture([call.arguments[@"isManualCapture"] boolValue])
    //.setShowManualCaptureText(_showManualCaptureText.on)
      .setImageRotation((ImageRotation)[call.arguments[@"imageRotation"] intValue]);
    //.setFingerDetectMode((FingerDetectMode)_fingerDetectMode.selectedSegmentIndex)
    
//    if (![_backgroundColorHexString.text isEqualToString:@""]) {
//        onyxConfigBuilder.setBackgroundColorHexString([NSString stringWithFormat:@"#%@", _backgroundColorHexString.text]);
//    }
//
//    if (![_backButtonText.text isEqualToString:@""]) {
//        onyxConfigBuilder.setBackButtonText(_backButtonText.text);
//    }
//
//    if (![_manualCaptureText.text isEqualToString:@""]) {
//        onyxConfigBuilder.setManualCaptureText(_manualCaptureText.text);
//    }
//
//    if (![_infoText.text isEqualToString:@""]) {
//        onyxConfigBuilder.setInfoText(_infoText.text);
//    }
//
//    if (![_infoTextColorHexString.text isEqualToString:@""]) {
//        onyxConfigBuilder.setInfoTextColorHexString([NSString stringWithFormat:@"#%@", _infoTextColorHexString.text]);
//    }
//
//    if (![_base64ImageData.text isEqualToString:@""]) {
//        onyxConfigBuilder.setBase64ImageData(_base64ImageData.text);
//    }
//
//    if (![_LEDBrightness.text isEqualToString:@""]) {
//        onyxConfigBuilder.setLEDBrightness([_LEDBrightness.text floatValue]);
//    }
//
//    // Crop Factor
    if (![call.arguments[@"cropFactor"] isEqualToString:@""]) {
        onyxConfigBuilder.setCropFactor([call.arguments[@"cropFactor"] floatValue]);
    }
//
//    // Crop Size
//    float width = 600;
//    float height = 960;
//    float floatValue = 0;
    if (![call.arguments[@"cropSizeHeight"] isEqualToString:@""] && ![call.arguments[@"cropSizeWidth"] isEqualToString:@""]) {
        onyxConfigBuilder.setCropSize(CGSizeMake([call.arguments[@"cropSizeWidth"] floatValue], [call.arguments[@"cropSizeHeight"] floatValue]));
    }
//        floatValue = [_cropSizeWidth.text floatValue];
//        if (floatValue != 0) {
//            width = floatValue;
//        }
//    }
//    if (![_cropSizeHeight.text isEqualToString:@""]) {
//        floatValue = [_cropSizeHeight.text floatValue];
//        if (floatValue != 0) {
//            height = floatValue;
//        }
//    }
//
//    onyxConfigBuilder.setCropSize(CGSizeMake(width, height));

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
         //   [parentViewController performSegueWithIdentifier:@"segueToOnyxResult" sender:configuredOnyx];
          //  [configuredOnyx capture:parentViewController];
          //  OnyxCameraPluginViewController *onyxCameraPluginViewController= [[OnyxCameraPluginViewController alloc] init];
         //   onyxCameraPluginViewController.configuredOnyx=configuredOnyx;
           // [parentViewController showViewController:onyxCameraPluginViewController sender:configuredOnyx];
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
