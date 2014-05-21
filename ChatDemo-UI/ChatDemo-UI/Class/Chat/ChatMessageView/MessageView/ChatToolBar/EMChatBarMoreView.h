//
//  easemobChatBarMoreView.h
//  ChatDemo
//
//  Created by xieyajie on 14-4-15.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EMChatBarMoreViewDelegate;
@interface EMChatBarMoreView : UIView

@property (nonatomic,assign) id<EMChatBarMoreViewDelegate> delegate;

@property (nonatomic, strong) UIButton *faceButton;
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UIButton *takePicButton;
@property (nonatomic, strong) UIButton *locationButton;

- (void)setupSubviews;

@end

@protocol EMChatBarMoreViewDelegate <NSObject>

@required
- (void)moreViewTakePicAction:(EMChatBarMoreView *)moreView;
- (void)moreViewPhotoAction:(EMChatBarMoreView *)moreView;
- (void)moreViewFaceAction:(EMChatBarMoreView *)moreView;
- (void)moreViewLocationAction:(EMChatBarMoreView *)moreView;

@end
