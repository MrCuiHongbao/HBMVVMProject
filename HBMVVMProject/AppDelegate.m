//
//  AppDelegate.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/6/28.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "AppDelegate.h"
#import "HBNavigationController.h"
#import "HBTabBarViewController.h"
#import "HBRouterUtils.h"
#import "HBRouter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
static int s_fatal_signals[] = {
    SIGABRT,
    SIGBUS,
    SIGFPE,
    SIGILL,
    SIGSEGV,
    SIGTRAP,
    SIGTERM,
    SIGKILL,
};

static int s_fatal_signal_num = sizeof(s_fatal_signals) / sizeof(s_fatal_signals[0]);

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *exceptionArray = [exception callStackSymbols]; // 得到当前调用栈信息
    NSString *exceptionReason = [exception reason];       // 非常重要，就是崩溃的原因
    NSString *exceptionName = [exception name];           // 异常类型
    NSLog(@"exceptionArray:%@",exceptionArray);
    NSLog(@"exceptionReason:%@",exceptionReason);
    NSLog(@"exceptionName:%@",exceptionName);

}

void SignalHandler(int code)
{
    NSLog(@"signal handler = %d",code);
}

void InitCrashReport()
{
    // 系统错误信号捕获
    for (int i = 0; i < s_fatal_signal_num; ++i) {
        signal(s_fatal_signals[i], SignalHandler);
    }
    
    //oc 未捕获异常的捕获
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    InitCrashReport();
    
    NSLog(@"NSRunLoop:%@",[NSRunLoop currentRunLoop]);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSDictionary *viewsViewController = @{@"HBTabBarModule":@[@"HomeModule",@"DisplayModule",@"DiscoveryModule",@"MineModule",@"MoneyModule",@"MoreModule",@"OpenGLModule"],@"HBTabBarIconName":@[@"integral",@"all",@"cameraswitching",@"bussiness-man",@"category",@"cameraswitching",@"add-account"],@"HBTabBarTitle":@[@"首页",@"列表",@"类别",@"我的",@"财富",@"更多",@"openGL"]};
    UIViewController  *tabBar = [HBRouter openURL:@"router://HBTabBarModule/HBTabBaexportInterface" arg:viewsViewController error:nil completion:^(id  _Nullable object) {
        NSLog(@"object----->%@",object);
    }];
    HBNavigationController  *nav = [HBRouter openURL:@"router://HBNavModule/HBNavModuleexportInterface" arg:@{@"rootVC":tabBar} error:nil completion:^(id  _Nullable object) {
        NSLog(@"object----->%@",object);
    }];
    [nav.navigationBar setHidden:YES];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (NSDictionary *)str:(NSString *)routerString{
    NSURL *url = [NSURL URLWithString:routerString];
    if ([url.scheme isEqualToString:@"router://"]) {
        NSLog(@"schema is error!! you must start with router://");
    }
    NSString * scheme = url.scheme;
    NSInteger  schemeLength = scheme.length+3;//://长度为3
    
    NSInteger   routerStringLength =routerString.length-schemeLength;
    
   NSString *resourceSpecifier = [routerString substringWithRange:NSMakeRange(schemeLength, routerStringLength)];
    NSArray *cms = [resourceSpecifier componentsSeparatedByString:@"/"];
    NSMutableDictionary *classInfo = [NSMutableDictionary dictionaryWithCapacity:1.0];
    [cms enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [classInfo setObject:obj forKey:@(idx)];
    }];
    return classInfo;
    NSLog(@"router://param  is nil");
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
