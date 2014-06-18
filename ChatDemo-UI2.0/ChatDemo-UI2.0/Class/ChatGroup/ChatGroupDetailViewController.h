//
//  ChatGroupDetailViewController.h
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-31.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EMRemarkImageView.h"

@interface ChatGroupContactView : EMRemarkImageView
{
    UIButton *_deleteButton;
}

@property (copy) void (^deleteContact)(NSInteger index);

@end

/**
 *  群组成员类型
 */
typedef enum{
    GroupMemberTypeOwner,//所有者
    GroupMemberTypeAdmin,//管理员
    GroupMemberTypeNormal,//普通
}GroupMemberType;

@interface ChatGroupDetailViewController : UITableViewController

- (instancetype)initWithGroup:(EMGroup *)chatGroup;

@end
