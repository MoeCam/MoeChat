//
//  ChatLeftTextCell.m
//  leCar
//
//  Created by dujiepeng on 14-3-5.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatLeftTextCell.h"
#import "ChatTextBubbleView.h"
#import "ChatTextModel.h"

@interface ChatLeftTextCell (){
    ChatTextBubbleView *_bubbleView;
}

@end

@implementation ChatLeftTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bubbleView = [[ChatTextBubbleView alloc] init];
        [self.contentView addSubview:_bubbleView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_bubbleView sizeToFit];
    [_bubbleView setNeedsLayout];
    CGRect frame = _bubbleView.frame;
    frame.origin.x = HEAD_PADDING * 2 + HEAD_SIZE;
    frame.origin.y = self.nameLabelHeight;
    _bubbleView.frame = frame;
}

-(void)setModel:(ChatCellModel *)model{
    [super setModel:model];
    _bubbleView.model = model;
}


-(ChatBaseBubbleView *)bubbleView{
    return _bubbleView;
}

+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
         withObject:(ChatCellModel *)model{
    CGFloat superHeight = [super tableView:tableView heightForRowAtIndexPath:indexPath withObject:model];
    CGFloat bubbleHeight = [ChatTextBubbleView heightForBubbleWithObject:model];
    return MAX(HEAD_PADDING * 2 + HEAD_SIZE, superHeight + bubbleHeight) + CELLPADDING;
}


@end
