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
    GroupOccupantTypeOwner,//所有者
    GroupOccupantTypeAdmin,//管理员
    GroupOccupantTypeMember,//成员
    GroupOccupantTypeVisitor,//游客
}GroupOccupantType;

@interface ChatGroupDetailViewController : UITableViewController<IChatManagerDelegate>

- (instancetype)initWithGroup:(EMGroup *)chatGroup;

@end
