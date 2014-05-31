//
//  EMChatBaseBubbleView.h
//  ChatDemo
//
//  Created by xieyajie on 14-3-7.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EMMessageModel.h"
#import "THProgressView.h"
#import "UIResponder+Router.h"

extern NSString *const kRouterEventChatCellBubbleTapEventName;

#define BUBBLE_LEFT_IMAGE_NAME @"chat_receiver_bg" // bubbleView 的背景图片
#define BUBBLE_RIGHT_IMAGE_NAME @"chat_sender_bg"
#define BUBBLE_ARROW_WIDTH 5 // bubbleView中，箭头的宽度
#define BUBBLE_VIEW_PADDING 5 // bubbleView 与 在其中的控件内边距

#define BUBBLE_RIGHT_LEFT_CAP_WIDTH 5 // 文字在右侧时,bubble用于拉伸点的X坐标
#define BUBBLE_RIGHT_TOP_CAP_HEIGHT 35 // 文字在右侧时,bubble用于拉伸点的Y坐标

#define BUBBLE_LEFT_LEFT_CAP_WIDTH 35 // 文字在左侧时,bubble用于拉伸点的X坐标
#define BUBBLE_LEFT_TOP_CAP_HEIGHT 35 // 文字在左侧时,bubble用于拉伸点的Y坐标

#define BUBBLE_PROGRESSVIEW_HEIGHT 10 // progressView 高度

#define KMESSAGEKEY @"message"

@interface EMChatBaseBubbleView : UIView
{
    THProgressView *_progressView;
    EMMessageModel *_model;
}

@property (nonatomic, strong) EMMessageModel *model;

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) THProgressView *progressView;

- (void)bubbleViewPressed:(id)sender;

+ (CGFloat)heightForBubbleWithObject:(EMMessageModel *)object;

@end
