//
//  FaceView.m
//  leCar
//
//  Created by dujiepeng on 14-2-27.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "FaceView.h"

@interface FaceView (){
    UIButton *_sendButton;
}

@end

@implementation FaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        FacialView *fview=[[FacialView alloc] initWithFrame:
                           CGRectMake(10, 10, 300, self.bounds.size.height - 55)];
        [fview loadFacialView:1 size:CGSizeMake(33, 38)];
        fview.delegate = self;
        [self addSubview:fview];
        
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(10, self.bounds.size.height - 35, 300, 30);
        _sendButton.backgroundColor = [UIColor clearColor];
        _sendButton.layer.borderWidth = 2;
        _sendButton.layer.borderColor = [UIColor grayColor].CGColor;
        
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendButton];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
-(void)selectedFacialView:(NSString*)str{
    if (_delegate) {
        [_delegate selectedFacialView:str isDelete:NO];
    }
}

-(void)deleteSelected:(NSString *)str{
    if (_delegate) {
        [_delegate selectedFacialView:str isDelete:YES];
    }
}

-(void)sendMessageButtonPressed:(UIButton *)sender{
    if (_delegate) {
        [_delegate sendMessageFormFaceView];
    }
}
@end
