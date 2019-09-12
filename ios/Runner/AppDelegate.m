#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

#import "AppDelegate.h"
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>

//#import "AEManager.h"
#ifndef ALIBCTRADEMINISDK

#import "UTMini/AppMonitor.h"
#import<UTMini/AppMonitor.h>
#import <OpenMtopSDK/TBSDKLogUtil.h>
#import <TUnionTradeSDK/TUnionTradeSDK.h>

#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // 初始化函数
//    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
//        NSLog(@"初始化成功");
//    } failure:^(NSError *error) {
//        NSLog(@"初始化失败");
//    }];
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel methodChannelWithName:@"lingjuan/channel" binaryMessenger:controller];
    
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        
        if ([@"lingjuan" isEqualToString:call.method]) {
//            NSLog(@"fffffffffffffffffffffffffffffffffffffffff");
//            NSLog(@"%@", call.arguments);
//            NSDictionary *testdic = call.arguments;
//            NSString *idStr = testdic[@"id"];
//            NSLog(@"%@", idStr);
//            [self showALiBcTradeTaokeWithID:idStr];

            


            

            
           
        }else {
            NSLog(@"vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
        }
    
    }];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)showALiBcTradeTaokeWithID:(NSString *)idStr
{
    id<AlibcTradePage> page = [AlibcTradePageFactory itemDetailPage:idStr];
    
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    showParams.openType = AlibcOpenTypeNative;
    showParams.backUrl = @"tbopen27863805://";
    showParams.isNeedPush = NO;
    
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = @"mm_46748349_644650418_109378300241";
    //    taokeParams.subPid = @"mm_46748349_644650418_109378300241";
    taokeParams.adzoneId = @"109378300241";
    taokeParams.unionId = @"46748349";
    //    taokeParams.extParams = @{@"taokeAppkey" : @"27708881"};
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    [[AlibcTradeSDK sharedInstance].tradeService show:controller page:page showParams:showParams taoKeParams:taokeParams trackParam:nil
                          tradeProcessSuccessCallback:nil
                           tradeProcessFailedCallback:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (![[AlibcTradeSDK sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
        // 处理其他app跳转到自己的app
        
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    if (![[AlibcTradeSDK sharedInstance] application:application openURL:url options:options]) {
        // 处理其他app跳转到自己的app，如果百川处理过会返回YES
        
    }
    return YES;
}

@end
