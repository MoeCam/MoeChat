//
//  XDChatTimeCell.m
//  leCar
//
//  Created by dujiepeng on 14-2-25.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDChatTimeCell.h"

@implementation XDChatTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    self.backgroundColor = [UIColor clearColor];
    CGRect frame = CGRectMake(0, 10, 320, 20);
    self.textLabel.frame = frame;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}
@end
