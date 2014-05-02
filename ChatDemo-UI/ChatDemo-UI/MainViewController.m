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
    
    self.title = @"EaseMobDemo";
    _loginItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    
    _chatListVC = [[ChatListViewController alloc] initWithNibName:nil bundle:nil];
    _chatListVC.title = @"消息";
    _contactsVC = [[ContactsViewController alloc] initWithNibName:nil bundle:nil];
    _contactsVC.title = @"通讯录";
    self.viewControllers = @[_chatListVC,_contactsVC];
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
                     self.navigationItem.leftBarButtonItem = nil;
                     NSMutableArray *contacts = [[NSMutableArray alloc]
                                                 initWithCapacity:0];
                     for (id<IUserBase>user in users) {
                         Contact *contact = [[Contact alloc] initWithRawUser:user];
                         [contacts addObject:contact];
                     }
                     [ContactManager setContacts:contacts];
                     
                     NSDictionary *loginInfo = [[EaseMob sharedInstance].userManager loginInfo];
                     NSString *loginUserName = [loginInfo objectForKey:@"kUserLoginInfoUsername"];
                     self.title = [NSString stringWithFormat:@"%@的ChatDemo", loginUserName];
                     
                     [MBProgressHUD showSuccess:@"获取成功" toView:self.view];
                 }else {
                     self.navigationItem.leftBarButtonItem = _loginItem;
                     [MBProgressHUD showError:@"通讯录获取失败" toView:self.view];
                 }

             } onQueue:nil];
                     }
         else {
             self.navigationItem.leftBarButtonItem = _loginItem;
             [MBProgressHUD showError:@"登录失败" toView:self.view];
         }
     } onQueue:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
