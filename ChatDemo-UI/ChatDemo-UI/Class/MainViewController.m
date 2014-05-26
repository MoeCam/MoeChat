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
#import "DataManager.h"
#import "AppDelegate.h"
#import "EaseMob.h"

@interface MainViewController ()<UITabBarDelegate,IChatManagerDelegate>
{
    UIBarButtonItem *_logoutItem;
    
    ChatListViewController *_chatListVC;
    ContactsViewController *_contactsVC;
}

@end

@implementation MainViewController

- (id)init
{
    self = [super init];
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
    
    _chatListVC = [[ChatListViewController alloc] initWithStyle:UITableViewStylePlain];
    _chatListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息列表" image:[UIImage imageNamed:@"Messages"] tag:0];
    
    _contactsVC = [[ContactsViewController alloc] initWithNibName:nil bundle:nil];
    _contactsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"好友列表" image:[UIImage imageNamed:@"Contacts"] tag:1];
    self.viewControllers = @[_chatListVC,_contactsVC];
    [[DataManager defaultManager] setContactsController:_contactsVC];
    [self registerNotifications];
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

-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

#pragma mark - 

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        self.title = @"消息列表";
        [self.navigationItem setLeftBarButtonItem:nil];
        [self.navigationItem setRightBarButtonItem:nil];
    }
    else{
        self.title = @"好友列表";
        
        _logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
        [self.navigationItem setLeftBarButtonItem:_logoutItem];
        UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"添加好友" style:UIBarButtonItemStyleBordered target:_contactsVC action:@selector(addFriendAction)];
        [self.navigationItem setRightBarButtonItem:addItem];
    }
}

-(void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - action

- (void)logout
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告"
                                                                message:@"退出当前账号失败，请重新操作"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        else{
            [[DataManager defaultManager] clear];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
        }
    } onQueue:nil];
}

-(void)didUnreadMessagesCountChanged{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    UIViewController *vc = [self.viewControllers objectAtIndex:0];
    if (unreadCount > 0) {
        vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadCount];
    }else{
        vc.tabBarItem.badgeValue = nil;
    }
}

-(void)didReceiveMessage:(EMMessage *)message{
    // 收到消息时，播放音频
    [[EaseMob sharedInstance].deviceManager asyncPlayNewMessageSound];
    // 收到消息时，震动
    [[EaseMob sharedInstance].deviceManager asyncPlayVibration];
}

@end
