//
//  BaseCell.m
//  leCar
//
//  Created by dujiepeng on 14-3-5.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "BaseCell.h"

@interface BaseCell ()

@end

@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 头像的ImageView
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(headImagePressed:)];
        _headImageView = [[UIImageView alloc]
                          initWithFrame:CGRectMake(0, 0, HEAD_SIZE, HEAD_SIZE)];
        [_headImageView addGestureRecognizer:tap];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.multipleTouchEnabled = YES;
        [self.contentView addSubview:_headImageView];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UIImage *placeholderImage = [UIImage imageNamed:@"account_defaultHead.png"];
    [self.headImageView setImage:placeholderImage];
}


-(void)headImagePressed:(id)sender{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    [userInfo setObject:self.model forKey:@"ChatCellModel"];
}

+(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
         withObject:(ChatCellModel *)model{
    return HEAD_SIZE;
}

@end
