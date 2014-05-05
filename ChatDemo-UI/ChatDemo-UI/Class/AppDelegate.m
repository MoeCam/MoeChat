//
//  AppDelegate.m
//  ChatDemo-UI
//
//  Created by dujiepeng on 14-4-18.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "EMLoginViewController.h"
#import "BMKMapManager.h"

@interface AppDelegate ()

@property (strong, nonatomic) MainViewController *mainVC;
@property (strong, nonatomic) EMLoginViewController *loginController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
#warning Baidu地图SDK测试Key值
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:@"akCmCtku7GVde6q2FcCpGo69"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange) name:KNOTIFICATION_LOGINCHANGE object:nil];
    
    self.mainVC = [[MainViewController alloc] init];
    self.loginController = [[EMLoginViewController alloc] init];
    
    [self loginStateChange];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)loginStateChange
{
    UINavigationController *nacontroller = nil;
    NSDictionary *info = [[EaseMob sharedInstance].chatManager loginInfo];
    if (info && [info count] > 0) {
        nacontroller = [[UINavigationController alloc] initWithRootViewController:self.mainVC];
    }
    else{
        nacontroller = [[UINavigationController alloc] initWithRootViewController:self.loginController];
    }
    
    self.window.rootViewController = nacontroller;
}

@end
