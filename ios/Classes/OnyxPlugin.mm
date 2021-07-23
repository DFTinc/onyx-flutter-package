#import "OnyxPlugin.h"
#import <Flutter/Flutter.h>

@implementation OnyxPlugin

static FlutterMethodChannel* channel; 
Onyx* _configuredOnyx;
static FlutterViewController * _flutterController;

#pragma mark - flutter controller Property
+(FlutterViewController *)flutterViewController{
    return _flutterController;
}
+(void) setFlutterViewController:(FlutterViewController *) newFlutterViewController{
    _flutterController=newFlutterViewController;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    channel = [FlutterMethodChannel
                methodChannelWithName:@"com.dft.onyx_plugin/methodChannel"
                binaryMessenger:[registrar messenger]];
    OnyxPlugin* instance = [[OnyxPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if([@"startOnyx" isEqualToString:call.method]){
        if(_configuredOnyx != nil){
            [_configuredOnyx capture:_flutterController];
        }
    }
    else if ([@"configureOnyx" isEqualToString:call.method]) {
      [[self configureOnyx: call] buildOnyxConfiguration];
      result(0);
  } else {
      result(FlutterMethodNotImplemented);
  }
}

#pragma mark - Onyx Callbacks

-(void(^)(Onyx* configuredOnyx))onyxCallback {
    return ^(Onyx* configuredOnyx) {
        NSLog(@"Onyx Callback");
        dispatch_async(dispatch_get_main_queue(), ^{
            _configuredOnyx= configuredOnyx;
            [channel invokeMethod:@"onyx_configured" arguments:nil];
        });
    };
}

-(void(^)(OnyxResult* onyxResult))onyxSuccessCallback {
    return ^(OnyxResult* onyxResult) {
        NSLog(@"Onyx Success Callback");
        NSMutableDictionary* flutterResults=  [self getOnyxResultFlutterParams:onyxResult];
        [_flutterController.navigationController popToRootViewControllerAnimated:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
                [channel invokeMethod:@"onyx_success" arguments:flutterResults];
        });         
        [_flutterController.navigationController popToRootViewControllerAnimated:YES];   
    };
}

/*
handles the onyx error callback.
*/
-(void(^)(OnyxError* onyxError)) onyxErrorCallback {
    return ^(OnyxError* onyxError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Onyx Error Callback");
            [channel invokeMethod:@"onyx_error"
                        arguments:@{@"errorMessage":  onyxError.errorMessage}
             ];
        });
    };
}


/*
 Configures onyx with the passed in parameters.
 */
-(OnyxConfigurationBuilder*) configureOnyx:(FlutterMethodCall*)call{
    OnyxConfigurationBuilder* onyxConfigBuilder = [[OnyxConfigurationBuilder alloc] init];
    onyxConfigBuilder.setViewController(_flutterController)
        .setLicenseKey(call.arguments[@"licenseKey"])
        .setReturnRawImage([call.arguments[@"isReturnRawImage"] boolValue])
        .setReturnProcessedImage([call.arguments[@"isProcessedImageReturned"] boolValue])
        .setReturnWSQ([call.arguments[@"isWSQImageReturned"] boolValue])
        .setReturnFingerprintTemplate([call.arguments[@"isFingerprintTemplateImageReturned"] boolValue])
        .setReturnISOFingerprintTemplate([call.arguments[@"isConvertToISOTemplate"] boolValue])
        .setUseOnyxLive([call.arguments[@"isOnyxLive"] boolValue])
        .setShowLoadingSpinner([call.arguments[@"isLoadingSpinnerShown"] boolValue])
        .setUseFlash(YES)
        .setReturnEnhancedImage([call.arguments[@"isEnhancedImageReturned"] boolValue])
        .setUseManualCapture([call.arguments[@"isManualCapture"] boolValue])
        .setImageRotation((ImageRotation)[call.arguments[@"imageRotation"] intValue])
        .setReturnGrayRawImage([call.arguments[@"isGrayImageReturned"] boolValue])
        .setReturnBlackWhiteProcessedImage([call.arguments[@"isBlackWhiteProcessedImageReturned"] boolValue])
        .setReturnGrayRawWSQ([call.arguments[@"isGrayRawWSQReturned"] boolValue])
        .setBackButtonText(call.arguments[@"backButtonText"])
        .setBase64ImageData(call.arguments[@"base64ImageData"])
        .setSuccessCallback([self onyxSuccessCallback])
        .setErrorCallback([self onyxErrorCallback])
        .setOnyxCallback([self onyxCallback]);

    ReticleOrientation reticleOrientation=LEFT;// ReticleOrientation. 0;
    if([@"RIGHT" isEqualToString:call.arguments[@"reticleOrientation"]]){
        reticleOrientation=RIGHT;
    }
    if([@"THUMB_PORTRAIT" isEqualToString:call.arguments[@"reticleOrientation"]]){
        reticleOrientation=THUMB_PORTRAIT;
    }
    onyxConfigBuilder.setReticleOrientation(reticleOrientation);
    if (![call.arguments[@"reticleAngle"] isEqualToString:@""]) {
        onyxConfigBuilder.setReticleAngle([call.arguments[@"reticleAngle"] floatValue]);
    }
    // Crop Factor
    if (![call.arguments[@"cropFactor"] isEqualToString:@""]) {
        onyxConfigBuilder.setCropFactor([call.arguments[@"cropFactor"] floatValue]);
    }
    // Crop Size
    if (![call.arguments[@"cropSizeHeight"] isEqualToString:@""] && ![call.arguments[@"cropSizeWidth"] isEqualToString:@""]) {
        onyxConfigBuilder.setCropSize(CGSizeMake([call.arguments[@"cropSizeWidth"] floatValue], [call.arguments[@"cropSizeHeight"] floatValue]));
    }
    return onyxConfigBuilder;
}

///Gets the onyx results as a dictionary of params to pass to flutter.
-(NSMutableDictionary*) getOnyxResultFlutterParams:(OnyxResult*) onyxResult{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:8];
    //add images
    [dict setObject:[NSMutableArray arrayWithArray:[self getImageByteArrays: [onyxResult getRawFingerprintImages]]] forKey:@"rawFingerprintImages"];
    [dict setObject:[NSMutableArray arrayWithArray:[self getImageByteArrays: [onyxResult getProcessedFingerprintImages]]] forKey:@"processedFingerprintImages"];
    [dict setObject:[NSMutableArray arrayWithArray:[self getImageByteArrays: [onyxResult getEnhancedFingerprintImages]]] forKey:@"enhancedFingerprintImages"];
    [dict setObject:[NSMutableArray arrayWithArray:[self getImageByteArrays: [onyxResult getBlackWhiteProcessedFingerprintImages]]] forKey:@"blackWhiteProcessedFingerprintImages"];
    [dict setObject:[NSMutableArray arrayWithArray:[onyxResult getWsqData]] forKey:@"wsqData"];
    //add templates
    [dict setObject:[NSMutableArray arrayWithArray:[self getTemplateFlutterArrays: [onyxResult getFingerprintTemplates]]] forKey:@"iosFingerprintTemplates"];
    [dict setObject:[NSMutableArray arrayWithArray:[self getTemplateFlutterArrays: [onyxResult getISOFingerprintTemplates]]] forKey:@"iosISOFingerprintTemplates"];
    //add metrics
    CaptureMetrics* metrics= [onyxResult getMetrics];
    if(metrics != nil){
        [dict setObject:[NSNumber numberWithFloat:[metrics getLivenessConfidence]] forKey:@"livenessConfidence"];
        [dict setObject:[NSNumber numberWithFloat:[metrics getFocusQuality]] forKey:@"focusQuality"];
        NSMutableArray* nfiqArray=[metrics getNfiqMetrics];
        NSUInteger nfiqCount = [nfiqArray count];
        NSMutableArray *nfiqScores = [[NSMutableArray alloc] initWithCapacity:nfiqCount];
        NSMutableArray *mlpScores = [[NSMutableArray alloc] initWithCapacity:nfiqCount];
        for(NfiqMetrics* nfiq in nfiqArray){
            if(nfiq != nil){
                [nfiqScores addObject: [NSNumber numberWithInt:[nfiq getNfiqScore]]];
                [mlpScores addObject: [NSNumber numberWithFloat:[nfiq getMlpScore]]];
            }
        }
        [dict setObject:[NSMutableArray arrayWithArray:nfiqScores] forKey:@"nfiqScores"];
        [dict setObject:[NSMutableArray arrayWithArray:mlpScores] forKey:@"mlpScores"];
    }
    return dict;
}

/*
 Converts an array of templates for flutter.
*/
-(NSMutableArray*) getTemplateFlutterArrays:(NSMutableArray*) templateData{
    if(!templateData){
        return [[NSMutableArray alloc] initWithCapacity:0];
    }
    NSUInteger count = [templateData count];
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSData* data in templateData) {
        NSString* myString;
        myString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding ];
        [returnArray addObject:  [data base64EncodedDataWithOptions:NSUTF8StringEncoding]];
    }
    return returnArray;
}

/*
 Converts an array of UIImages to an array of byte arrays.
*/
-(NSMutableArray*) getImageByteArrays:(NSMutableArray*) imageArray{
    if(!imageArray){
        return [[NSMutableArray alloc] initWithCapacity:0];
    }
    NSUInteger count = [imageArray count];
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:count];
    for (UIImage* image in imageArray) {
        [returnArray addObject:  UIImagePNGRepresentation(image)];
    }
    return returnArray;
}

@end
