//
//  MessageViewController.m
//  ChatDemo
//
//  Created by xieyajie on 14-4-29.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import "MessageViewController.h"

#import "EMChatToolBar.h"
#import "EMChatBarMoreView.h"
#import "EMRecordView.h"
#import "EMFaceView.h"
#import "EMMenuItem.h"
#import "EMChatViewCell.h"
#import "EMChatTimeCell.h"
#import "EMChatSendHelper.h"
#import "EMMessageManager.h"
#import "EMMessageModelManager.h"
#import "SendLocationViewController.h"
#import "AYZChatBroadcastManager.h"
#import "NSDate+Category.h"

@interface MessageViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, EMChatToolBarDelegate, EMChatBarMoreViewDelegate, EMRecordDelegate, EMFaceDelegate, LocationDelegate, AYZMessageProtocol>

@property (strong, nonatomic) NSMutableArray *dataSource;//tableView数据源
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) EMChatToolBar *chatBar;//底部操作栏
@property (strong, nonatomic) EMFaceView *faceView;//表情页面
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic) EMMessageManager *messageReadManager;//message阅读的管理者
@property (strong, nonatomic) EMConversation *conversation;//会话管理者
@property (strong, nonatomic) NSDate *chatTagDate;

@end

@implementation MessageViewController

- (id)initWithStyle:(UITableViewStyle)style talkerUserName:(NSString *)talker isChatroom:(BOOL)isChatroom
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        talker = talker;
        
        //根据接收者的username获取当前会话的管理者
        _conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:talker];
        
        //通过会话管理者获取已收发消息
        NSArray *chats = [_conversation loadNumbersOfMessages:5 before:[[NSDate date] timeIntervalSince1970] * 1000 + 100000];
        [self.dataSource addObjectsFromArray:[self sortChatSource:chats]];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.conversation.chatter;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
#warning 以下一行代码是将self注册为AYZChatBroadcastManager的代理之一，AYZChatBroadcastManager接收由XMPP发出的所有广播，然后进行相应判断，通知给代理群组中相同会话的代理。代理必须符合AYZChatProtocol协议
    [[AYZChatBroadcastManager defaultManager] addDelegate:self chatConversation:_conversation];
    
    // 设置当前conversation 接收到message不再回调didUnreadMessagesCountChanged;
    _conversation.enableUnreadMessagesCountEvent = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
    
    CGFloat height = [[UIScreen mainScreen] bounds].size.height - 20 - 44 - self.chatBar.frame.size.height;
    [self.view addSubview:self.tableView];
    CGRect rect = self.tableView.frame;
    rect.size.height = height;
    self.tableView.frame = rect;
    [self.view addSubview:self.chatBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[EaseMob sharedInstance].chatManager stopPlayingAudio];
}

- (void)dealloc
{
#warning 以下一行，与[[AYZChatBroadcastManager defaultManager] addDelegate:chatConversation:]配套使用
    [[AYZChatBroadcastManager defaultManager] removeDelegate:self];
    
    // 该conversation dealloc后，继续相应unreadCount 变化回调
    _conversation.enableUnreadMessagesCountEvent = YES;
    // 设置当前conversation的所有message为已读
    [_conversation markMessagesAsRead:YES];
}

#pragma mark - getter

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        lpgr.minimumPressDuration = .5;
        [_tableView addGestureRecognizer:lpgr];
    }
    
    return _tableView;
}

- (EMChatToolBar *)chatBar
{
    if (_chatBar == nil) {
        _chatBar = [[EMChatToolBar alloc] initWithViewController:self];
        _chatBar.backgroundColor = [UIColor blackColor];
    }
    
    return _chatBar;
}

- (EMFaceView *)faceView
{
    if (_faceView == nil) {
        _faceView = [[EMFaceView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        _faceView.delegate = self;
    }
    
    return _faceView;
}

- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    return _imagePicker;
}

- (EMMessageManager *)messageReadManager
{
    if (_messageReadManager == nil) {
        _messageReadManager = [EMMessageManager defaultManager];
    }
    
    return _messageReadManager;
}

- (NSDate *)chatTagDate
{
    if (_chatTagDate == nil) {
        _chatTagDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:0];
    }
    
    return _chatTagDate;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        id obj = [self.dataSource objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[NSString class]]) {
            EMChatTimeCell *timeCell = (EMChatTimeCell *)[tableView dequeueReusableCellWithIdentifier:@"MessageCellTime"];
            if (timeCell == nil) {
                timeCell = [[EMChatTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCellTime"];
                timeCell.backgroundColor = [UIColor clearColor];
                timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            timeCell.textLabel.text = (NSString *)obj;
            
            return timeCell;
        }
        else{
            EMMessageModel *message = (EMMessageModel *)obj;
            NSString *cellIdentifier = [EMChatViewCell cellIdentifierForMessage:message];
            EMChatViewCell *cell = (EMChatViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[EMChatViewCell alloc] initWithMessage:message reuseIdentifier:cellIdentifier];
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.message = message;
            
            return cell;
        }
    }
    
    return nil;
}

#pragma mark - Table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *obj = [self.dataSource objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        return 40;
    }
    else{
        return [EMChatViewCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:(EMMessageModel *)obj];
    }
}

#pragma mark - GestureRecognizer

// 点击背景隐藏
-(void)keyBoardHidden
{
    [self.view endEditing:YES];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        id object = [self.dataSource objectAtIndex:indexPath.row];
        if ([object isKindOfClass:[EMMessageModel class]]) {
            EMChatViewCell *cell = (EMChatViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [self showMenuViewController:cell.bubbleView andIndexPath:indexPath];
        }
    }
}

#pragma mark - UIResponder actions

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    EMMessageModel *message = [userInfo objectForKey:KMESSAGEKEY];
    if ([eventName isEqualToString:kRouterEventChatHeadImageTapEventName]){
        [self avatarPressed:message];
    }
    else if ([eventName isEqualToString:kRouterEventAudioBubbleTapEventName]) {
        [self chatAudioCellBubblePressed:message];
    }
    else if ([eventName isEqualToString:kRouterEventImageBubbleTapEventName]){
        [self chatImageCellBubblePressed:message];
    }
    else if ([eventName isEqualToString:kRouterEventLocationBubbleTapEventName]){
        [self chatLocationCellBubblePressed:message];
    }
}

//点击头像
-(void)avatarPressed:(EMMessageModel *)message
{
    
}

// 语音的bubble被点击
-(void)chatAudioCellBubblePressed:(EMMessageModel *)message
{
    if (message.type == eMessageBodyType_Voice) {
        [self.messageReadManager startMessageAudio:message playBlock:^(BOOL playing) {
            if(playing){
                [[EaseMob sharedInstance].chatManager asyncPlayAudio:message.chatVoice completion:^(EMError *error) {
                    [self.messageReadManager stopMessageAudio];
                } onQueue:nil];
            }
            else{
                [[EaseMob sharedInstance].chatManager stopPlayingAudio];
            }
        }];
    }
}

// 位置的bubble被点击
-(void)chatLocationCellBubblePressed:(EMMessageModel *)message
{
    SendLocationViewController *locationVC = [SendLocationViewController readLocationLatitude:message.latitude longitude:message.longitude address:message.address];
    [self.navigationController pushViewController:locationVC animated:YES];
}

// 图片的bubble被点击
-(void)chatImageCellBubblePressed:(EMMessageModel *)message
{
    id object = message.isSender ? message.image : message.imageRemoteURL;
    [self.messageReadManager showBrowserWithImages:@[object]];
}

- (void)chatVideoCellBubblePressed:(EMMessageModel *)message
{
    
}

#pragma mark - AYZChatProtocol

-(void)didSendMessage:(EMMessage *)message error:(EMError *)error;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([_conversation.chatter isEqualToString:message.conversation.chatter])
        {
            NSIndexPath *indexPath = nil;
            for (int i = 0; i < self.dataSource.count; i ++) {
                id object = [self.dataSource objectAtIndex:i];
                if ([object isKindOfClass:[EMMessageModel class]]) {
                    EMMessage *currMsg = [self.dataSource objectAtIndex:i];
                    if ([message.messageId isEqualToString:currMsg.messageId]) {
                        EMMessageModel *cellModel = [EMMessageModelManager modelWithMessage:message];
                        
                        [self.dataSource replaceObjectAtIndex:i withObject:cellModel];
                        indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        break;
                    }
                }
            }
            
            if (indexPath) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView beginUpdates];
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [self.tableView endUpdates];
                });
            }
        }
    });
}

-(void)didReceiveMessage:(EMMessage *)message
{
    if ([_conversation.chatter isEqualToString:message.conversation.chatter]) {
        [self addChatDataToMessage:message];
    }
}

#pragma mark - EMChatBarMoreViewDelegate

- (void)moreViewPhotoAction:(EMChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden];
    
    // 弹出照片选择
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
}

- (void)moreViewFaceAction:(EMChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden];
    //切换到文字输入状态
    [self.chatBar switchToText];
    
    [self.chatBar decideInputView:self.faceView];
}

- (void)moreViewLocationAction:(EMChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden];
    
    SendLocationViewController *sendVC = [SendLocationViewController sendLocation];
    sendVC.delegate = self;
    [self.navigationController pushViewController:sendVC animated:YES];
}

#pragma mark - LocationDelegate

-(void)sendLocationLatitude:(double)latitude longitude:(double)longitude andAddress:(NSString *)address{
    
    EMMessage *tempMessage = [EMChatSendHelper sendLocationLatitude:latitude longitude:longitude address:address toUsername:_conversation.chatter];
    [self addChatDataToMessage:tempMessage];
}

#pragma mark - EMFaceDelegate

-(void)selectedFacialView:(NSString *)str isDelete:(BOOL)isDelete
{
    NSString *chatText = self.chatBar.textView.text;
    
    if (!isDelete && str.length > 0) {
        self.chatBar.textView.text = [NSString stringWithFormat:@"%@%@",chatText,str];
    }
    else {
        if (chatText.length >= 2)
        {
            NSString *subStr = [chatText substringFromIndex:chatText.length-2];
            if ([self.faceView stringIsFace:subStr]) {
                self.chatBar.textView.text = [chatText substringToIndex:chatText.length-2];
                
                return;
            }
        }
        
        if (chatText.length > 0) {
            self.chatBar.textView.text = [chatText substringToIndex:chatText.length-1];
        }
    }
}

- (void)faceViewSwitchToText
{
    //切换到文字输入状态
    [self.chatBar switchToText];
    [self.chatBar decideInputView:nil];
}

#pragma mark - ChatToolBarDelegate

// 传入需要显示的moreView（如果没有，传nil）
-(UIView *)chatBarMoreView
{
    EMChatBarMoreView *moreView = [[EMChatBarMoreView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    moreView.backgroundColor = [UIColor lightGrayColor];
    moreView.delegate = self;
    return moreView;
}

// 传入用于显示语音时动画的View（如果没有，传nil）
-(UIView *)chatBarRecordView
{
    EMRecordView *recordView = [[EMRecordView alloc] initWithFrame:CGRectMake(90, 130, 140, 140)];
    recordView.delegate = self;
    return recordView;
}

// 传入对应调整的tableView（如果没有，传nil）
-(UITableView *)chatBarTableView
{
    return self.tableView;
}

-(void)chatBarTextReturn:(NSString *)string
{
    if (string && string.length > 0) {
        [self sendTextMessage:string];
    }
}

// 录音按钮按下
-(void)recordButtonTouchDown:(UIView *)recordView
{
    // todo by du. 录音开始
    EMRecordView *record = (EMRecordView *)recordView;
    [record recordButtonTouchDown];
    [self.view bringSubviewToFront:recordView];
    EMError *error = nil;
    [[EaseMob sharedInstance].chatManager startRecordingAudioWithError:&error];
    if (error) {
        NSLog(@"开始录音失败");
    }
}

// 手指在录音按钮内部时离开
-(void)recordButtonTouchUpInside:(UIView *)recordView
{
    EMRecordView *record = (EMRecordView *)recordView;
    [record recordButtonTouchUpInside];
    
    [[EaseMob sharedInstance].chatManager
     asyncStopRecordingAudioWithCompletion:^(EMChatVoice *voice, EMError *error){
         if (!error) {
             [self sendAudioMessage:voice];
         }else{
             NSLog(@"结束录音失败");
         }
         
     } onQueue:nil];
    
}

// 手指在录音按钮外部时离开
-(void)recordButtonTouchUpOutside:(UIView *)recordView
{
    EMRecordView *record = (EMRecordView *)recordView;
    [record recordButtonTouchUpOutside];
    
    [[EaseMob sharedInstance].chatManager
     asyncCancelRecordingAudioWithCompletion:^(EMChatVoice *voice, EMError *error){
         
     } onQueue:nil];
}

// 手指移动到录音按钮内部
-(void)recordButtonDragInside:(UIView *)recordView{
    // 需要切换recordView显示状态
    EMRecordView *record = (EMRecordView *)recordView;
    [record recordButtonDragInside];
}

// 手指移动到录音按钮外部
-(void)recordButtonDragOutside:(UIView *)recordView
{
    // 需要切换recordView显示状态
    EMRecordView *record = (EMRecordView *)recordView;
    [record recordButtonDragOutside];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
    [self sendImageMessage:orgImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - MenuItem actions

- (void)handleCopyCell:(id)sender
{
    // todo by du. 复制
}

- (void)handleDeleteCell:(id)sender{
    UIMenuController *menuController = (UIMenuController *)sender;
    EMMenuItem *item = menuController.menuItems.lastObject;
    NSMutableArray *needDeleteIndexPaths = [[NSMutableArray alloc] initWithCapacity:0];
    if (item.indexPath.row > 0) {
        EMMessageModel * model = [self.dataSource objectAtIndex:item.indexPath.row];
        [_conversation removeMessage:model.messageId];
        
        [self.dataSource removeObject:model];
        if ([[self.dataSource objectAtIndex:item.indexPath.row - 1] isKindOfClass:[NSString class]]) {
            [self.dataSource removeObjectAtIndex:item.indexPath.row - 1];
            NSIndexPath *dateIndexPath = [NSIndexPath indexPathForRow:item.indexPath.row - 1 inSection:item.indexPath.section];
            [needDeleteIndexPaths addObject:dateIndexPath];
        }
        [needDeleteIndexPaths addObject:item.indexPath];
        
        [self.tableView deleteRowsAtIndexPaths:needDeleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - private

- (NSArray *)sortChatSource:(NSArray *)array
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if (array && [array count] > 0) {
        
        for (EMMessage *message in array) {
            NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
            NSTimeInterval tempDate = [createDate timeIntervalSinceDate:self.chatTagDate];
            if (tempDate > 60 || tempDate < -60 || tempDate == 0) {
                [resultArray addObject:[createDate formattedTime]];
                self.chatTagDate = createDate;
            }
            [resultArray addObject:[EMMessageModelManager modelWithMessage:message]];
        }
    }
    
    return resultArray;
}

-(NSMutableArray *)addChatToMessage:(EMMessage *)message
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
    NSTimeInterval tempDate = [createDate timeIntervalSinceDate:self.chatTagDate];
    if (tempDate > 60 || tempDate < -60 || tempDate == 0) {
        [ret addObject:[createDate formattedTime]];
        self.chatTagDate = createDate;
    }
    
    [ret addObject:[EMMessageModelManager modelWithMessage:message]];
    
    return ret;
}

-(void)addChatDataToMessage:(EMMessage *)message
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *messages = [self addChatToMessage:message];
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < messages.count; i++) {
            [self.dataSource addObject:[messages objectAtIndex:i]];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.dataSource.count - 1) inSection:0];
            [indexPaths addObject:indexPath];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            
            [self performSelector:@selector(scrollViewToBottom:) withObject:nil afterDelay:0.1];
        });
    });
}

- (void)scrollViewToBottom:(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.dataSource.count - 1) inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

- (void)showMenuViewController:(UIView*)showInView andIndexPath:(NSIndexPath *)indexPath
{
    [showInView becomeFirstResponder];
    
    EMMenuItem *copy = [[EMMenuItem alloc] initWithTitle:@"复制" action:@selector(handleCopyCell:)];
    copy.indexPath = indexPath;
    EMMenuItem *delete = [[EMMenuItem alloc] initWithTitle:@"删除" action:@selector(handleDeleteCell:)];
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

#pragma mark - send message

-(void)sendTextMessage:(NSString *)textMessage
{
    EMMessage *tempMessage = [EMChatSendHelper sendTextMessageWithString:textMessage toUsername:_conversation.chatter];
    [self addChatDataToMessage:tempMessage];
}

-(void)sendImageMessage:(UIImage *)imageMessage
{
    EMMessage *tempMessage = [EMChatSendHelper sendImageMessageWithImage:imageMessage toUsername:_conversation.chatter];
    [self addChatDataToMessage:tempMessage];
}

-(void)sendLocationMessage:(CLLocation *)locationMessage
{
    EMMessage *message = [EMChatSendHelper sendLocationLatitude:13.0 longitude:6.1234 address:@"北京市海淀区" toUsername:_conversation.chatter];
    [self addChatDataToMessage:message];
}

-(void)sendAudioMessage:(EMChatVoice *)voice
{
    EMMessage *tempMessage = [EMChatSendHelper sendVoice:voice toUsername:_conversation.chatter];
    [self addChatDataToMessage:tempMessage];
}


@end
