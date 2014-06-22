/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

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
