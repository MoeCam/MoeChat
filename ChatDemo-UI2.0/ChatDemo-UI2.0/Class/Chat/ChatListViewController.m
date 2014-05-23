//
//  ChatListViewController.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "ChatListViewController.h"
#import "SRRefreshView.h"
#import "ChatListCell.h"
#import "QXSearchBar.h"

@interface ChatListViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,SRRefreshDelegate>{
    NSMutableArray  *_chatList;
    SRRefreshView   *_slimeView;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QXSearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

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
    self.title = @"会话";
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UITableView *)tableView{
    if (!_tableView) {
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
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView addSubview:_slimeView];
        _tableView.tableHeaderView = self.searchBar;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ChatListCell class]
           forCellReuseIdentifier:@"chatListCell"];
    }
    
    return _tableView;
}

- (QXSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[QXSearchBar alloc]
                      initWithFrame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        self.searchController = [[UISearchDisplayController alloc]
                                        initWithSearchBar:_searchBar
                                        contentsController:self];

        self.searchController.delegate = self;
    }
    
    return _searchBar;
}


#pragma mark - TableViewDelegate & TableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatListCell"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _chatList.count;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
@end
