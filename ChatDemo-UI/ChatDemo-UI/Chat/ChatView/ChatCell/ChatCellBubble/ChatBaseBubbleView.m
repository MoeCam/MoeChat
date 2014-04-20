//
//  ChatBaseBubbleView.m
//  leCar
//
//  Created by dujiepeng on 14-3-7.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatBaseBubbleView.h"
#import "ChatCellModel.h"

@interface ChatBaseBubbleView (){

}

@end

@implementation ChatBaseBubbleView

-(id)init{
    if (self = [super init]) {
        _bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(bubbleViewPressed:)];
        [_bubbleImageView addGestureRecognizer:tap];
        _bubbleImageView.userInteractionEnabled = YES;
        _bubbleImageView.multipleTouchEnabled = YES;
        [self addSubview:_bubbleImageView];
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    BOOL isLeft = _model.isLeft;
    NSString *imageName = isLeft?BUBBLE_LEFT_IMAGE_NAME:BUBBLE_RIGHT_IMAGE_NAME;
    self.bubbleImageView.image = [UIImage imageNamed:imageName];
    
    NSInteger leftCapWidth = isLeft?BUBBLE_LEFT_LEFT_CAP_WIDTH:BUBBLE_RIGHT_LEFT_CAP_WIDTH;
    NSInteger topCapHeight =  isLeft?BUBBLE_LEFT_TOP_CAP_HEIGHT:BUBBLE_RIGHT_TOP_CAP_HEIGHT;
    // 设置拉伸
    _bubbleImageView.image = [_bubbleImageView.image
                             stretchableImageWithLeftCapWidth:leftCapWidth
                             topCapHeight:topCapHeight];
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}


+(CGFloat)heightForBubbleWithObject:(ChatCellModel *)object{
    return 30;
}
@end
