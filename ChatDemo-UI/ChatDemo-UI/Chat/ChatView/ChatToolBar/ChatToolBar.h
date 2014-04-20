//
//  ChatToolBar.h
//  TestKeyBoard
//
//  Created by dujiepeng on 14-2-14.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@protocol ChatToolBarDelegate <NSObject>
@optional

// 更多按钮按下后的回调
-(void)shareMoreButtonPressed;

// 表情按钮按下后的回调
-(void)faceButtonPressed;

// 语音按钮
-(void)speakerButtonPressed;

// 用户自定义按钮按下后回调
-(void)otherButtonPressed;

// 录音按钮按下
-(void)recordButtonTouchDown:(UIView *)recordView;

// 手指在按钮内部时离开
-(void)recordButtonTouchUpInside:(UIView *)recordView;

// 手指在按钮外部时离开
-(void)recordButtonTouchUpOutside:(UIView *)recordView;

// 手指移动到按钮内部
-(void)recordButtonDragInside:(UIView *)recordView;

// 手指移动到按钮外部
-(void)recordButtonDragOutside:(UIView *)recordView;

-(void)chatBarTextShouldReturn;

@required
// 传入需要显示的shareMoreView（如果没有，传nil）
-(UIView *)shareMoreView;

// 传入需要显示的emojiActionView（如果没有，传nil）
-(UIView *)emojiActionView;

// 传入用于显示语音时动画的View（如果没有，传nil）
-(UIView *)recordView;

// 传入需要退应调整的tableView（如果没有，传nil）
-(UITableView *)showTableView;
@end

@interface ChatToolBar : UIView {
    
}

// 输入用的TextView
@property (weak, nonatomic) IBOutlet HPGrowingTextView *textView;
@property (weak, nonatomic, readonly) UIViewController <ChatToolBarDelegate> *subViewController;

/**
 *  初始化ToolBar
 *
 *  @param viewController 要显示toolBar的controller（需要实现ChatToolBarDelegate, ChatShareMoreDelegate委托）
 *  @param view           用于显示Record的View（可以自定义view传入，显示对应效果或事件）
 *
 *  @return ChatToolBar
 */
-(id)initWithViewController:(UIViewController <ChatToolBarDelegate> *)viewController;
@end
