//
//  AppDelegate.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "MobClick.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:RGBACOLOR(78, 188, 211, 1)];
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(245, 245, 245, 1), NSForegroundColorAttributeName, [UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    }
    
    NSString *bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    if ([bundleID isEqualToString:@"com.easemob.enterprise.demo.ui"]) {
        [MobClick startWithAppkey:@"5389bb7f56240ba94208ac97"
                     reportPolicy:BATCH
                        channelId:Nil];
        
        [MobClick setLogEnabled:YES];
    }

#warning SDK注册
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"easemob-demo#chatdemoui"];
    [[EaseMob sharedInstance] enableBackgroundReceiveMessage];
    [[EaseMob sharedInstance] application:application
            didFinishLaunchingWithOptions:launchOptions];

    [self loginStateChange:nil];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken
{
#warning SDK方法调用
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

-(void)loginStateChange:(NSNotification *)notification
{
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    UINavigationController *nav = nil;
    
    BOOL isLogin = loginInfo && [loginInfo count] > 0;
    if (notification.object) {
        isLogin = [notification.object boolValue] && isLogin;
    }
    
    if (isLogin) {
        MainViewController *mainVC = [[MainViewController alloc] init];
        nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    }
    else{
        LoginViewController *loginController = [[LoginViewController alloc] init];
        nav = [[UINavigationController alloc] initWithRootViewController:loginController];
        loginController.title = @"环信Demo";
    }

    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
        nav.navigationBar.barStyle = UIBarStyleDefault;
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                forBarMetrics:UIBarMetricsDefault];
        
        [nav.navigationBar.layer setMasksToBounds:YES];
    }
    
    self.window.rootViewController = nav;
    
    [nav setNavigationBarHidden:YES];
    [nav setNavigationBarHidden:NO];
}

@end
