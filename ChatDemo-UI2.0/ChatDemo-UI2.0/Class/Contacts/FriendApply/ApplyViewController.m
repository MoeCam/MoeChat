/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "ApplyViewController.h"

#import "ApplyFriendCell.h"

static ApplyViewController *controller = nil;

@interface ApplyViewController ()<ApplyFriendCellDelegate>

@end

@implementation ApplyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (instancetype)shareController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] initWithStyle:UITableViewStylePlain];
    });
    
    return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.title = @"申请通知";
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.tableView reloadData];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplyFriendCell";
    ApplyFriendCell *cell = (ApplyFriendCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[ApplyFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    if (dic) {
        cell.indexPath = indexPath;
        ApplyStyle applyStyle = [[dic objectForKey:@"applyStyle"] integerValue];
        if (applyStyle == ApplyStyleGroupInvitation) {
            cell.titleLabel.text = @"群组通知";
            cell.headerImageView.image = [UIImage imageNamed:@"groupPrivateHeader"];
        }
        else if (applyStyle == ApplyStyleJoinGroup)
        {
            cell.titleLabel.text = @"群组通知";
            cell.headerImageView.image = [UIImage imageNamed:@"groupPrivateHeader"];
        }
        else if(applyStyle == ApplyStyleFriend){
            cell.titleLabel.text = [dic objectForKey:@"title"];
            cell.headerImageView.image = [UIImage imageNamed:@"chatListCellHead"];
        }
        cell.contentLabel.text = [dic objectForKey:@"applyMessage"];
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    return [ApplyFriendCell heightWithContent:[dic objectForKey:@"applyMessage"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ApplyFriendCellDelegate

- (void)removeDataFromDataSource:(NSDictionary *)dic
{
    [self.dataSource removeObject:dic];
    [self.tableView reloadData];
}

- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        NSMutableDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        ApplyStyle applyStyle = [[dic objectForKey:@"applyStyle"] integerValue];
        EMError *error;
        if (applyStyle == ApplyStyleGroupInvitation) {
            [[EaseMob sharedInstance].chatManager acceptInvitationFromGroup:[dic objectForKey:@"groupId"] error:&error];
        }
        else if (applyStyle == ApplyStyleJoinGroup)
        {
            [[EaseMob sharedInstance].chatManager acceptApplyJoinGroup:[dic objectForKey:@"groupId"] groupname:[dic objectForKey:@"groupname"] applicant:[dic objectForKey:@"username"] error:&error];
        }
        else if(applyStyle == ApplyStyleFriend){
            [[EaseMob sharedInstance].chatManager acceptBuddyRequest:[dic objectForKey:@"username"] error:&error];
        }
        
        [self hideHud];
        if (!error) {
            [self removeDataFromDataSource:dic];
        }
        else{
            [self showHint:@"接受失败"];
        }
    }
}

- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        NSMutableDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        ApplyStyle applyStyle = [[dic objectForKey:@"applyStyle"] integerValue];
        EMError *error;
        if (applyStyle == ApplyStyleGroupInvitation) {
            [[EaseMob sharedInstance].chatManager rejectInvitationForGroup:[dic objectForKey:@"groupId"] toInviter:[dic objectForKey:@"username"] reason:@""];
        }
        else if (applyStyle == ApplyStyleJoinGroup)
        {
            NSString *reason = [NSString stringWithFormat:@"被拒绝加入群组\'%@\'", [dic objectForKey:@"groupname"]];
            [[EaseMob sharedInstance].chatManager rejectApplyJoinGroup:[dic objectForKey:@"groupId"] groupname:[dic objectForKey:@"groupname"] toApplicant:[dic objectForKey:@"username"] reason:reason];
        }
        else if(applyStyle == ApplyStyleFriend){
            [[EaseMob sharedInstance].chatManager rejectBuddyRequest:[dic objectForKey:@"username"] reason:@"" error:&error];
        }
        
        [self hideHud];
        if (!error) {
            [self removeDataFromDataSource:dic];
        }
        else{
            [self showHint:@"拒绝失败"];
        }
    }
}

#pragma mark - public

- (void)addNewApply:(NSDictionary *)dictionary
{
    if (dictionary && [dictionary count] > 0) {
        NSString *newUsername = [dictionary objectForKey:@"username"];
        BOOL isGroup = [[dictionary objectForKey:@"isGroup"] boolValue];
        if (newUsername && newUsername.length > 0) {
            for (NSDictionary *tmpDic in _dataSource) {
                NSString *tmpUsername = [tmpDic objectForKey:@"username"];
                BOOL tmpIsGroup = [[tmpDic objectForKey:@"isGroup"] boolValue];
                if (isGroup == tmpIsGroup && [tmpUsername isEqualToString:newUsername]) {
                    
                    [_dataSource removeObject:tmpDic];
                    [_dataSource insertObject:dictionary atIndex:0];
                    [self.tableView reloadData];
                    
                    return;
                }
            }
            
            [_dataSource insertObject:dictionary atIndex:0];
            [self.tableView reloadData];
        }
    }
}

- (void)clear
{
    [_dataSource removeAllObjects];
}

@end
