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

@interface ChatListViewController ()<UITableViewDelegate,UITableViewDataSource,SRRefreshDelegate,UISearchBarDelegate>{
    NSMutableArray *_chatList;
}
@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (nonatomic, strong) UISearchBar           *searchBar;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
        _searchBar = [[UISearchBar alloc]
                      initWithFrame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
        
        for (UIView *subView in _searchBar.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subView removeFromSuperview];
            }
            
            if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                UITextField *textField = (UITextField *)subView;
                [textField setBorderStyle:UITextBorderStyleNone];
                textField.background = nil;
                textField.frame = CGRectMake(8, 8, _searchBar.bounds.size.width - 2* 8,
                                             _searchBar.bounds.size.height - 2* 8);
                textField.layer.cornerRadius = 6;
                
                textField.clipsToBounds = YES;
                textField.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    
    return _searchBar;
}


#pragma mark - TableViewDelegate & TableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatCell"];
    if (!cell) {
        cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:@"chatCell"];
    }

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _chatList.count;
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
    [_slimeView endRefresh];
}
@end
