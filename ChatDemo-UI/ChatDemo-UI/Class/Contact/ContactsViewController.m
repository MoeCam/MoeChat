//
//  ContactsViewController.m
//  ChatDemo-UI
//
//  Created by dujiepeng on 14-4-18.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "ContactsViewController.h"
#import "EMMessageViewController.h"
#import "EMChatSendHelper.h"

@interface ContactsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
}

@property (strong, nonatomic) NSString *currentUsername;
@property (strong, nonatomic) NSMutableArray *dataSource;;

@end

@implementation ContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
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
    
    [self loadContacts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)currentUsername
{
    if (_currentUsername == nil || _currentUsername.length == 0) {
        NSDictionary *loginInfo = [[EaseMob sharedInstance].chatManager loginInfo];
        _currentUsername = [loginInfo objectForKey:@"kUserLoginInfoUsername"];
    }
    
    return _currentUsername;
}

#pragma tableViewDelegate & tableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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

    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *toUsername = [self.dataSource objectAtIndex:indexPath.row];
    [EMChatSendHelper sendMessageWithUsername:toUsername andIsChatroom:NO];
}

#pragma mark - data

- (void)loadContacts
{
    [self.dataSource removeAllObjects];
    NSArray *array = @[@"test1", @"test2", @"test3", @"test4"];
    [self.dataSource addObjectsFromArray:array];
    
//    [self.dataSource addObjectsFromArray:[[EaseMob sharedInstance].chatManager buddyList]];
    [_tableView reloadData];
}

@end
