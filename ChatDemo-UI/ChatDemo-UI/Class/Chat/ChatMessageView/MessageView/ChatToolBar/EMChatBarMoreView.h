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

@property (nonatomic,retain) UIButton *faceButton;
@property (nonatomic,retain) UIButton *photoButton;
@property (nonatomic,retain) UIButton *locationButton;

- (void)setupSubviews;

@end

@protocol EMChatBarMoreViewDelegate <NSObject>

@required

- (void)moreViewPhotoAction:(EMChatBarMoreView *)moreView;
- (void)moreViewFaceAction:(EMChatBarMoreView *)moreView;
- (void)moreViewLocationAction:(EMChatBarMoreView *)moreView;

@end
