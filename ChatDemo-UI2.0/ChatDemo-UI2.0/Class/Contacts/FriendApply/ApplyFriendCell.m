//
//  ApplyFriendCell.m
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-31.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "ApplyFriendCell.h"

@implementation ApplyFriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 50, 30)];
        [_addButton setBackgroundColor:[UIColor colorWithRed:10 / 255.0 green:82 / 255.0 blue:104 / 255.0 alpha:1.0]];
        [_addButton setTitle:@"接受" forState:UIControlStateNormal];
        _addButton.clipsToBounds = YES;
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_addButton addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addButton];
        
        _refuseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 120, 0, 50, 30)];
        [_refuseButton setBackgroundColor:[UIColor lightGrayColor]];
        [_refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
        _refuseButton.clipsToBounds = YES;
        [_refuseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _refuseButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_refuseButton addTarget:self action:@selector(refuseFriend) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_refuseButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.textLabel.frame;
    rect.size.width -= 120;
    self.textLabel.frame = rect;
    
    rect = _addButton.frame;
    rect.origin.y = (self.frame.size.height - 30) / 2;
    _addButton.frame = rect;
    
    rect = _refuseButton.frame;
    rect.origin.y = (self.frame.size.height - 30) / 2;
    _refuseButton.frame = rect;
}

- (void)addFriend
{
    if(_delegate && [_delegate respondsToSelector:@selector(applyCellAddFriendAtIndexPath:)])
    {
        [_delegate applyCellAddFriendAtIndexPath:self.indexPath];
    }
}

- (void)refuseFriend
{
    if(_delegate && [_delegate respondsToSelector:@selector(applyCellRefuseFriendAtIndexPath:)])
    {
        [_delegate applyCellRefuseFriendAtIndexPath:self.indexPath];
    }
}

@end
