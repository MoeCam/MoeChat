//
//  ContactsViewController.h
//  ChatDemo-UI
//
//  Created by dujiepeng on 14-4-18.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *applysArray;

- (void)reloadApplyView;
- (void)reloadDataSource;

- (void)addFriendAction;

@end
