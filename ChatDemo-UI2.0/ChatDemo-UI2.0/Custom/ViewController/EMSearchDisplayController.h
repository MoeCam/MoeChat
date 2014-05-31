//
//  EMSearchDisplayController.h
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-30.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseTableViewCell.h"

@interface EMSearchDisplayController : UISearchDisplayController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *resultsSource;

@property (copy) UITableViewCell * (^cellForRowAtIndexPathCompletion)(UITableView *tableView, NSIndexPath *indexPath);
@property (copy) CGFloat (^heightForRowAtIndexPathCompletion)(UITableView *tableView, NSIndexPath *indexPath);
@property (copy) void (^didSelectRowAtIndexPathCompletion)(UITableView *tableView, NSIndexPath *indexPath);

@end
