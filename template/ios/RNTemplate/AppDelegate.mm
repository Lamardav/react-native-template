#import "AppDelegate.h"
#if RCT_DEV
#import <React/RCTDevLoadingView.h>
#endif
#import <React/RCTBundleURLProvider.h>
#import <React/RCTLinkingManager.h>
#import <ReactNativeNavigation/ReactNativeNavigation.h>


#import "Orientation.h"
#import "TestConfiguration/TestConfigurationProvider.h"
// #import "TestConfiguration/SetIpView.h"

/**
 * Uses only for flipper.
 *
 * Code was taken from https://fbflipper.com/docs/getting-started/react-native-ios/#react-native-067
 * Although there is a version for 0.68+ version of react native in the documentation, the community prefers the 0.67 version because of build error
 */
#if DEBUG
    #ifdef FB_SONARKIT_ENABLED
        #import <FlipperKit/FlipperClient.h>
        #import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
        #import <FlipperKitLayoutPlugin/SKDescriptorMapper.h>
        #import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
        #import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>
        #import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
        #import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
    #endif
#endif



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  /**
   * Hardcode locks portrait orientation (uses react-native-orientation-locker library)
   */
  [Orientation setOrientation:(UIInterfaceOrientationMask)UIInterfaceOrientationMaskPortrait];

  /**
   * Uses only for flipper.
   */
  [self initializeFlipper:application];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  if ([TestConfigurationProvider isAvailable]) {
    return [RCTBundleURLProvider jsBundleURLForBundleRoot:@"index"
                                             packagerHost:[TestConfigurationProvider testIp]
                                                enableDev:[TestConfigurationProvider isDevMode]
                                       enableMinification:NO];
  } else {
    return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
  }
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

/**
 * Uses only for flipper.
 */
- (void) initializeFlipper:(UIApplication *)application {
  #if DEBUG
  #ifdef FB_SONARKIT_ENABLED
    FlipperClient *client = [FlipperClient sharedClient];
    SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
    [client addPlugin: [[FlipperKitLayoutPlugin alloc] initWithRootNode: application withDescriptorMapper: layoutDescriptorMapper]];
    [client addPlugin: [[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
    [client addPlugin: [FlipperKitReactPlugin new]];
    [client addPlugin: [[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
    [client start];
  #endif
  #endif
}


/**
 * Provides orientation class to get the supported interface orientations.
 *
 * Code was taken from react-native-orientation-locker library.
 */
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
  return [Orientation getOrientation];
}


/**
 * Enables common deepLinking for app (Don't confuse with uniLink).
 */
- (BOOL)application:(UIApplication *)application
   openURL:(NSURL *)url
   options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
  return [RCTLinkingManager application:application openURL:url options:options];
}


@end
