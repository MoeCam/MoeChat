//
//  EMChatCellBubble.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "EMChatCellBubble.h"

@interface EMChatCellBubble (){
    UIImageView *_bubbleImageView;
}

@end

@implementation EMChatCellBubble

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_bubbleImageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
 
    NSInteger leftCapWidth = 0;
    NSInteger topCapHeight = 0;
    if (self.model.isLeft) {
        [_bubbleImageView setImage: [UIImage imageNamed:CHATCELL_BUBBLE_LEFT_IMAGE]];
        [_bubbleImageView setHighlightedImage: [UIImage imageNamed:CHATCELL_BUBBLE_LEFT_HIGHLIGHT_IMAGE]];
        leftCapWidth = CHATCELL_BUBBLE_LEFT_LEFT_CAP_WIDTH;
        topCapHeight = CHATCELL_BUBBLE_LEFT_TOP_CAP_HEIGHT;
    }else{
        [_bubbleImageView setImage: [UIImage imageNamed:CHATCELL_BUBBLE_RIGHT_IMAGE]];
        [_bubbleImageView setHighlightedImage: [UIImage imageNamed:CHATCELL_BUBBLE_RIGHT_HIGHLIGHT_IMAGE]];
        leftCapWidth = CHATCELL_BUBBLE_RIGHT_LEFT_CAP_WIDTH;
        topCapHeight = CHATCELL_BUBBLE_RIGHT_TOP_CAP_HEIGHT;
    }
    
    // 设置拉伸
    _bubbleImageView.image = [_bubbleImageView.image
                              stretchableImageWithLeftCapWidth:leftCapWidth
                              topCapHeight:topCapHeight];
    
    _bubbleImageView.frame = self.bounds;
}

-(void)setModel:(EMChatCellBubbleModel *)model{
    _model = model;
}

+(CGFloat)heightForChatModel:(EMChatCellBubbleModel *)model{
    return CHATCELL_HEAD_SIZE + CHATCELL_HEAD_X_SPACING * 2;
}

@end
