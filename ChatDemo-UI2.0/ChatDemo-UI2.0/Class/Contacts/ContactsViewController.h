//
//  ContactsViewController.h
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ContactsViewController : BaseViewController

@property (strong, nonatomic) NSMutableArray *applysArray;

//好友请求变化时，更新好友请求未处理的个数
- (void)reloadApplyView;

//好友个数变化时，重新获取数据
- (void)reloadDataSource;

//添加好友的操作被触发
- (void)addFriendAction;

@end
