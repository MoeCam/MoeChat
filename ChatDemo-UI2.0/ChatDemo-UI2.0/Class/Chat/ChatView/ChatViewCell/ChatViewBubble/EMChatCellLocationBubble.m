//
//  EMChatCellLocationBubble.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "EMChatCellLocationBubble.h"

@interface EMChatCellLocationBubble (){
    UIImageView         *_chatImage;
    UILabel             *_addressLabel;
}

@end

@implementation EMChatCellLocationBubble

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _chatImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMAGE_MAX_SIZE,
                                                                   IMAGE_MAX_SIZE)];
        _chatImage.userInteractionEnabled = NO;
        _chatImage.multipleTouchEnabled = NO;
        [self addSubview:_chatImage];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LOCATION_ADDRESS_WIDTH,
                                                                  LOCATION_ADDRESS_HEIGHT)];
        _addressLabel.font = [UIFont systemFontOfSize:LOCATION_ADDRESS_FONTSIZE];
        _addressLabel.textColor = [UIColor whiteColor];
        _addressLabel.backgroundColor = [UIColor clearColor];
        [_addressLabel setNumberOfLines:0];
        [self addSubview:_addressLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = _chatImage.frame;
    if (self.model.isLeft) {
        frame.origin.x = CHATCELL_BUBBLE_WITHIN_PADDING + CHATCELL_BUBBLE_ARROW_WIDTH;
    }else{
        frame.origin.x = CHATCELL_BUBBLE_WITHIN_PADDING;
    }
    frame.origin.y = CHATCELL_BUBBLE_WITHIN_PADDING;
    _chatImage.frame = frame;
    [_chatImage setImage:[UIImage imageNamed:LOCATION_DEFAULT_IMAGE]];
    
    _addressLabel.text = self.model.address;
    [_addressLabel sizeToFit];
    frame = _addressLabel.frame;
    frame.origin.x = CHATCELL_BUBBLE_WITHIN_PADDING + LOCATION_ADDRESS_SPACING +CHATCELL_BUBBLE_ARROW_WIDTH;
    frame.origin.y = self.frame.size.height - _addressLabel.frame.size.height - CHATCELL_BUBBLE_WITHIN_PADDING - LOCATION_ADDRESS_SPACING;
    _addressLabel.frame = frame;
}

- (CGSize)sizeThatFits:(CGSize)size{
    [super sizeThatFits:size];
    return CGSizeMake(IMAGE_MAX_SIZE + CHATCELL_BUBBLE_WITHIN_PADDING*2 + CHATCELL_BUBBLE_ARROW_WIDTH,
                      2*CHATCELL_BUBBLE_WITHIN_PADDING + IMAGE_MAX_SIZE);
}

+(CGFloat)heightForChatModel:(EMChatCellBubbleModel *)model;{
    [super heightForChatModel:model];
    return IMAGE_MAX_SIZE;
}

@end
