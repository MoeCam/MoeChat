//
//  ContactsViewController.m
//  ChatDemo-UI
//
//  Created by dujiepeng on 14-4-18.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "ContactsViewController.h"
#import "Contact.h"
#import "EMMessageViewController.h"
#import "ContactManager.h"
#import "EMChatSendHelper.h"

@interface ContactsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_contacts;
    UITableView *_tableView;
}

@property (strong, nonatomic) NSString *currentUsername;

@end

@implementation ContactsViewController

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
    self.title = self.currentUsername;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class]
       forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    _contacts = [NSMutableArray arrayWithArray:[ContactManager contacts]];
    for (Contact *contact in _contacts) {
        if ([contact.username isEqualToString:self.currentUsername]) {
            [_contacts removeObject:contact];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)currentUsername
{
    if (_currentUsername == nil || _currentUsername.length == 0) {
        NSDictionary *loginInfo = [[EaseMob sharedInstance].userManager
                                   loginInfo];
        _currentUsername = [loginInfo objectForKey:@"kUserLoginInfoUsername"];
    }
    
    return _currentUsername;
}

#pragma tableViewDelegate & tableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger ret = 0;
    if (_contacts) {
        ret = _contacts.count;
    }
    return ret;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"cell"];
    
    Contact *contact = [_contacts objectAtIndex:indexPath.row];
    cell.textLabel.text = contact.nickname?contact.nickname:contact.username;
    return cell;
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *toUsername = ((Contact *)[_contacts
                                        objectAtIndex:indexPath.row]).username;
   
    if ([_currentUsername isEqualToString:toUsername]) {
        [WCAlertView showAlertWithTitle:nil
                                message:@"不能给自己发消息"
                     customizationBlock:^(WCAlertView *alertView)
         {
             
         } completionBlock:^(NSUInteger buttonIndex,
                             WCAlertView *alertView)
         {
             
         } cancelButtonTitle:@"确定"
                      otherButtonTitles: nil];
        return;
        
    }
    
    [EMChatSendHelper sendMessageWithUsername:toUsername
                              andIsChatroom:NO];
}

@end
