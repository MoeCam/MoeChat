//
//  SettingsViewController.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "SettingsViewController.h"

//#import "EaseMob.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 20, self.view.frame.size.width - 60, 40)];
    [logoutButton setBackgroundColor:[UIColor whiteColor]];
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - action

- (void)logoutAction
{
//    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
//        if (error) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"退出当前账号失败，请重新操作" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//        }
//        else{
//            [[DataManager defaultManager] clear];
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//        }
//    } onQueue:nil];
}
 
@end
