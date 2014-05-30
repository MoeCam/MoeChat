//
//  AppDelegate.m
//  ChatDemo-UI
//
//  Created by dujiepeng on 14-4-18.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "AppDelegate.h"
#import "EaseMob.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "BMKMapManager.h"
#import "MobClick.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [MobClick startWithAppkey:@"538186af56240ba388140154" reportPolicy:BATCH channelId:Nil];
    [MobClick setLogEnabled:YES];
    
#warning Baidu地图SDK测试Key值
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:@"6QN0dGpbbrcFXqCpW4F86DeQ" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
#warning EaseMobSDK初始化
    [[EaseMob sharedInstance] application:application
            didFinishLaunchingWithOptions:launchOptions];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:KNOTIFICATION_LOGINCHANGE object:nil];
    
    [self loginStateChange:nil];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

- (void)loginStateChange:(NSNotification *)notification
{
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    UINavigationController *nacontroller = nil;
    if (loginInfo && [loginInfo count] > 0) {
        MainViewController *mainVC = [[MainViewController alloc] initWithNibName:nil bundle:nil];
        nacontroller = [[UINavigationController alloc] initWithRootViewController:mainVC];
    }
    else{
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        nacontroller = [[UINavigationController alloc] initWithRootViewController:loginController];
    }
    
    self.window.rootViewController = nacontroller;
    [nacontroller setNavigationBarHidden:YES];
    [nacontroller setNavigationBarHidden:NO];
}

@end
