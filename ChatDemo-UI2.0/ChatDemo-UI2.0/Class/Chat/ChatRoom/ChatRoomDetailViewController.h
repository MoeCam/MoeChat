//
//  ChatRoomDetailViewController.h
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-31.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EMRemarkImageView.h"

@interface ChatRoomContactView : EMRemarkImageView
{
    UIButton *_deleteButton;
}

@property (copy) void (^deleteContact)(NSInteger index);

@end

@interface ChatRoomDetailViewController : UITableViewController

- (instancetype)initWithGroup:(EMGroup *)chatGroup;

@end
