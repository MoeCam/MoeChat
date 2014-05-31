//
//  ApplyFriendCell.h
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-31.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol ApplyFriendCellDelegate;

@interface ApplyFriendCell : BaseTableViewCell

@property (nonatomic) id<ApplyFriendCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UIButton *refuseButton;

@end

@protocol ApplyFriendCellDelegate <NSObject>

- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath;
- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath;

@end
