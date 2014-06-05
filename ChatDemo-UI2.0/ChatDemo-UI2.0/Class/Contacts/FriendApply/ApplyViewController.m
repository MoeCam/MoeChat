//
//  ApplyViewController.m
//  ChatDemo-UI
//
//  Created by dhcdht on 14-5-15.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "ApplyViewController.h"

#import "ApplyFriendCell.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.title = @"好友申请";
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    }
    
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    if (dic) {
        cell.indexPath = indexPath;
        cell.imageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
        cell.textLabel.text = [dic objectForKey:@"username"];
//        cell.detailTextLabel.text = [dic objectForKey:@"applyMessage"];
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
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ApplyFriendCellDelegate

- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        NSMutableDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        EMError *error;
        [[EaseMob sharedInstance].chatManager acceptBuddyRequest:[dic objectForKey:@"username"] error:&error];
        [self hideHud];
        if (!error) {
            [self.dataSource removeObject:dic];
            [self.tableView reloadData];
            [self showHint:@"添加好友成功"];
        }
        else{
            [self showHint:@"添加好友失败"];
        }
    }
}

- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        NSMutableDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        EMError *error;
        [[EaseMob sharedInstance].chatManager rejectBuddyRequest:[dic objectForKey:@"username"] reason:@"" error:&error];
        [self hideHud];
        if (!error) {
            [self.dataSource removeObject:dic];
            [self.tableView reloadData];
        }
        else{
            [self showHint:@"拒绝申请失败"];
        }
    }
}

@end
