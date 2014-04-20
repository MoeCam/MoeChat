//
//  ChatRightTextCell.m
//  leCar
//
//  Created by dujiepeng on 14-3-6.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatRightTextCell.h"
#import "ChatTextBubbleView.h"
#import "ChatTextModel.h"

@interface ChatRightTextCell (){
    ChatTextBubbleView *_bubbleView;
}

@end

@implementation ChatRightTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bubbleView = [[ChatTextBubbleView alloc] init];
        [self.contentView addSubview:_bubbleView];
    }
    return self;
}

-(ChatBaseBubbleView *)bubbleView{
    return _bubbleView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_bubbleView sizeToFit];
    [_bubbleView setNeedsLayout];
    CGRect frame = _bubbleView.frame;
    frame.origin.x = self.headImageView.frame.origin.x - frame.size.width - HEAD_PADDING;
    frame.origin.y = self.headImageView.frame.origin.y;
    _bubbleView.frame = frame;
    
    frame = self.activityView.frame;
    frame.origin.x = _bubbleView.frame.origin.x - frame.size.width - ACTIVTIYVIEW_BUBBLE_PADDING;
    frame.origin.y = _bubbleView.center.y - frame.size.height / 2;
    self.activityView.frame = frame;
}

-(void)setModel:(ChatCellModel *)model{
    [super setModel:model];
    _bubbleView.model = self.model;
}

+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
         withObject:(ChatCellModel *)model{
    CGFloat superHeight = [super tableView:tableView heightForRowAtIndexPath:indexPath withObject:model];
    CGFloat bubbleHeight = [ChatTextBubbleView heightForBubbleWithObject:(ChatCellModel *)model];
    return MAX(superHeight, bubbleHeight + CELLPADDING * 2);
}

@end
