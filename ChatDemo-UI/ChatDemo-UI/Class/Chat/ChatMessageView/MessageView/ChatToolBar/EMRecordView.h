//
//  EMRecordView.h
//  ChatDemo
//
//  Created by dujiepeng on 14-3-4.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EMRecordDelegate <NSObject>

@optional
-(void)audioPlay;
-(void)audioCancel;
-(void)sendAudio;
@end

@interface EMRecordView : UIView
@property (nonatomic, assign) id<EMRecordDelegate> delegate;


// 录音按钮按下
-(void)recordButtonTouchDown;
// 手指在录音按钮内部时离开
-(void)recordButtonTouchUpInside;
// 手指在录音按钮外部时离开
-(void)recordButtonTouchUpOutside;
// 手指移动到录音按钮内部
-(void)recordButtonDragInside;
// 手指移动到录音按钮外部
-(void)recordButtonDragOutside;
@end
