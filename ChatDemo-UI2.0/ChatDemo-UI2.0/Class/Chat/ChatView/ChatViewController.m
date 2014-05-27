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
#import "NSDate+Category.h"
#import "EMChatCellBubbleModel.h"
#import "EMChatTimeCell.h"
#import "EMChatCell.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>{
    ChatViewModel       *_chatVCModel;
    NSMutableArray      *_messageSource;
}

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSDate        *chatTagDate;

@end

@implementation ChatViewController

- (id)initWithChatter:(NSString *)chatter
        andIsChatRoom:(BOOL)isChatroom{
    if (self = [super init]) {
        _chatVCModel = [[ChatViewModel alloc] initWithChatVC:self
                                                  andChatter:chatter
                                               andIsChatroom:isChatroom];
        self.title = chatter;
        [_chatVCModel loadMoreMessagesWithCount:5];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setupRightBarItem];
    self.view.backgroundColor = CHATVIEWBACKGROUNDCOLOR;
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[EMChatTimeCell class] forCellReuseIdentifier:@"EMChatTimeCell"];
        _tableView.backgroundColor = CHATVIEWBACKGROUNDCOLOR;
    }
    
    return _tableView;
}

- (NSDate *)chatTagDate
{
    if (_chatTagDate == nil) {
        _chatTagDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:0];
    }
    
    return _chatTagDate;
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
    [_messageSource removeAllObjects];
    [self.tableView reloadData];
}

- (void)didRemoveMessage:(NSString *)messageId
                 success:(BOOL)isSuccess{
    
}

- (NSArray *)setupMessage:(EMMessage *)message{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
    NSTimeInterval tempDate = [createDate timeIntervalSinceDate:self.chatTagDate];
    if (tempDate > 60 || tempDate < -60 || tempDate == 0) {
        [ret addObject:[createDate formattedTime]];
        self.chatTagDate = createDate;
    }
    
    [ret addObject:[EMChatCellBubbleModel modelWithMessage:message]];
    
    return ret;
}

- (void)addMessage:(EMMessage *)message{
    NSArray *messages = [self setupMessage:message];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < messages.count; i++) {
        [_messageSource addObject:[messages objectAtIndex:i]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(_messageSource.count - 1)
                                                    inSection:0];
        [indexPaths addObject:indexPath];
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    [self performSelector:@selector(scrollViewToBottom:) withObject:nil afterDelay:0.1];
}

- (void)addMessages:(NSArray *)messages{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if (messages && [messages count] > 0) {
        
        for (EMMessage *message in messages) {
            NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
            NSTimeInterval tempDate = [createDate timeIntervalSinceDate:self.chatTagDate];
            if (tempDate > 60 || tempDate < -60 || tempDate == 0) {
                [resultArray addObject:[createDate formattedTime]];
                self.chatTagDate = createDate;
            }
            [resultArray addObject:[EMChatCellBubbleModel modelWithMessage:message]];
        }
    }
    
    if (_messageSource) {
        [_messageSource addObjectsFromArray:resultArray];
    }else{
        _messageSource  = [[NSMutableArray alloc] initWithArray:resultArray];
    }
}

- (void)scrollViewToBottom:(BOOL)animated
{
    if (_messageSource.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath
                                  indexPathForRow:(_messageSource.count - 1)
                                  inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}


#pragma mark - TableViewDelegate & TableViewDatasource
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < [_messageSource count]) {
        id obj = [_messageSource objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[NSString class]]) {
            EMChatTimeCell *timeCell = (EMChatTimeCell *)[tableView dequeueReusableCellWithIdentifier:@"EMChatTimeCell"];
            timeCell.textLabel.text = (NSString *)obj;
            timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return timeCell;
        }
        else{
            EMChatCell *cell = (EMChatCell *)[tableView dequeueReusableCellWithIdentifier:@"EMChatCell"];
            if (!cell) {
                cell = [[EMChatCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:@"EMChatCell"
                                         withBubbleModel:obj];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.model = obj;
            return cell;
        }
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *obj = [_messageSource objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        return 40;
    }
    else{
        return [EMChatCell tableView:tableView
             heightForRowAtIndexPath:indexPath
                       withChatModel:(EMChatCellBubbleModel *)obj];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messageSource.count;
}

@end
