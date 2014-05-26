//
//  EMChatCellLocationBubble.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "EMChatCellLocationBubble.h"

@interface EMChatCellLocationBubble (){
    UIImageView *_chatImage;
}

@end

@implementation EMChatCellLocationBubble

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
    _chatImage.frame = CGRectMake(0, 0, IMAGE_MAX_SIZE
                                  , IMAGE_MAX_SIZE);
    [_chatImage setImage:[UIImage imageNamed:LOCATION_DEFAULT_IMAGE]];
}

- (CGSize)sizeThatFits:(CGSize)size{
    [super sizeThatFits:size];
    return CGSizeMake(IMAGE_MAX_SIZE + CHATCELL_BUBBLE_PADDING*2 + CHATCELL_BUBBLE_PADDING,
                      2*CHATCELL_BUBBLE_PADDING + IMAGE_MAX_SIZE);
}

+(CGFloat)heightForChatModel:(EMChatCellBubbleModel *)model;{
    [super heightForChatModel:model];
    return IMAGE_MAX_SIZE;
}

@end
