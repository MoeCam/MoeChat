//
//  XDChatListViewController.m
//  leCar
//
//  Created by dujiepeng on 14-2-13.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatListViewController.h"
#import "MessageViewController.h"
#import "ChatListCell.h"
#import "NSDate+Category.h"
#import "SRRefreshView.h"
#import "AYZChatBroadcastManager.h"

@interface ChatListViewController ()
<
AYZConversationProtocol,
SRRefreshDelegate,
UISearchBarDelegate,
UISearchDisplayDelegate
>
{
    NSMutableArray *_conversations;
    SRRefreshView   *_slimeView;
    NSString *_currentUsername;
}

@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;

@end

@implementation ChatListViewController

@synthesize searchDisplayController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#warning 以下一行代码是将self注册为AYZChatBroadcastManager的会话管理代理，AYZChatBroadcastManager接收由XMPP发出的所有广播，然后进行相应判断，通知给会话管理代理。代理必须符合AYZConversationProtocol协议
    [[AYZChatBroadcastManager defaultManager] setConversationDelegate:self];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView registerClass:[ChatListCell class] forCellReuseIdentifier:@"chatListCell"];
    
    _slimeView = [[SRRefreshView alloc] initWithHeight:30];
    _slimeView.delegate = self;
    _slimeView.upInset = 0;
    _slimeView.slimeMissWhenGoingBack = YES;
    _slimeView.slime.bodyColor = [UIColor grayColor];
    _slimeView.slime.skinColor = [UIColor grayColor];
    _slimeView.slime.lineWith = 1;
    _slimeView.slime.shadowBlur = 4;
    _slimeView.slime.shadowColor = [UIColor grayColor];
    [self.tableView addSubview:_slimeView];
    
    [self reloadConversationList];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_conversations && _conversations.count > 0) {
        [self reloadConversationList];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[AYZChatBroadcastManager defaultManager] setConversationDelegate:nil];
}

#pragma mark - UITableViewDelegate & UITableViewDatasource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"chatListCell";
    ChatListCell *cell = (ChatListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row < [_conversations count]) {
        EMConversation *conversation = [_conversations objectAtIndex:indexPath.row];
        if (conversation) {
            cell.name = conversation.chatter;
            cell.detailMsg = [self subTitleMessageByConversation:conversation];
            cell.time = [self lastMessageTimeByConversation:conversation];
            // cell.imageURL = [NSURL URLWithString:contact.avatar];
            cell.placeholderImage = [UIImage imageNamed:@"account_defaultHead.png"];
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EMConversation *item = [_conversations objectAtIndex:indexPath.row];
    [self pushToChatVC:item];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _conversations.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMConversation *converation = [_conversations objectAtIndex:indexPath.row];
        [[EaseMob sharedInstance].chatManager
         removeConversationByChatter:converation.chatter
         deleteMessages:NO];
        [_conversations removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate
//刷新消息列表
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self reloadConversationList];
    [_slimeView endRefresh];
}

-(void)pushToChatVC:(EMConversation *)item{
    MessageViewController *chatVC = [[MessageViewController alloc] initWithStyle:UITableViewStylePlain talkerUserName:item.chatter isChatroom:item.isChatroom];
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark - actions
-(void)reloadConversationList
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *conversationList = [[EaseMob sharedInstance].chatManager conversations];
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (EMConversation *con in conversationList) {
            [con loadNumbersOfMessages:1 before:[[NSDate date] timeIntervalSince1970] * 1000 + 100000];
            if (!con.messages || [con.messages count] == 0) {
                [[EaseMob sharedInstance].chatManager removeConversationByChatter:con.chatter deleteMessages:YES];
            }
            else{
                [tmpArray addObject:con];
            }
        }
        
        NSArray*sortArray = [tmpArray sortedArrayUsingComparator:^(EMConversation *obj1, EMConversation* obj2){
            EMMessage *message1 = obj1.messages.lastObject;
            EMMessage *message2 = obj2.messages.lastObject;
            if(message1.timestamp > message2.timestamp) {
                return(NSComparisonResult)NSOrderedAscending;
            }else {
                return(NSComparisonResult)NSOrderedDescending;
            }
        }];
        if (_conversations) {
            [_conversations removeAllObjects];
            [_conversations addObjectsFromArray:sortArray];
        }else {
            _conversations = [[NSMutableArray alloc] initWithArray:sortArray];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

// 刷新table
-(void)reloadTableView{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation{
    NSString *ret = @"";
    EMMessage *lastMessage =[conversation
                             loadNumbersOfMessages:3
                             before:[[NSDate date]
                                     timeIntervalSince1970InMilliSecond] + 100000].lastObject;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    else{
        ret = [[NSDate dateWithTimeIntervalInMilliSecondSince1970:[[NSDate date] timeIntervalSince1970]] formattedTime];
    }
    return ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation{
    NSString *ret = @"";
    EMMessage *lastMessage =[conversation
                             loadNumbersOfMessages:3
                             before:[[NSDate date]
                                     timeIntervalSince1970InMilliSecond] + 1000000].lastObject;
    EMMessageBody *messageBody = lastMessage.messageBodies.lastObject;
    switch (messageBody.messageBodyType) {
        case eMessageBodyType_Image:{
            ret = @"[图片]";
        }
            break;
        case eMessageBodyType_Text:{
            ret = ((EMTextMessageBody *)messageBody).text;
        }
            break;
        case eMessageBodyType_Voice:{
            ret = @"[声音]";
        }
            break;
        default:
            break;
    }
    return ret;
}

// 发送消息
-(void)gotoSendMessage:(NSNotification *)notification {
    NSDictionary *sendDict = notification.userInfo;
    NSString *chatter = [sendDict objectForKey:WILLSENDMESSAGETOUSERNAME];
    BOOL isChatroom = [[sendDict objectForKey:WILLSENDMESSAGETOUSERNAME_CHATROOMMESSAGE]
                       boolValue];
    
    MessageViewController *messageController = [[MessageViewController alloc] initWithStyle:UITableViewStylePlain talkerUserName:chatter isChatroom:isChatroom];
    [self.navigationController pushViewController:messageController animated:YES];
}

#pragma mark - AYZConversationProtocol

// conversation 数量变化
-(void)didUpdateConversationList:(NSArray *)conversationList
{
    [self reloadConversationList];
}

// 接收到消息
-(void)didReceiveMessage:(EMMessage *)message
{
    [self reloadConversationList];
}

@end
