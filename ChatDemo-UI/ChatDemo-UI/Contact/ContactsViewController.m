//
//  ContactsViewController.m
//  ChatDemo-UI
//
//  Created by dujiepeng on 14-4-18.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "ContactsViewController.h"
#import "Contact.h"
#import "ChatViewController.h"
#import "ContactManager.h"
#import "ChatSendHelper.h"

@interface ContactsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_contacts;
    UITableView *_tableView;
}

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
    _contacts = [ContactManager contacts];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class]
       forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString *toUsername = ((Contact *)[_contacts
                                        objectAtIndex:indexPath.row]).username;
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [ChatSendHelper sendMessageWithUsername:toUsername
                              andIsChatroom:NO];
}

@end
