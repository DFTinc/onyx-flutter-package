#import "OnyxPlugin.h"
#if __has_include(<onyx/onyx-Swift.h>)
#import <onyx/onyx-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "onyx-Swift.h"
#endif

@implementation OnyxPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOnyxPlugin registerWithRegistrar:registrar];
}
@end
