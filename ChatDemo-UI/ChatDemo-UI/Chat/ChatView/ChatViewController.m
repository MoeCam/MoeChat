//
//  ChatViewController.m
//  leCar
//
//  Created by dujiepeng on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatToolBar.h"
#import "XDChatTimeCell.h"
#import "NSDate+Category.h"
#import "XDMenuItem.h"
#import "Contact.h"
#import "FaceView.h"
#import "BaseCell.h"
#import "ChatLeftTextCell.h"
#import "ChatRightTextCell.h"

#import "XDChatTimeCell.h"

#import "ChatTextBubbleView.h"
#import "ChatBaseBubbleView.h"

#import "ChatCellManager.h"
#import "ChatCellModelManager.h"

#import "ChatSendHelper.h"
#import "EMMessage.h"

#define kCellPadding 20

@interface ChatViewController () <ChatToolBarDelegate,
UITableViewDataSource,
UITableViewDelegate,
FaceDelegate,
IChatManagerDelegate> {
    ChatToolBar *_chatBar;
    NSMutableArray *_messages;
    EMConversation *_conversation;
    NSDate *_chatTempDate;
    NSIndexPath *_audioPlayIndexPath;
    id<IChatManager>_chatMgr;
}

@property (weak, nonatomic)IBOutlet UITableView *tableView;
@end

@implementation ChatViewController
-(id)initWithUsername:(NSString *)username isChatroom:(BOOL)isChatroom{
    if (self = [super init]) {
        
        _conversation = [[EaseMob sharedInstance].chatManager
                         conversationForChatter:username];
        _conversation.isChatroom = isChatroom;
        
        NSArray *messages = [_conversation
                             loadNumbersOfMessages:5
                             before:[[NSDate date]
                                     timeIntervalSince1970InMilliSecond] + 100000];
        _messages = [self createDataSource:messages];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置当前conversation 接收到message不再回调didUnreadMessagesCountChanged;
    _conversation.enableUnreadMessagesCountEvent = NO;
    
    [self registerNotification];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    
    // 初始化 chatBar
    _chatBar = [[ChatToolBar alloc] initWithViewController:self];
    self.tableView.frame = CGRectMake(0,
                                      0,
                                      self.view.frame.size.width,
                                      self.tableView.frame.size.height - _chatBar.frame.size.height);
    
    [self addGestureRecognizer];
    self.title = _conversation.chatter;
    [self registerCell];
    [self performSelector:@selector(scrollViewToArea:)
               withObject:@NO
               afterDelay:0];
}

-(void)registerCell{
    [self.tableView
     registerClass:[XDChatTimeCell class]
     forCellReuseIdentifier:@"XDChatTimeCell"];
    
    [self.tableView
     registerClass:[ChatLeftTextCell class]
     forCellReuseIdentifier:@"ChatLeftTextCell"];
    
    [self.tableView
     registerClass:[ChatRightTextCell class]
     forCellReuseIdentifier:@"ChatRightTextCell"];
    
}

// 添加需要显示的时间
-(NSMutableArray *)createDataSource:(NSArray *)messages{
    NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:0];
    if (!_chatTempDate) {
        _chatTempDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:0];
    }
    
    for (EMMessage *message in messages) {
        NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
        NSTimeInterval tempDate = [createDate timeIntervalSinceDate:_chatTempDate];
        if (tempDate > 60 || tempDate < -60 || tempDate == 0) {
            [ret addObject:[createDate formattedTime]];
            _chatTempDate = createDate;
        }
        [ret addObject:[ChatCellModelManager modelWithMessage:message]];
    }
    
    return ret;
}

-(NSMutableArray *)addChatToMessage:(EMMessage *)message{
    if (!_chatTempDate) {
        _chatTempDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:0];
    }
    NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:0];
    NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
    NSTimeInterval tempDate = [createDate timeIntervalSinceDate:_chatTempDate];
    if (tempDate > 60 || tempDate < -60 || tempDate == 0) {
        [ret addObject:[createDate formattedTime]];
        _chatTempDate = createDate;
    }
    
    ChatCellModel *cellModel = [ChatCellModelManager
                                modelWithMessage:message];
    [ret addObject:cellModel];
    return ret;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ChatToolBarDelegate
// 传入需要显示的shareMoreView
-(UIView *)shareMoreView{
    return nil;
}

// 传入需要显示的emojiActionView
-(UIView *)emojiActionView{
    FaceView *faceView = [[FaceView alloc]
                          initWithFrame:CGRectMake(0, 0, 320, 200)];
    faceView.delegate = self;
    return faceView;
}

// 需要与键盘一起变化的UITableView
-(UIView *)showTableView{
    return self.tableView;
}
// 传入用于显示语音时动画的View（如果没有，传nil）
-(UIView *)recordView{
    return nil;
}
#pragma mark - FacialViewDelegate
-(void)selectedFacialView:(NSString*)str isDelete:(BOOL)isDelete{
    NSString *text = _chatBar.textView.text;
    
    if (!isDelete) {
        _chatBar.textView.text = [NSString stringWithFormat:@"%@%@",text,str];
    }else {
        if (text.length >= 2 && [[text substringFromIndex:text.length-2] isEqualToString:str]) {
            _chatBar.textView.text = [text substringToIndex:text.length-2];
        }else {
            if (text.length >= 1) {
                _chatBar.textView.text = [text substringToIndex:text.length-1];
            }
        }
    }
}

-(void)sendMessageFormFaceView{
    // todo 发送消息
    NSString *textMessage = _chatBar.textView.text;
    [self sendTextMessage:textMessage];
    _chatBar.textView.text = @"";
}

#pragma mark - actions
// 点击背景隐藏
-(void)keyBoardHidden{
    [self.view endEditing:YES];
}

// 添加事件
-(void)addGestureRecognizer{
    // 点击背景隐藏键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
										  initWithTarget:self action:@selector(handleLongPress:)];
	lpgr.minimumPressDuration = .5;
	[self.tableView addGestureRecognizer:lpgr];
    
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *obj = [_messages objectAtIndex:indexPath.row];
    return [ChatCellManager tableView:tableView cellWithObject:obj];
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *obj = [_messages objectAtIndex:indexPath.row];
    return [ChatCellManager tableView:tableView
              heightForRowAtIndexPath:indexPath
                            andObject:obj];
}
#pragma mark - ChatCell actions
- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        if (![[_messages objectAtIndex:indexPath.row]
              isKindOfClass:[NSString class]])
        {
            BaseCell *cell = (BaseCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [self showMenuViewController:cell.bubbleView andIndexPath:indexPath];
        };
    }
}

- (void)showMenuViewController:(UIView*)showInView
                  andIndexPath:(NSIndexPath *)indexPath
{
    [showInView becomeFirstResponder];
    XDMenuItem *copy = [[XDMenuItem alloc] initWithTitle:@"复制" action:@selector(handleCopyCell:)];
    copy.indexPath = indexPath;
    XDMenuItem *delete = [[XDMenuItem alloc] initWithTitle:@"删除" action:@selector(handleDeleteCell:)];
    delete.indexPath = indexPath;
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:copy, delete, nil]];
    CGRect frame = showInView.frame;
    frame.origin.y = 0;
    frame.origin.x = 0;
    frame = [showInView convertRect:frame toView:self.view];
    [menu setTargetRect:frame inView:self.view];
    [menu setMenuVisible:YES animated:YES];
}



#pragma mark - MenuItem actions
- (void)handleCopyCell:(id)sender{
    // todo by du. 复制
}

- (void)handleDeleteCell:(id)sender{
    UIMenuController *menuController = (UIMenuController *)sender;
    XDMenuItem *item = menuController.menuItems.lastObject;
    NSMutableArray *needDeleteIndexPaths = [[NSMutableArray alloc] initWithCapacity:0];
    if (item.indexPath.row > 0) {
        ChatCellModel * model = [_messages objectAtIndex:item.indexPath.row];
        for (EMMessage *message in _conversation.messages) {
            if ([message.messageId isEqualToString:model.messageId]) {
                [_conversation removeMessage:message];
                break;
            }
        }
        
        [_messages removeObject:model];
        if ([[_messages objectAtIndex:item.indexPath.row - 1] isKindOfClass:[NSString class]]) {
            [_messages removeObjectAtIndex:item.indexPath.row - 1];
            NSIndexPath *dateIndexPath = [NSIndexPath indexPathForRow:item.indexPath.row - 1
                                                            inSection:item.indexPath.section];
            [needDeleteIndexPaths addObject:dateIndexPath];
        }
        [needDeleteIndexPaths addObject:item.indexPath];
        
        [self.tableView deleteRowsAtIndexPaths:needDeleteIndexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    if(_messages.count == 0){
        // 如果没有发送消息，则删除这条chat
        [[EaseMob sharedInstance].chatManager
         removeConversationByChatter:_conversation.chatter
         deleteMessages:YES];
    }
}

-(void)dealloc{
    [self unregisterNotification];
    // 该conversation dealloc后，继续相应unreadCount 变化回调
    _conversation.enableUnreadMessagesCountEvent = YES;
    // 设置当前conversation的所有message为已读
    [_conversation markMessagesAsRead:YES];
}


#pragma mark - IM SDK actions
-(void)sendTextMessage:(NSString *)textMessage{
    EMMessage *tempMessage = [ChatSendHelper
                              sendTextMessageWithString:textMessage
                              toUsername:_conversation.chatter];
    [self addChatDataToMessage:tempMessage];
}


// 重发
-(void)retrySendMessage{
    
}

-(void)addChatDataToMessage:(EMMessage *)message{
    NSArray *messages = [self addChatToMessage:message];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i=0; i<messages.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath
                                  indexPathForRow:_messages.count
                                  inSection:0];
        [_messages addObject:[messages objectAtIndex:i]];
        [indexPaths addObject: indexPath];
    }
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    [self performSelector:@selector(scrollViewToArea:)
               withObject:@YES
               afterDelay:0.1];
}

-(void)scrollViewToArea:(BOOL)animated{
    if (_messages.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath
                                  indexPathForRow:_messages.count-1
                                  inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}

// toolBar Done按钮按下后，调用
-(void)chatBarTextShouldReturn{
    if (_chatBar.textView.text.length > 0) {
        [self sendTextMessage:_chatBar.textView.text];
    }
}
#pragma mark - IChatManagerDelegate

-(void)didSendMessage:(EMMessage *)message
                error:(EMError *)error{
    NSIndexPath *indexPath = nil;
    for (int i = 0; i < _messages.count; i ++) {
        if ([[_messages objectAtIndex:i] isKindOfClass:[ChatCellModel class]]) {
            EMMessage *currMsg = [_messages objectAtIndex:i];
            if ([message.messageId isEqualToString:currMsg.messageId]) {
                ChatCellModel *cellModel = [ChatCellModelManager
                                            modelWithMessage:message];
                [_messages replaceObjectAtIndex:i withObject:cellModel];
                indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                break;
            }
        }
    }
    if (indexPath) {
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }
}

-(void)didReceiveMessage:(EMMessage *)message {
    if ([message.conversation.chatter isEqualToString:_conversation.chatter]) {
        [self addChatDataToMessage:message];
    }
}

-(void)registerNotification{
    [self unregisterNotification];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotification{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}
@end
