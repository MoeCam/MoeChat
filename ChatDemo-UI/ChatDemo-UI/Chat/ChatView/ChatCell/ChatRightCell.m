//
//  ChatRightCell.m
//  leCar
//
//  Created by dujiepeng on 14-3-5.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatRightCell.h"

@implementation ChatRightCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 发送进度显示view
        _activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SEND_STATUS_SIZE, SEND_STATUS_SIZE)];
        [self.contentView addSubview:_activityView];
        
        // 重发按钮
        _retryButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _retryButton.frame = CGRectMake(0, 0, SEND_STATUS_SIZE, SEND_STATUS_SIZE);
        [_activityView addSubview:_retryButton];
        [_retryButton addTarget:self action:@selector(retryButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
        
        // 菊花
        _activtiy = [[UIActivityIndicatorView alloc]
                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activtiy.backgroundColor = [UIColor clearColor];
        [_activityView addSubview:_activtiy];
        [_activityView setHidden:YES];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 设置头像位置
    CGRect frame = self.headImageView.frame;
    frame.origin.x = self.bounds.size.width - self.headImageView.frame.size.width - HEAD_PADDING;
    frame.origin.y = 0;
    self.headImageView.frame = frame;
    
    
    
    // 菊花状态 （因不确定菊花具体位置，要在子类中实现位置的修改）
    switch (((ChatCellModel *)self.model).sendStatus) {
        case eMessageDeliveryState_Delivering:
        {
            [_activityView setHidden:NO];
            [_retryButton setHidden:YES];
            [_activtiy setHidden:NO];
            [_activtiy startAnimating];
        }
            break;
        case eMessageDeliveryState_Delivered:
        {
            [_activtiy stopAnimating];
            [_activityView setHidden:YES];
            
        }
            break;
        case eMessageDeliveryState_Failure:
        {
            [_activityView setHidden:NO];
            [_activtiy stopAnimating];
            [_activtiy setHidden:YES];
            [_retryButton setHidden:NO];
        }
            break;
        default:
            break;
    }
}

// 重发按钮事件
-(void)retryButtonPressed:(UIButton *)sender{
    NSLog(@"retryButtonPressed---");
}

+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
         withObject:(ChatCellModel *)model{
    return MAX(HEAD_SIZE + HEAD_PADDING, SEND_STATUS_SIZE) + CELLPADDING;
}
@end
