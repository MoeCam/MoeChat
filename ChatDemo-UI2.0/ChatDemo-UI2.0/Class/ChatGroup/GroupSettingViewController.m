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
    UISwitch *_igSwitch;
    UISwitch *_allSwitch;
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
    return 2;
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
        cell.textLabel.text = @"接收并提示群消息";
        
        if (_allSwitch == nil) {
            _allSwitch = [[UISwitch alloc] init];
            _allSwitch.frame = CGRectMake(self.tableView.frame.size.width - (_allSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - _allSwitch.frame.size.height) / 2, _allSwitch.frame.size.width, _allSwitch.frame.size.height);
            [_allSwitch addTarget:self action:@selector(allSwitchChanged:) forControlEvents:UIControlEventValueChanged];
        }
        [_allSwitch setOn:_group.isPushNotificationEnabled animated:YES];
        [cell.contentView addSubview:_allSwitch];
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"只接收不提示群消息";
        
        if (_igSwitch == nil) {
            _igSwitch = [[UISwitch alloc] init];
            _igSwitch.frame = CGRectMake(self.tableView.frame.size.width - (_igSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - _igSwitch.frame.size.height) / 2, _igSwitch.frame.size.width, _igSwitch.frame.size.height);
            [_igSwitch addTarget:self action:@selector(igSwitchChanged:) forControlEvents:UIControlEventValueChanged];
        }
        [_igSwitch setOn:!_group.isPushNotificationEnabled animated:YES];
        [cell.contentView addSubview:_igSwitch];
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
            [self allSwitchChanged:_allSwitch];
        }
        else{
            [self igSwitchChanged:_igSwitch];
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

- (void)allSwitchChanged:(id)sender
{
    BOOL toOn = _allSwitch.isOn;
    if (toOn && _igSwitch.isOn == YES) {
        [_igSwitch setOn:NO animated:YES];
    }
    [_allSwitch setOn:toOn animated:YES];
    [self isIgnoreGroup:!toOn];
}

- (void)igSwitchChanged:(id)sender
{
    BOOL toOn = _igSwitch.isOn;
    if (toOn && _allSwitch.isOn == YES) {
        [_allSwitch setOn:NO animated:YES];
    }
    [_igSwitch setOn:toOn animated:YES];
    [self isIgnoreGroup:toOn];
}

@end
