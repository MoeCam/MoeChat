//
//  ChatGroupDetailViewController.m
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-31.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "ChatGroupDetailViewController.h"

#import "ContactSelectionViewController.h"

#pragma mark - ChatGroupContactView

@implementation ChatGroupContactView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) - 5, 3, 15, 15)];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setImage:[UIImage imageNamed:@"chatgroup_invitee_delete"] forState:UIControlStateNormal];
        _deleteButton.hidden = YES;
        [self addSubview:_deleteButton];
    }
    
    return self;
}

- (void)setEditing:(BOOL)editing
{
    if (_editing != editing) {
        _editing = editing;
        _deleteButton.hidden = !_editing;
    }
}

- (void)deleteAction
{
    if (_deleteContact) {
        _deleteContact(self.index);
    }
}

@end

#pragma mark - ChatGroupDetailViewController

#define kColOfRow 5
#define kContactSize 60

@interface ChatGroupDetailViewController ()

@property (nonatomic) GroupMemberType memberType;
@property (strong, nonatomic) EMGroup *chatGroup;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *addButton;

@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UIButton *clearButton;
@property (strong, nonatomic) UIButton *exitButton;
@property (strong, nonatomic) UIButton *dissolveButton;

@end

@implementation ChatGroupDetailViewController

- (instancetype)initWithGroup:(EMGroup *)chatGroup
{
    self = [super init];
    if (self) {
        // Custom initialization
        _chatGroup = chatGroup;
        _dataSource = [NSMutableArray array];
        
        _memberType = GroupMemberTypeNormal;
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
        for (NSString *str in _chatGroup.owners) {
            if ([str isEqualToString:loginUsername]) {
                _memberType = GroupMemberTypeOwner;
                break;
            }
        }
        
        if (_memberType == GroupMemberTypeNormal) {
            for (NSString *str in _chatGroup.admins) {
                if ([str isEqualToString:loginUsername]) {
                    _memberType = GroupMemberTypeAdmin;
                    break;
                }
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = self.footerView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, kContactSize)];
        _scrollView.tag = 0;
        
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kContactSize - 10, kContactSize - 10)];
        [_addButton setImage:[UIImage imageNamed:@"chatgroup_participant_add"] forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"chatgroup_participant_addHL"] forState:UIControlStateHighlighted];
        [_addButton addTarget:self action:@selector(addContact:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_addButton];
        
        if (_memberType != GroupMemberTypeNormal) {
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteContactBegin:)];
            longPress.minimumPressDuration = 0.5;
            [_scrollView addGestureRecognizer:longPress];
        }
    }
    
    return _scrollView;
}

- (UIButton *)clearButton
{
    if (_clearButton == nil) {
        _clearButton = [[UIButton alloc] init];
        [_clearButton setTitle:@"清空聊天记录" forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
        _clearButton.layer.borderWidth = 1.0;
        _clearButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _clearButton.layer.cornerRadius = 5.0;
    }
    
    return _clearButton;
}

- (UIButton *)dissolveButton
{
    if (_dissolveButton == nil) {
        _dissolveButton = [[UIButton alloc] init];
        [_dissolveButton setTitle:@"解散该群" forState:UIControlStateNormal];
        [_dissolveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dissolveButton addTarget:self action:@selector(dissolveAction) forControlEvents:UIControlEventTouchUpInside];
        _dissolveButton.layer.borderWidth = 1.0;
        _dissolveButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _dissolveButton.layer.cornerRadius = 5.0;
    }
    
    return _dissolveButton;
}

- (UIButton *)exitButton
{
    if (_exitButton == nil) {
        _exitButton = [[UIButton alloc] init];
        [_exitButton setTitle:@"退出该群" forState:UIControlStateNormal];
        [_exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_exitButton addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
        _exitButton.layer.borderWidth = 1.0;
        _exitButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _exitButton.layer.cornerRadius = 5.0;
    }
    
    return _exitButton;
}

- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 150)];
        
        self.clearButton.frame = CGRectMake(20, 40, _footerView.frame.size.width - 40, 35);
        [_footerView addSubview:self.clearButton];
        
        if (_memberType != GroupMemberTypeNormal) {
            self.dissolveButton.frame = CGRectMake(20, CGRectGetMaxY(self.clearButton.frame) + 20, _footerView.frame.size.width - 40, 35);
            [_footerView addSubview:self.dissolveButton];
        }
        else{
            self.exitButton.frame = CGRectMake(20, CGRectGetMaxY(self.clearButton.frame) + 20, _footerView.frame.size.width - 40, 35);
            [_footerView addSubview:self.exitButton];
        }
    }
    
    return _footerView;
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell.contentView addSubview:self.scrollView];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = self.scrollView.tag;
    if (row == 0) {
        return self.scrollView.frame.size.height + 10;
    }
    return row * kContactSize + 10;
}

#pragma mark - data

- (void)loadDataSource
{
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:_chatGroup.owners];
    [self.dataSource addObjectsFromArray:_chatGroup.admins];
    [self.dataSource addObjectsFromArray:_chatGroup.members];
    [self refreshScrollView];
}

- (void)refreshScrollView
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    int tmp = ([self.dataSource count] + 1) % kColOfRow;
    int row = ([self.dataSource count] + 1) / kColOfRow;
    row += tmp == 0 ? 0 : 1;
    self.scrollView.tag = row;
    self.scrollView.frame = CGRectMake(10, 20, self.tableView.frame.size.width - 20, row * kContactSize);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, row * kContactSize);
    
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    
    int i = 0;
    int j = 0;
    BOOL isEditing = self.addButton.hidden ? YES : NO;
    BOOL isEnd = NO;
    for (i = 0; i < row; i++) {
        for (j = 0; j < kColOfRow; j++) {
            NSInteger index = i * kColOfRow + j;
            if (index < [self.dataSource count]) {
                NSString *username = [self.dataSource objectAtIndex:index];
                ChatGroupContactView *contactView = [[ChatGroupContactView alloc] initWithFrame:CGRectMake(j * kContactSize, i * kContactSize, kContactSize, kContactSize)];
                contactView.index = i * kColOfRow + j;
                contactView.image = [UIImage imageNamed:@"chatListCellHead.png"];
                contactView.remark = username;
                if (![username isEqualToString:loginUsername]) {
                    contactView.editing = isEditing;
                }
                
                __weak ChatGroupDetailViewController *weakSelf = self;
                [contactView setDeleteContact:^(NSInteger index) {
                    [weakSelf showHudInView:weakSelf.view hint:@"正在删除成员..."];
                    EMError *error;
                    [_chatGroup kickOccupant:[weakSelf.dataSource objectAtIndex:index] error:&error];
                    [weakSelf hideHud];
                    if (!error) {
                        [weakSelf.dataSource removeObjectAtIndex:index];
                        [weakSelf refreshScrollView];
                    }
                    else{
                        [weakSelf showHint:@"删除成员失败"];
                    }
                    
//                    [[EaseMob sharedInstance].chatManager asyncRemoveOccupant:[weakSelf.dataSource objectAtIndex:index] fromGroup:_chatGroup.groupId];
//                    [weakSelf.dataSource removeObjectAtIndex:index];
//                    [weakSelf refreshScrollView];
                }];
                
                [self.scrollView addSubview:contactView];
            }
            else{
                if(_memberType != GroupMemberTypeNormal && index == self.dataSource.count)
                {
                    self.addButton.frame = CGRectMake(j * kContactSize + 5, i * kContactSize + 10, kContactSize - 10, kContactSize - 10);
                    [self.scrollView addSubview:self.addButton];
                }
                
                isEnd = YES;
                break;
            }
        }
        
        if (isEnd) {
            break;
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - action

- (void)tapView:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        if (self.addButton.hidden) {
            [self setScrollViewEditing:NO];
        }
    }
}

- (void)deleteContactBegin:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        BOOL isEdit = self.addButton.hidden ? NO : YES;
        [self setScrollViewEditing:isEdit];
    }
}

- (void)setScrollViewEditing:(BOOL)isEditing
{
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    
    for (ChatGroupContactView *contactView in self.scrollView.subviews)
    {
        if ([contactView isKindOfClass:[ChatGroupContactView class]]) {
            if ([contactView.remark isEqualToString:loginUsername]) {
                continue;
            }
            
            [contactView setEditing:isEditing];
        }
    }
    
    self.addButton.hidden = isEditing;
}

- (void)addContact:(id)sender
{
    ContactSelectionViewController *selectionController = [[ContactSelectionViewController alloc] initWithBlockSelectedUsernames:_chatGroup.occupants];
    [selectionController setSelectedContactsFinished:^(ContactSelectionViewController *viewController, NSArray *selectedContacts) {
        NSMutableArray *source = [NSMutableArray array];
        for (EMBuddy *buddy in selectedContacts) {
            [source addObject:buddy.username];
        }
        
        [[EaseMob sharedInstance].chatManager addOccupants:source toGroup:_chatGroup.groupId welcomeMessage:@""];
    }];
    [self.navigationController pushViewController:selectionController animated:YES];
}

//清空聊天记录
- (void)clearAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveAllMessages" object:_chatGroup.groupId];
}

//解散群组
- (void)dissolveAction
{
    [self showHudInView:self.view hint:@"解散群组"];
    EMError *error;
#warning [leaveGroup:error:]不会调用代理方法
    EMGroup *group = [[EaseMob sharedInstance].chatManager leaveGroup:_chatGroup.groupId error:&error];
    [self hideHud];
    if (error && !group) {
        [self showHint:@"解散群组失败"];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitGroupSuccess" object:_chatGroup];
    }
}

//退出群组
- (void)exitAction
{
    [self showHudInView:self.view hint:@"退出群组"];
    EMError *error;
#warning [destroyGroup:error:]不会调用代理方法
    EMGroup *group = [[EaseMob sharedInstance].chatManager leaveGroup:_chatGroup.groupId error:&error];
    [self hideHud];
    if (error && !group) {
        [self showHint:@"退出群组失败"];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitGroupSuccess" object:_chatGroup];
    }
}

@end
