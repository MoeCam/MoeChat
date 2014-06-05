//
//  ChatRoomDetailViewController.m
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-31.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "ChatRoomDetailViewController.h"

#import "ContactSelectionViewController.h"

#pragma mark - ChatRoomContactView

@implementation ChatRoomContactView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _editing = NO;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, frame.size.width - 10, frame.size.height - 10)];
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = 0.5;
//        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_imageView.frame) - 15, _imageView.frame.size.width, 15)];
        _nameLabel.clipsToBounds = YES;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:10.0];
        _nameLabel.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        _nameLabel.textColor = [UIColor whiteColor];
        [_imageView addSubview:_nameLabel];
        
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame) - 8, 3, 15, 15)];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setImage:[UIImage imageNamed:@"chatroom_invitee_delete"] forState:UIControlStateNormal];
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

- (void)setTitle:(NSString *)title
{
    _title = title;
    _nameLabel.text = title;
}

- (void)deleteAction
{
    if (_deleteContact) {
        _deleteContact(self.index);
    }
}

@end

#pragma mark - ChatRoomDetailViewController

#define kColOfRow 5
#define kContactSize 60

@interface ChatRoomDetailViewController ()

@property (nonatomic) BOOL isAdmin;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *addButton;

@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UIButton *clearButton;
@property (strong, nonatomic) UIButton *exitButton;
@property (strong, nonatomic) UIButton *dissolveButton;

@end

@implementation ChatRoomDetailViewController

- (instancetype)initWithAdmin:(BOOL)isAdmin
{
    self = [super init];
    if (self) {
        // Custom initialization
        _isAdmin = isAdmin;
        _dataSource = [NSMutableArray array];
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
        [_addButton setImage:[UIImage imageNamed:@"chatroom_participant_add"] forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"chatroom_participant_addHL"] forState:UIControlStateHighlighted];
        [_addButton addTarget:self action:@selector(addContact:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_addButton];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteContactBegin:)];
        longPress.minimumPressDuration = 0.5;
        [_scrollView addGestureRecognizer:longPress];
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
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 130)];
        
        self.clearButton.frame = CGRectMake(20, 20, _footerView.frame.size.width - 40, 35);
        [_footerView addSubview:self.clearButton];
        
        if (_isAdmin) {
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
    [self.dataSource addObjectsFromArray:[[EaseMob sharedInstance].chatManager buddyList]];
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
                EMBuddy *buddy = [self.dataSource objectAtIndex:index];
                ChatRoomContactView *contactView = [[ChatRoomContactView alloc] initWithFrame:CGRectMake(j * kContactSize, i * kContactSize, kContactSize, kContactSize)];
                contactView.index = i * kColOfRow + j;
                contactView.imageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
                contactView.title = buddy.username;
                if (![buddy.username isEqualToString:loginUsername]) {
                    contactView.editing = isEditing;
                }
                
                [contactView setDeleteContact:^(NSInteger index) {
                    //to do 删除群组成员
                    [self.dataSource removeObjectAtIndex:index];
                    [self refreshScrollView];
                }];
                
                [self.scrollView addSubview:contactView];
            }
            else{
                if(index == self.dataSource.count)
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
    
    for (ChatRoomContactView *contactView in self.scrollView.subviews)
    {
        if ([contactView isKindOfClass:[ChatRoomContactView class]]) {
            if (isEditing && [contactView.title isEqualToString:loginUsername]) {
                break;
            }
            
            [contactView setEditing:isEditing];
        }
    }
    
    self.addButton.hidden = isEditing;
}

- (void)addContact:(id)sender
{
    ContactSelectionViewController *selectionController = [[ContactSelectionViewController alloc] init];
    [self.navigationController pushViewController:selectionController animated:YES];
}

- (void)clearAction
{
    
}

- (void)dissolveAction
{
    
}

- (void)exitAction
{
    
}

@end
