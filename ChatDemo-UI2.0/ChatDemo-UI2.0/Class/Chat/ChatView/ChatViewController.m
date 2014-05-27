//
//  ChatViewController.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatViewModel.h"
#import "WCAlertView.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>{
    ChatViewModel       *_chatVCModel;
    NSMutableArray      *_messageSource;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChatViewController

- (id)initWithChatter:(NSString *)chatter
        andIsChatRoom:(BOOL)isChatroom{
    if (self = [super init]) {
        _chatVCModel = [[ChatViewModel alloc] initWithChatVC:self
                                                  andChatter:chatter
                                               andIsChatroom:isChatroom];
        self.title = chatter;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setupRightBarItem];
    [_chatVCModel loadMoreMessagesWithCount:5];
}

-(void)setupRightBarItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                              target:self
                                              action:@selector(removeAllChatMessages)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

- (void)removeAllChatMessages{
    [WCAlertView showAlertWithTitle:@"提示" message:@"删除所有消息?"
                 customizationBlock:nil
                    completionBlock:
     ^(NSUInteger buttonIndex, WCAlertView *alertView) {
         if (buttonIndex == 1) {
             [_chatVCModel removeAllMessages];
         }
     } cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
}

- (void)didRemoveAllMessages{
    [self.tableView reloadData];
}

- (void)didRemoveMessage:(NSString *)messageId success:(BOOL)isSuccess{
    
}

- (void)addMessage:(EMMessage *)message{
    
}

- (void)addMessages:(NSArray *)messages{
    
}

#pragma mark - TableViewDelegate & TableViewDatasource
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messageSource.count;
}

@end
