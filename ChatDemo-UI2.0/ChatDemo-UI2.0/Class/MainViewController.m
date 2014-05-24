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

@interface MainViewController ()
{
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

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                    [UIFont systemFontOfSize:14], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                                    nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14],
                                        UITextAttributeFont,[UIColor colorWithRed:0.393 green:0.553 blue:1.000 alpha:1.000],UITextAttributeTextColor,
                                        nil] forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
 
    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    self.tabBar.selectionIndicatorImage = [[UIImage imageNamed:@"tabbarSelectBg"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
   
    _chatListVC = [[ChatListViewController alloc] init];
    _chatListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"会话"
                                                           image:nil
                                                             tag:0];
    [_chatListVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_chatsHL"]
                         withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_chats"]];
    [self unSelectedTapTabBarItems:_chatListVC.tabBarItem];
    
    _contactsVC = [[ContactsViewController alloc] init];
    _contactsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通讯录"
                                                           image:nil
                                                             tag:1];
    [_contactsVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]
                         withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_contacts"]];
    [self unSelectedTapTabBarItems:_contactsVC.tabBarItem];
    
    _settingsVC = [[SettingsViewController alloc] init];
    _settingsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置"
                                                           image:nil
                                                             tag:2];
    [_settingsVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_settingHL"]
                        withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_setting"]];
    _settingsVC.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self unSelectedTapTabBarItems:_settingsVC.tabBarItem];
    
    self.viewControllers = @[_chatListVC, _contactsVC, _settingsVC];
    self.title = @"会话";
    [self selectedTapTabBarItems:_chatListVC.tabBarItem];
    self.selectedIndex = 0;
    [self addChildViewController:_settingsVC];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    for (UITabBarItem* tempItem in tabBar.items) {
        if (tempItem == item) {
            [self selectedTapTabBarItems:tempItem];
        }else{
            [self unSelectedTapTabBarItems:tempItem];
        }
    }
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
