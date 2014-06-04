//
//  ChatViewController.m
//  ChatDemo
//
//  Created by xieyajie on 14-4-29.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import "ChatViewController.h"

#import "SRRefreshView.h"
#import "DXChatBarMoreView.h"
#import "DXRecordView.h"
#import "DXFaceView.h"
#import "EMChatViewCell.h"
#import "EMChatTimeCell.h"
#import "EMChatSendHelper.h"
#import "EMMessageManager.h"
#import "EMMessageModelManager.h"
#import "SendLocationViewController.h"
#import "ChatRoomDetailViewController.h"

#import "NSDate+Category.h"
#import "DXMessageToolBar.h"

@interface ChatViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, SRRefreshDelegate, IChatManagerDelegate, DXChatBarMoreViewDelegate, DXMessageToolBarDelegate, LocationDelegate>
{
    UIMenuController *_menuController;
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    NSIndexPath *_longPressIndexPath;
    
    BOOL _isRecording;
    NSInteger _recordingCount;
}

@property (nonatomic) BOOL isChatRoom;

@property (strong, nonatomic) NSMutableArray *dataSource;//tableView数据源
@property (strong, nonatomic) SRRefreshView *slimeView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) DXMessageToolBar *chatToolBar;

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic) EMMessageManager *messageReadManager;//message阅读的管理者
@property (strong, nonatomic) EMConversation *conversation;//会话管理者
@property (strong, nonatomic) NSDate *chatTagDate;

@end

@implementation ChatViewController

- (instancetype)initWithChatter:(NSString *)chatter isChatroom:(BOOL)isChatroom
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        _isChatRoom = isChatroom;
        
        //根据接收者的username获取当前会话的管理者
        _conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:chatter];
        
        //通过会话管理者获取已收发消息
         NSArray *chats = [_conversation loadNumbersOfMessages:10 before:[_conversation latestMessage].timestamp + 1];
        [self.dataSource addObjectsFromArray:[self sortChatSource:chats]];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.conversation.chatter;
    self.view.backgroundColor = [UIColor lightGrayColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    [self setupBarButtonItem];
    
#warning 以下两行代码必须写，注册为SDK的ChatManager的delegate
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    //注册为SDK的ChatManager的delegate
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.slimeView];
    [self.view addSubview:self.chatToolBar];
    //将self注册为chatToolBar的moreView的代理
    if ([self.chatToolBar.moreView isKindOfClass:[DXChatBarMoreView class]]) {
        [(DXChatBarMoreView *)self.chatToolBar.moreView setDelegate:self];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
}

- (void)setupBarButtonItem
{
    if (_isChatRoom) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chatroomDetail"] style:UIBarButtonItemStylePlain target:self action:@selector(showRoomContact:)];
    }
    else{
        UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [clearButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(removeAllMessages:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self scrollViewToBottom:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 设置当前conversation的所有message为已读
    [_conversation markMessagesAsRead:YES];
    
    //停止音频播放及播放动画
    [[EaseMob sharedInstance].chatManager stopPlayingAudio];
    [self.messageReadManager stopMessageAudio];
    
    //判断当前会话是否为空，若为空则删除该会话
    EMMessage *message = [_conversation latestMessage];
    if (message == nil) {
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:_conversation.chatter deleteMessages:YES];
    }
}

- (void)dealloc
{
#warning 以下第一行代码必须写，将self从ChatManager的代理中移除
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

#pragma mark - getter

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (SRRefreshView *)slimeView
{
    if (_slimeView == nil) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
    }
    
    return _slimeView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.chatToolBar.frame.size.height) style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
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

- (DXMessageToolBar *)chatToolBar
{
    if (_chatToolBar == nil) {
        _chatToolBar = [[DXMessageToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - [DXMessageToolBar defaultHeight], self.view.frame.size.width, [DXMessageToolBar defaultHeight])];
        _chatToolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        _chatToolBar.delegate = self;
    }
    
    return _chatToolBar;
}

- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
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
//加载更多
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self loadMoreMessages];
    [_slimeView endRefresh];
}

#pragma mark - GestureRecognizer

// 点击背景隐藏
-(void)keyBoardHidden
{
    [self.chatToolBar endEditing:YES];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        id object = [self.dataSource objectAtIndex:indexPath.row];
        if ([object isKindOfClass:[EMMessageModel class]]) {
            EMChatViewCell *cell = (EMChatViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell becomeFirstResponder];
            _longPressIndexPath = indexPath;
            [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.message.type];
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
        [self.messageReadManager startMessageAudio:message
                                           chatter:_conversation.chatter
                                         playBlock:^(BOOL playing) {
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
    id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
    [self showHudInView:self.view hint:@"正在获取大图..."];
    [chatManager asyncFetchMessage:message.message progress:nil completion:^(EMMessage *aMessage, EMError *error) {
        [self hideHud];
        if (!error) {
            NSString *localPath = aMessage == nil ? message.localPath : [[aMessage.messageBodies firstObject] localPath];
            if (localPath && localPath.length > 0) {
                NSURL *url = [NSURL fileURLWithPath:localPath];
                [self.messageReadManager showBrowserWithImages:@[url]];
                return ;
            }
        }
        [self showHint:@"大图获取失败!"];
    } onQueue:nil];
}

- (void)chatVideoCellBubblePressed:(EMMessageModel *)message
{
    
}

#pragma mark - IChatManagerDelegate

-(void)didSendMessage:(EMMessage *)message error:(EMError *)error;
{
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
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }
    }
}

-(void)didReceiveMessage:(EMMessage *)message
{
    if ([_conversation.chatter isEqualToString:message.conversation.chatter]) {
        [self addChatDataToMessage:message];
    }
}

#pragma mark - EMChatBarMoreViewDelegate

- (void)moreViewPhotoAction:(DXChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden];
    
    // 弹出照片选择
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
}

- (void)moreViewTakePicAction:(DXChatBarMoreView *)moreView
{
    [self keyBoardHidden];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
}

- (void)moreViewLocationAction:(DXChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden];
    
    SendLocationViewController *sendVC = [SendLocationViewController sendLocation];
    sendVC.delegate = self;
    [self.navigationController pushViewController:sendVC animated:YES];
}

#pragma mark - LocationDelegate

-(void)sendLocationLatitude:(double)latitude
                  longitude:(double)longitude
                 andAddress:(NSString *)address{
    
    EMMessage *tempMessage = [EMChatSendHelper sendLocationLatitude:latitude
                                                          longitude:longitude
                                                            address:address
                                                         toUsername:_conversation.chatter
                                                  requireEncryption:YES];
    [self addChatDataToMessage:tempMessage];
}

#pragma mark - DXMessageToolBarDelegate
- (void)inputTextViewWillBeginEditing:(XHMessageTextView *)messageInputTextView{
    [_menuController setMenuItems:nil];
}

- (void)didChangeFrameToHeight:(CGFloat)toHeight
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.tableView.frame;
        rect.size.height = self.view.frame.size.height - toHeight;
        self.tableView.frame = rect;
    }];
    [self scrollViewToBottom:YES];
}

- (void)didSendText:(NSString *)text
{
    if (text && text.length > 0) {
        [self sendTextMessage:text];
    }
}

/**
 *  按下录音按钮开始录音
 */
- (void)didStartRecordingVoiceAction:(UIView *)recordView
{
    if (_isRecording) {
        ++_recordingCount;
        if (_recordingCount > 10)
        {
            _recordingCount = 0;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，已经戳漏了，随时崩溃给你看" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if (_recordingCount > 5) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，手别抖了，快被戳漏了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        return;
    }
    _isRecording = YES;
    
    DXRecordView *tmpView = (DXRecordView *)recordView;
    tmpView.center = self.view.center;
    [self.view addSubview:tmpView];
    [self.view bringSubviewToFront:recordView];
    
    EMError *error = nil;
    [[EaseMob sharedInstance].chatManager startRecordingAudioWithError:&error];
    if (error) {
        NSLog(@"开始录音失败");
    }
}

/**
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction:(UIView *)recordView
{
    DXRecordView *record = (DXRecordView *)recordView;
    [record recordButtonTouchUpOutside];
    
    [[EaseMob sharedInstance].chatManager
     asyncCancelRecordingAudioWithCompletion:^(EMChatVoice *voice, EMError *error){
         _isRecording = NO;
     } onQueue:nil];
}

/**
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction:(UIView *)recordView
{
    DXRecordView *record = (DXRecordView *)recordView;
    [record recordButtonTouchUpInside];
    
    [[EaseMob sharedInstance].chatManager
     asyncStopRecordingAudioWithCompletion:^(EMChatVoice *voice, EMError *error){
         _isRecording = NO;
         if (!error) {
             if (voice.duration <= 0) {
                 [self showHint:@"录音时间过短"];
             }
             else{
                 [self sendAudioMessage:voice];
             }
         }else{
             [self showHint:@"录音失败，请重新操作"];
         }
         
     } onQueue:nil];
}

/**
 *  当手指离开按钮的范围内时，主要为了通知外部的HUD
 */
- (void)didDragOutsideAction:(UIView *)recordView
{
    DXRecordView *record = (DXRecordView *)recordView;
    [record recordButtonDragOutside];
}
/**
 *  当手指再次进入按钮的范围内时，主要也是为了通知外部的HUD
 */
- (void)didDragInsideAction:(UIView *)recordView
{
    DXRecordView *record = (DXRecordView *)recordView;
    [record recordButtonDragInside];
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

- (void)copyMenuAction:(id)sender
{
    // todo by du. 复制
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (_longPressIndexPath.row > 0) {
        EMMessageModel *model = [self.dataSource objectAtIndex:_longPressIndexPath.row];
        pasteboard.string = model.content;
    }
    
    _longPressIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (_longPressIndexPath && _longPressIndexPath.row > 0) {
        EMMessageModel * message = [self.dataSource objectAtIndex:_longPressIndexPath.row];
        NSMutableArray *messages = [NSMutableArray arrayWithObjects:message, nil];
        [_conversation removeMessage:message.messageId];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:_longPressIndexPath, nil];;
        if (_longPressIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataSource objectAtIndex:(_longPressIndexPath.row - 1)];
            if (_longPressIndexPath.row + 1 < [self.dataSource count]) {
                nextMessage = [self.dataSource objectAtIndex:(_longPressIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [messages addObject:prevMessage];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(_longPressIndexPath.row - 1) inSection:0]];
            }
        }
        [self.dataSource removeObjectsInArray:messages];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    
    _longPressIndexPath = nil;
}

#pragma mark - private

- (void)loadMoreMessages
{
    NSInteger currentCount = [self.dataSource count];
    NSArray *chats = [_conversation loadNumbersOfMessages:(currentCount + 10) before:[_conversation latestMessage].timestamp + 1];
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:[self sortChatSource:chats]];
    [_tableView reloadData];
}

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
    NSArray *messages = [self addChatToMessage:message];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < messages.count; i++) {
        [self.dataSource addObject:[messages objectAtIndex:i]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.dataSource.count - 1) inSection:0];
        [indexPaths addObject:indexPath];
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    [self performSelector:@selector(scrollViewToBottom:) withObject:nil afterDelay:0.1];
}

- (void)scrollViewToBottom:(BOOL)animated
{
    if (self.dataSource.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath
                                  indexPathForRow:(self.dataSource.count - 1)
                                  inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}

- (void)showRoomContact:(id)sender
{
    [self.view endEditing:YES];
    ChatRoomDetailViewController *detailController = [[ChatRoomDetailViewController alloc] initWithAdmin:YES];
    detailController.title = @"测试";
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)removeAllMessages:(id)sender
{
    [WCAlertView showAlertWithTitle:@"提示"
                            message:@"请确认删除"
                 customizationBlock:^(WCAlertView *alertView) {
                     
                 } completionBlock:
     ^(NSUInteger buttonIndex, WCAlertView *alertView) {
         if (buttonIndex == 1) {
             if (_conversation.messages.count > 0) {
                 [_conversation loadAllMessages];
                 [_conversation removeAllMessages];
                 [_dataSource removeAllObjects];
                 [self.tableView reloadData];
             }
         }
     } cancelButtonTitle:@"取消"
                  otherButtonTitles:@"确定", nil];
}

- (void)showMenuViewController:(UIView *)showInView andIndexPath:(NSIndexPath *)indexPath messageType:(MessageBodyType)messageType
{
    if (_menuController == nil) {
        _menuController = [UIMenuController sharedMenuController];
    }
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyMenuAction:)];
    }
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMenuAction:)];
    }
    
    if (messageType == eMessageBodyType_Text) {
        [_menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem]];
    }
    else{
        [_menuController setMenuItems:@[_deleteMenuItem]];
    }
    
    [_menuController setTargetRect:showInView.frame inView:showInView.superview];
    [_menuController setMenuVisible:YES animated:YES];
}

#pragma mark - send message

-(void)sendTextMessage:(NSString *)textMessage
{
    EMMessage *tempMessage = [EMChatSendHelper sendTextMessageWithString:textMessage toUsername:_conversation.chatter requireEncryption:YES];
    [self addChatDataToMessage:tempMessage];
}

-(void)sendImageMessage:(UIImage *)imageMessage
{
    EMMessage *tempMessage = [EMChatSendHelper sendImageMessageWithImage:imageMessage toUsername:_conversation.chatter requireEncryption:YES];
    [self addChatDataToMessage:tempMessage];
}

-(void)sendLocationMessage:(CLLocation *)locationMessage
{
    EMMessage *message = [EMChatSendHelper sendLocationLatitude:13.0 longitude:6.1234 address:@"北京市海淀区" toUsername:_conversation.chatter requireEncryption:YES];
    [self addChatDataToMessage:message];
}

-(void)sendAudioMessage:(EMChatVoice *)voice
{
    EMMessage *tempMessage = [EMChatSendHelper sendVoice:voice toUsername:_conversation.chatter requireEncryption:YES];
    [self addChatDataToMessage:tempMessage];
}


@end
