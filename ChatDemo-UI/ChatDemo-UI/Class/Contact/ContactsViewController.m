//
//  ContactsViewController.m
//  ChatDemo-UI
//
//  Created by xieyajie on 14-4-18.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "ContactsViewController.h"

#import "MessageViewController.h"
#import "TextFieldViewController.h"
#import "ApplyViewController.h"
#import "MessageViewController.h"
#import "EaseMob.h"

@interface ContactsViewController ()<IChatManagerDelegate>
{
    ApplyViewController *_applyController;
}

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
        _applysArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma tableViewDelegate & tableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    NSInteger ret = 0;
    if (self.dataSource) {
        ret = self.dataSource.count;
    }
    return ret;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"新的好友";
    }
    else{
        EMBuddy *buddy = [self.dataSource objectAtIndex:indexPath.row];
        if (buddy) {
            cell.textLabel.text = buddy.username;
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (_applyController == nil) {
            _applyController = [[ApplyViewController alloc] initWithStyle:UITableViewStylePlain];
        }
        
        _applyController.dataSource = self.applysArray;
        [_applyController.tableView reloadData];
        [self.navigationController pushViewController:_applyController animated:YES];
    }
    else{
        NSString *toUsername = [[self.dataSource objectAtIndex:indexPath.row] username];
        MessageViewController *messageController = [[MessageViewController alloc] initWithStyle:UITableViewStylePlain talkerUserName:toUsername isChatroom:NO];
        [self.tabBarController.navigationController pushViewController:messageController animated:YES];
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0) {
        return NO;
    }
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        EMError *error;
        [[EaseMob sharedInstance].chatManager removeBuddy:[[self.dataSource objectAtIndex:indexPath.row] username] removeFromRemote:NO error:&error];
        if (!error) {
            [tableView beginUpdates];
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView endUpdates];
        }
        else{
            [self showHint:@"删除失败，请重新操作"];
        }
    }
}

#pragma mark - action

- (void)addFriendAction
{
    TextFieldViewController *textController = [[TextFieldViewController alloc] init];
    [textController setViewDidLoadCompletion:^(TextFieldViewController *controller){
        controller.title = @"添加好友";
        controller.textField.placeholder = @"请输入要添加的好友";
        controller.textField.keyboardType = UIKeyboardTypeEmailAddress;
    }];
    
    __block __weak ContactsViewController *weakSelf = self;
    [textController setSaveFinishCompletion:^(NSString *string) {
        if (string.length == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        else{
            EMError *error;
            [[EaseMob sharedInstance].chatManager addBuddy:string withNickname:string message:[NSString stringWithFormat:@"%@ 添加您为好友", string] error:&error];
            if (error) {
                [weakSelf showHint:@"添加失败，请重新操作"];
            }
            else{
                [weakSelf showHint:@"添加成功"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    [self.navigationController pushViewController:textController animated:YES];
}

#pragma mark - data

- (void)reloadApplyView
{
    if (_applyController != nil) {
        _applyController.dataSource = self.applysArray;
        [_applyController.tableView reloadData];
    }
}

- (void)reloadDataSource
{
    [self.dataSource removeAllObjects];
    NSArray *array = [[EaseMob sharedInstance].chatManager buddyList];
    
//    for (EMBuddy *buudy in array) {
//        if (buudy.isPendingApproval) {
//            [self.dataSource addObject:buudy];
//        }
//    }
    [self.dataSource addObjectsFromArray:array];
    [self.tableView reloadData];
}

@end
