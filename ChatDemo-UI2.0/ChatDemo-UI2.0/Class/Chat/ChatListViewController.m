//
//  ChatListViewController.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-24.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "ChatListViewController.h"
#import "SRRefreshView.h"
#import "ChatListCell.h"
#import "EMSearchBar.h"
#import "NSDate+Category.h"
#import "ChatViewController.h"

@interface ChatListViewController ()<UITableViewDelegate,UITableViewDataSource,SRRefreshDelegate,UISearchBarDelegate,IChatManagerDelegate>{
    NSMutableArray  *_chatList;
}
@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (nonatomic, strong) EMSearchBar           *searchBar;
@property (nonatomic, strong) SRRefreshView         *slimeView;
@end

@implementation ChatListViewController

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
    [self.tableView addSubview:self.slimeView];
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ChatListCell class] forCellReuseIdentifier:@"chatListCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refresh];
    [self registerNotifications];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
}

- (SRRefreshView *)slimeView{
    if (!_slimeView) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
        _slimeView.backgroundColor = [UIColor whiteColor];
    }
    
    return _slimeView;
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[EMSearchBar alloc]
                      initWithFrame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
}

- (NSMutableArray *)loadDataSource{
    NSMutableArray *ret = nil;
    NSArray *conversationList = [[EaseMob sharedInstance].chatManager conversations];
    NSArray* sorte = [conversationList sortedArrayUsingComparator:
           ^(EMConversation *obj1, EMConversation* obj2){
               EMMessage *message1 = [obj1 latestMessage];
               EMMessage *message2 = [obj1 latestMessage];
               if(message1.timestamp > message2.timestamp) {
                   return(NSComparisonResult)NSOrderedAscending;
               }else {
                   return(NSComparisonResult)NSOrderedDescending;
               }
           }];
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    return ret;
}

-(void)refresh{
    _chatList = [self loadDataSource];
    [self.tableView reloadData];
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
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
            case eMessageBodyType_Location:
                ret = @"[位置]";
            default:
                break;
        }
    }
    
    return ret;
}

#pragma mark - TableViewDelegate & TableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatListCell"];

    EMConversation *conversation = [_chatList objectAtIndex:indexPath.row];
    cell.name = conversation.chatter;
    cell.detailMsg = [self subTitleMessageByConversation:conversation];
    cell.time = [self lastMessageTimeByConversation:conversation];
    cell.unreadCount = [self unreadMessageCountByConversation:conversation];
    cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
    if (indexPath.row % 2 == 1) {
        cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _chatList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EMConversation *conversation = [_chatList objectAtIndex:indexPath.row];
    ChatViewController *chatVC = [[ChatViewController alloc]
                                  initWithChatter:conversation.chatter
                                  andIsChatRoom:NO];
    
    [self.navigationController pushViewController:chatVC animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMConversation *converation = [_chatList objectAtIndex:indexPath.row];
        [[EaseMob sharedInstance].chatManager
         removeConversationByChatter:converation.chatter
         deleteMessages:NO];
        [_chatList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - SearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"search button clicked");
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
    [self refresh];
    [_slimeView endRefresh];
}

#pragma mark - IChatMangerDelegate
-(void)didUnreadMessagesCountChanged{
    [self refresh];
}


#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

@end
