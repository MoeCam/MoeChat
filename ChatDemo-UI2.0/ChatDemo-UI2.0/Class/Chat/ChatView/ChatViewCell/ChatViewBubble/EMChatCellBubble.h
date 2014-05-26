//
//  EMChatCellBubble.h
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMChatCellConfig.h"
#import "UIImageView+WebCache.h"
#import "EMChatCellBubbleModel.h"

@interface EMChatCellBubble : UIView

@property (nonatomic, strong) EMChatCellBubbleModel *model;

+(CGFloat)heightForChatModel:(EMChatCellBubbleModel *)model;
@end
