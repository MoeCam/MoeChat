//
//  EMChatImageBubble.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "EMChatCellImageBubble.h"


@interface EMChatCellImageBubble (){
    UIImageView *_chatImage;
}

@end

@implementation EMChatCellImageBubble

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _chatImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _chatImage.userInteractionEnabled = NO;
        _chatImage.multipleTouchEnabled = NO;
        [self addSubview:_chatImage];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    if (self.model.isLeft) {
        [_chatImage setImageWithURL:self.model.imageRemoteURL
                       placeholderImage:nil];// todo by du. 需要一张还没有下载好时，默认的图片
    }else{
        _chatImage.image = self.model.thumbnailImage;
    }
    
    CGRect frame = self.bounds;
    frame.size.width -= CHATCELL_BUBBLE_ARROW_WIDTH;
    frame = CGRectInset(frame, CHATCELL_BUBBLE_PADDING, CHATCELL_BUBBLE_PADDING);
    if (self.model.isLeft) {
        frame.origin.x = CHATCELL_BUBBLE_PADDING + CHATCELL_BUBBLE_ARROW_WIDTH;
    }else{
        frame.origin.x = CHATCELL_BUBBLE_ARROW_WIDTH;
    }
    
    frame.origin.y = CHATCELL_BUBBLE_PADDING;
    [_chatImage setFrame:frame];
}

- (CGSize)sizeThatFits:(CGSize)size{
    [super sizeThatFits:size];
 
    CGSize retSize = self.model.thumbnailImage.size;
    if (retSize.width > retSize.height) {
        CGFloat height = IMAGE_MAX_SIZE / retSize.width  *  retSize.height;
        retSize.height = height;
        retSize.width = IMAGE_MAX_SIZE;
    }else {
        CGFloat width = IMAGE_MAX_SIZE / retSize.height * retSize.width;
        retSize.width = width;
        retSize.height = IMAGE_MAX_SIZE;
    }
    
    return CGSizeMake(retSize.width + CHATCELL_BUBBLE_PADDING*2 + CHATCELL_BUBBLE_PADDING,
                      2*CHATCELL_BUBBLE_PADDING + retSize.height);
}

+(CGFloat)heightForChatModel:(EMChatCellBubbleModel *)model{
    [super heightForChatModel:model];
    return IMAGE_MAX_SIZE;
}

@end
