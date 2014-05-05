//
//  MainViewController.m
//  ChatDemo-UI
//
//  Created by dujiepeng on 14-4-18.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "MainViewController.h"
#import "ChatListViewController.h"
#import "ContactsViewController.h"

#import "UIViewController+HUD.h"
#import "MBProgressHUD+Add.h"
#import "AppDelegate.h"

@interface MainViewController ()<UITabBarDelegate>
{
    UIBarButtonItem *_loginItem;
    
    ChatListViewController *_chatListVC;
    ContactsViewController *_contactsVC;
}

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"消息列表";
//    _loginItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    
    _chatListVC = [[ChatListViewController alloc] initWithNibName:nil bundle:nil];
    _chatListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息列表" image:nil tag:0];
    _contactsVC = [[ContactsViewController alloc] initWithNibName:nil bundle:nil];
    _contactsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"好友列表" image:nil tag:1];
    self.viewControllers = @[_chatListVC,_contactsVC];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        self.title = @"消息列表";
    }
    else{
        self.title = @"好友列表";
    }
}

@end
