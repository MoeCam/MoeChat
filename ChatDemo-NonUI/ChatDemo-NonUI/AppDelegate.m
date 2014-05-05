//
//  AppDelegate.m
//  ChatDemo-NonUI
//
//  Created by dujiepeng on 14-4-1.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "EaseMob.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    // 聊天主界面
    UIViewController *rootView = [[RootViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]
                                   initWithRootViewController:rootView];
    rootView.title = @"易聊Demo";
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    BOOL ret = [[EaseMob sharedInstance]
                application:application
                didFinishLaunchingWithOptions:launchOptions];
    return ret;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

@end
