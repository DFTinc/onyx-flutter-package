#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

#import "OnyxPlugin.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  [GeneratedPluginRegistrant registerWithRegistry:self];
    FlutterViewController *flutterViewController =(FlutterViewController*)self.window.rootViewController;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:flutterViewController];
    [navigationController setNavigationBarHidden:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    OnyxPlugin.flutterViewController=flutterViewController;
    
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


@end
