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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    [self loginStateChange:nil];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

-(void)loginStateChange:(NSNotification *)notification{
    NSDictionary *loginInfo = nil;//[[[EaseMob sharedInstance] chatManager] loginInfo];
    UINavigationController *nav = nil;
    /*
     if (loginInfo && [loginInfo count] > 0) {
     MainViewController *mainVC = [[MainViewController alloc] init];
     nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
     }
     else{
     LoginViewController *loginController = [[LoginViewController alloc] init];
     nav = [[UINavigationController alloc] initWithRootViewController:loginController];
     }
     */
    MainViewController *mainVC = [[MainViewController alloc] init];
    nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:RGBACOLOR(78, 188, 211, 1)];
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(245, 245, 245, 1), NSForegroundColorAttributeName,
          [UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:21.0],
          NSFontAttributeName, nil]];
        
    }else{
        nav.navigationBar.barStyle = UIBarStyleDefault;
        nav.navigationBar.tintColor = [UIColor redColor];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                forBarMetrics:UIBarMetricsDefault];
        
        [nav.navigationBar.layer setMasksToBounds:YES];
    }
    
    self.window.rootViewController = nav;
    
}

@end
