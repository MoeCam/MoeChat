//
//  ChatTextBubbleView.h
//  leCar
//
//  Created by dujiepeng on 14-3-6.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatBaseBubbleView.h"


#define TEXTLABEL_MAX_WIDTH 200 //　textLaebl 最大宽度
#define LABEL_FONT_SIZE 14

extern NSString *const kRouterEventTextBubbleTapEventName;
@interface ChatTextBubbleView : ChatBaseBubbleView


+(UIFont *)textLabelFont;
+(NSLineBreakMode)textLabelLineBreakModel;
@end
