#import <React/RCTBridgeModule.h>
#import <React/RCTRootView.h>

@interface Splash : NSObject <RCTBridgeModule>

+ (void)showWithGreetings:(RCTBridge*) bridge;

@end
