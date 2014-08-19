//
//  GroupSettingViewController.m
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-8-18.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "GroupSettingViewController.h"

@interface GroupSettingViewController ()
{
    EMGroup *_group;
    UISwitch *_switch;
}

@end

@implementation GroupSettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithGroup:(EMGroup *)group
{
    self = [self initWithStyle:UITableViewStylePlain];
    if (self) {
        _group = group;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"群设置";
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        if (_switch == nil) {
            _switch = [[UISwitch alloc] init];
            _switch.frame = CGRectMake(self.tableView.frame.size.width - (_switch.frame.size.width + 10), (cell.contentView.frame.size.height - _switch.frame.size.height) / 2, _switch.frame.size.width, _switch.frame.size.height);
            [_switch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        }
        BOOL isOn = _group.isPushNotificationEnabled;
        [_switch setOn:isOn animated:YES];
        
        if (isOn) {
            cell.textLabel.text = @"接收并提示群消息";
        }
        else{
            cell.textLabel.text = @"只接收不提示群消息";
        }
        
        [cell.contentView addSubview:_switch];
        [cell.contentView bringSubviewToFront:_switch];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self switchChanged:_switch];
        }
    }
}

#pragma mark - private

- (void)isIgnoreGroup:(BOOL)isIgnore
{
    __weak typeof(self) weakSelf = self;
    [self showHudInView:self.view hint:@"设置属性"];
    [[EaseMob sharedInstance].chatManager asyncIgnoreGroupPushNotification:_group.groupId isIgnore:isIgnore completion:^(NSArray *ignoreGroupsList, EMError *error) {
        [weakSelf hideHud];
        if (!error) {
            [weakSelf showHint:@"设置成功"];
            [weakSelf.tableView reloadData];
        }
        else{
            [weakSelf showHint:@"设置失败"];
        }
    } onQueue:nil];
}

#pragma mark - action

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchChanged:(id)sender
{
    BOOL toOn = _switch.isOn;
    [self isIgnoreGroup:!toOn];
}

@end
