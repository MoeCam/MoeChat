//
//  EMChatTextBubbleView.h
//  ChatDemo
//
//  Created by xieyajie on 14-3-6.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMChatBaseBubbleView.h"


#define TEXTLABEL_MAX_WIDTH 200 //　textLaebl 最大宽度
#define LABEL_FONT_SIZE 14

extern NSString *const kRouterEventTextBubbleTapEventName;

@interface EMChatTextBubbleView : EMChatBaseBubbleView

@property (nonatomic, strong) UILabel *textLabel;

+ (UIFont *)textLabelFont;
+ (NSLineBreakMode)textLabelLineBreakModel;

@end
