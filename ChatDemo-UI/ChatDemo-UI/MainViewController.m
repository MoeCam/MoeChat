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
#import "Contact.h"
#import "ContactManager.h"
#import "UIViewController+HUD.h"
#import "MBProgressHUD+Add.h"
#import "AppDelegate.h"

@interface MainViewController ()

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
    self.title = @"EaseMobDemo";
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    ChatListViewController *chatListVC = [[ChatListViewController alloc] initWithNibName:nil bundle:nil];
    chatListVC.title = @"消息";
    ContactsViewController *contactsVC = [[ContactsViewController alloc] initWithNibName:nil bundle:nil];
    contactsVC.title = @"通讯录";
    self.viewControllers = @[chatListVC,contactsVC];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(![[EaseMob sharedInstance].userManager loginInfo]){
        [self login];
    }
}

// 登陆
-(void)login{
    
    [self showHudInView:self.view hint:@"登录中..."];
    [[EaseMob sharedInstance].userManager
     asyncLoginWithUsername:@"test2"
     password:@"123456"
     completion:^(NSDictionary *loginInfo, EMError *error) {
         [self hideHud];
         if (!error) {
             [self showHudInView:self.view hint:@"获取通讯录..."];
             EaseMob *em = [EaseMob sharedInstance];
             id<IUserManager> userMgr = em.userManager;
             [userMgr asyncFindAllUsersWithCompletion:^(NSArray *users,
                                                        EMError *error)
             {
                 [self hideHud];
                 if (users) {
                     NSMutableArray *contacts = [[NSMutableArray alloc]
                                                 initWithCapacity:0];
                     for (id<IUserBase>user in users) {
                         Contact *contact = [[Contact alloc] initWithRawUser:user];
                         [contacts addObject:contact];
                     }
                     [ContactManager setContacts:contacts];
                     [MBProgressHUD showSuccess:@"获取成功" toView:self.view];
                 }else {
                     [MBProgressHUD showError:@"通讯录获取失败" toView:self.view];
                 }

             } onQueue:nil];
                     }else {
             [MBProgressHUD showError:@"登录失败" toView:self.view];
         }
     } onQueue:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
