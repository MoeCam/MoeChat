//
//  BaseTableViewCell.m
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-24.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 1)];
        _bottomLineView.backgroundColor = RGBACOLOR(207, 210, 213, 0.7);
        [self.contentView addSubview:_bottomLineView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10, 8, 34, 34);
    
    CGRect rect = self.textLabel.frame;
    rect.origin.x = CGRectGetMaxX(self.imageView.frame) + 10;
    self.textLabel.frame = rect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
