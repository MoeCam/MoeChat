//
//  MainViewController.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "MainViewController.h"
#import "ChatListViewController.h"
#import "ContactsViewController.h"
#import "SettingsViewController.h"

@interface MainViewController (){
    ChatListViewController *_chatListVC;
    ContactsViewController *_contactsVC;
    SettingsViewController *_settingsVC;
}

@end

@implementation MainViewController

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
    
    
    _chatListVC = [[ChatListViewController alloc] init];
    _chatListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"会话"
                                                           image:nil
                                                             tag:0];
    
    _contactsVC = [[ContactsViewController alloc] init];
    _contactsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通讯录"
                                                           image:nil
                                                             tag:1];
    
    _settingsVC = [[SettingsViewController alloc] init];
    _settingsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置"
                                                           image:nil
                                                             tag:2];
    
    self.viewControllers = @[_chatListVC, _contactsVC, _settingsVC];
    self.title = @"会话";
    self.selectedIndex = 0;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 0) {
        self.title = @"会话";
    }else if (item.tag == 1){
        self.title = @"通讯录";
    }else if (item.tag == 2){
        self.title = @"设置";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
