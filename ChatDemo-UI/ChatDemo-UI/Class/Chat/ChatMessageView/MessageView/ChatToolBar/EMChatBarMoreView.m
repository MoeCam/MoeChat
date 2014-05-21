//
//  EMChatBarMoreView.m
//  ChatDemo
//
//  Created by xieyajie on 14-4-15.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import "EMChatBarMoreView.h"

#define CHAT_BUTTON_SIZE 60
#define INSETS 8

@implementation EMChatBarMoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.backgroundColor = [UIColor clearColor];
    CGFloat insets = (self.frame.size.width - 4 * CHAT_BUTTON_SIZE) / 5;
    
    _faceButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _faceButton.frame = CGRectMake(insets, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE);
    [_faceButton setImage:[UIImage imageNamed:@"chatBar_more_face"] forState:UIControlStateNormal];
    [_faceButton setImage:[UIImage imageNamed:@"chatBar_more_faceSelected"] forState:UIControlStateHighlighted];
    [_faceButton addTarget:self action:@selector(faceAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_faceButton];
    
    _photoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_photoButton setFrame:CGRectMake(insets * 2 + CHAT_BUTTON_SIZE, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_photoButton setImage:[UIImage imageNamed:@"chatBar_more_photo"] forState:UIControlStateNormal];
    [_photoButton setImage:[UIImage imageNamed:@"chatBar_more_photoSelected"] forState:UIControlStateHighlighted];
    [_photoButton addTarget:self action:@selector(photoAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_photoButton];
    
    _locationButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_locationButton setFrame:CGRectMake(insets * 3 + CHAT_BUTTON_SIZE * 2, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_locationButton setImage:[UIImage imageNamed:@"chatBar_more_location"] forState:UIControlStateNormal];
    [_locationButton setImage:[UIImage imageNamed:@"chatBar_more_locationSelected"] forState:UIControlStateHighlighted];
    [_locationButton addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_locationButton];
    
    _takePicButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_takePicButton setFrame:CGRectMake(insets * 4 + CHAT_BUTTON_SIZE * 3, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_takePicButton setImage:[UIImage imageNamed:@"chatBar_more_photo"] forState:UIControlStateNormal];
    [_takePicButton setImage:[UIImage imageNamed:@"chatBar_more_photoSelected"] forState:UIControlStateHighlighted];
    [_takePicButton addTarget:self action:@selector(takePicAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_takePicButton];
}

#pragma mark - action

- (void)takePicAction{
    if(_delegate && [_delegate respondsToSelector:@selector(moreViewTakePicAction:)]){
        [_delegate moreViewTakePicAction:self];
    }
}

- (void)photoAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewPhotoAction:)]) {
        [_delegate moreViewPhotoAction:self];
    }
}

- (void)faceAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewFaceAction:)]) {
        [_delegate moreViewFaceAction:self];
    }
}

- (void)locationAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewLocationAction:)]) {
        [_delegate moreViewLocationAction:self];
    }
}

@end
