//
//  EMChatTimeCell.m
//  ChatDemo
//
//  Created by xieyajie on 14-2-25.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import "EMChatTimeCell.h"

@implementation EMChatTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = [UIColor grayColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
