import Flutter
import UIKit
import Onyx


public class SwiftOnyxPlugin: NSObject, FlutterPlugin
{
    let onyxConfig = OnyxConfiguration()
  public static func register(with registrar: FlutterPluginRegistrar) {
    //let onyx:OnyxConfiguration =  OnyxConfiguration();
    //let channel = FlutterMethodChannel(name: "onyx", binaryMessenger: registrar.messenger()
    let channel = FlutterMethodChannel(name: "com.dft.onyx_plugin/methodChannel", binaryMessenger: registrar.messenger())
   
    let instance = SwiftOnyxPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch (call.method) {
    case "startOnyx":
       // startOnyx();
        result("Onyx Started")
        break;

    case "configureOnyx":
        result("Onyx configured")
         configOnyx(call);
        break;
    default:
        result(" Not implemented")
    }
  }


    //
    func configOnyx(_ call: FlutterMethodCall){
       // let onyxConfig: OnyxConfiguration = OnyxConfiguration();
        let arguments =  call.arguments;
        onyxConfig = OnyxConfiguration();
        onyxConfig.viewController = self
        onyxConfig.licenseKey = arguments["licenseKey"]
        onyxConfig.returnRawFingerprintImage = false
        onyxConfig.returnProcessedFingerprintImage = arguments["isRawImageReturned"]
        onyxConfig.returnGrayRawFingerprintImage = false
        onyxConfig.returnGrayRawWsq = false
        onyxConfig.returnWsq = false
        onyxConfig.reticleOrientation = ReticleOrientation(rawValue: 0)
        onyxConfig.showSpinner = true
        onyxConfig.useLiveness = false
        onyxConfig.onyxCallback = onyxCallback
        onyxConfig.successCallback = onyxSuccessCallback
        onyxConfig.errorCallback = onyxErrorCallback

        let onyx: Onyx = Onyx()
        onyx.doSetup(onyxConfig)
        }
    func onyxCallback(configuredOnyx: Onyx?) -> Void {
        NSLog("Onyx Callback");
        DispatchQueue.main.async {
            configuredOnyx?.capture(self);
        }
    }

    func startOnyx() {
         NSLog(" :::startOnyx");
       DispatchQueue.main.async {
                   configuredOnyx?.capture(self);
               }
    }

    func onyxSuccessCallback(onyxResult: OnyxResult?) -> Void {
        NSLog("Onyx Success Callback");
    }

    func onyxErrorCallback(onyxError: OnyxError?) -> Void {
        NSLog("Onyx Error Callback");
        NSLog(onyxError?.errorMessage ?? "Onyx returned an error");
    }
}
