//
//  AddFriendCell.m
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-27.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "AddFriendCell.h"

@implementation AddFriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _addLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 50, 30)];
        _addLabel.backgroundColor = [UIColor clearColor];
        _addLabel.textAlignment = NSTextAlignmentCenter;
        _addLabel.text = @"添加";
        _addLabel.textColor = [UIColor blackColor];
        _addLabel.font = [UIFont systemFontOfSize:14.0];
        _addLabel.layer.cornerRadius = 5.0;
        _addLabel.layer.borderWidth = 1;
        _addLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self.contentView addSubview:_addLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.textLabel.frame;
    rect.origin.x = CGRectGetMaxX(self.imageView.frame) + 10;
    rect.size.width -= 70;
    self.textLabel.frame = rect;
    
    rect = _addLabel.frame;
    rect.origin.y = (self.frame.size.height - 30) / 2;
    _addLabel.frame = rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
