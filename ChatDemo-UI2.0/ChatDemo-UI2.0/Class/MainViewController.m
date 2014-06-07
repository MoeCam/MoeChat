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

//两次提示的默认间隔
const CGFloat kDefaultPlaySoundInterval = 3.0;

@interface MainViewController () <IChatManagerDelegate>
{
    ChatListViewController *_chatListVC;
    ContactsViewController *_contactsVC;
    SettingsViewController *_settingsVC;
    
    UIBarButtonItem *_addFriendItem;
}

@property (strong, nonatomic)NSDate *lastPlaySoundDate;

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
    
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"会话";
    
    //获取未读消息数，此时并没有把self注册为SDK的delegate，读取出的未读数是上次退出程序时的
    [self didUnreadMessagesCountChanged];
#warning 把self注册为SDK的delegate
    [self registerNotifications];
    
    [self setupSubviews];
    self.selectedIndex = 0;
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addButton addTarget:_contactsVC action:@selector(addFriendAction) forControlEvents:UIControlEventTouchUpInside];
    _addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self unregisterNotifications];
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        self.title = @"会话";
        self.navigationItem.rightBarButtonItem = nil;
    }else if (item.tag == 1){
        self.title = @"通讯录";
        self.navigationItem.rightBarButtonItem = _addFriendItem;
    }else if (item.tag == 2){
        self.title = @"设置";
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)setupSubviews
{
    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    self.tabBar.selectionIndicatorImage = [[UIImage imageNamed:@"tabbarSelectBg"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    
    _chatListVC = [[ChatListViewController alloc] init];
    _chatListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"会话"
                                                           image:nil
                                                             tag:0];
    [_chatListVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_chatsHL"]
                         withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_chats"]];
    [self unSelectedTapTabBarItems:_chatListVC.tabBarItem];
    [self selectedTapTabBarItems:_chatListVC.tabBarItem];
//    UINavigationController *chatNav = [[UINavigationController alloc] initWithRootViewController:_chatListVC];
    
    _contactsVC = [[ContactsViewController alloc] initWithNibName:nil bundle:nil];
    _contactsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通讯录"
                                                           image:nil
                                                             tag:1];
    [_contactsVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]
                         withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_contacts"]];
    [self unSelectedTapTabBarItems:_contactsVC.tabBarItem];
    [self selectedTapTabBarItems:_contactsVC.tabBarItem];
//    UINavigationController *contactNav = [[UINavigationController alloc] initWithRootViewController:_contactsVC];
    
    _settingsVC = [[SettingsViewController alloc] init];
    _settingsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置"
                                                           image:nil
                                                             tag:2];
    [_settingsVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_settingHL"]
                         withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_setting"]];
    _settingsVC.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self unSelectedTapTabBarItems:_settingsVC.tabBarItem];
    [self selectedTapTabBarItems:_settingsVC.tabBarItem];
//    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:_settingsVC];
    
    self.viewControllers = @[_chatListVC, _contactsVC, _settingsVC];
    [self selectedTapTabBarItems:_chatListVC.tabBarItem];
}

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14],
                                        UITextAttributeFont,[UIColor colorWithRed:0.393 green:0.553 blue:1.000 alpha:1.000],UITextAttributeTextColor,
                                        nil] forState:UIControlStateSelected];
}

// 统计未读消息数
-(void)setupUnreadMessageCount
{
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

#pragma mark - IChatManagerDelegate 消息变化

// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message{
    
#if !TARGET_IPHONE_SIMULATOR
    [self playSoundAndVibration];
    
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
        [self showNotificationWithMessage:message];
    }
#endif
    
}

- (void)playSoundAndVibration{
    
    //如果距离上次响铃和震动时间太短, 则跳过响铃
    NSLog(@"%@, %@", [NSDate date], self.lastPlaySoundDate);
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        return;
    }
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EaseMob sharedInstance].deviceManager asyncPlayNewMessageSound];
    // 收到消息时，震动
    [[EaseMob sharedInstance].deviceManager asyncPlayVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message{
    id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
    NSString *messageStr = nil;
    switch (messageBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            messageStr = ((EMTextMessageBody *)messageBody).text;
        }
            break;
        case eMessageBodyType_Image:
        {
            messageStr = @"[图片]";
        }
            break;
        case eMessageBodyType_Location:
        {
            messageStr = @"[位置]";
        }
            break;
        case eMessageBodyType_Voice:
        {
            messageStr = @"[音频]";
        }
            break;
        case eMessageBodyType_Video:
            break;
        default:
            break;
    }
    
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.alertBody = [NSString stringWithFormat:@"%@:%@", message.from, messageStr];
    notification.alertAction = @"打开";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber += 1;
}

#pragma mark - IChatManagerDelegate 好友变化

- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    if (!username) {
        return;
    }
    if (!message) {
        message = [NSString stringWithFormat:@"%@ 添加你为好友", username];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"username":username, @"applyMessage":message, @"acceptState":@NO}];
    [_contactsVC.applysArray addObject:dic];
    [_contactsVC reloadApplyView];
}

- (void)didUpdateBuddyList:(NSArray *)buddyList
            changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd
{
    [_contactsVC reloadDataSource];
}

- (void)didRemovedByBuddy:(NSString *)username{
    [_contactsVC reloadDataSource];
}

- (void)didAcceptedByBuddy:(NSString *)username
{
    [_contactsVC reloadDataSource];
}

- (void)didRejectedByBuddy:(NSString *)username{
    NSString *message = [NSString stringWithFormat:@"你被'%@'无耻的拒绝了", username];
    TTAlertNoTitle(message);
}

#pragma mark - IChatManagerDelegate 群组变化

@end
