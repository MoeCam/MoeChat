//
//  EMChatCellTextBubble.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "EMChatCellTextBubble.h"

@interface EMChatCellTextBubble(){
    UILabel *_textLabel;
}

@end

@implementation EMChatCellTextBubble

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.numberOfLines = 0;
        _textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _textLabel.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.userInteractionEnabled = NO;
        _textLabel.multipleTouchEnabled = NO;
        [self addSubview:_textLabel];
    }
    return self;
}

// 执行此步之前，确保sizeThatFits:已经执行
-(void)layoutSubviews{
    [super layoutSubviews];
    _textLabel.text = self.model.content;
    CGRect frame = self.bounds;
    // 减去箭头宽度
    frame.size.width -= CHATCELL_BUBBLE_ARROW_WIDTH;
    frame = CGRectInset(frame, CHATCELL_BUBBLE_WITHIN_PADDING, CHATCELL_BUBBLE_WITHIN_PADDING);
    if (self.model.isLeft) {
        frame.origin.x = CHATCELL_BUBBLE_WITHIN_PADDING + CHATCELL_BUBBLE_ARROW_WIDTH;
    }else{
        frame.origin.x = CHATCELL_BUBBLE_WITHIN_PADDING;
    }
    frame.origin.y = CHATCELL_BUBBLE_WITHIN_PADDING;
    [_textLabel setFrame:frame];
}

- (CGSize)sizeThatFits:(CGSize)size{
    [super sizeThatFits:size];
    CGSize textBlockMinSize = {CHATCELL_BUBBLE_WIDTH - CHATCELL_BUBBLE_ARROW_WIDTH - CHATCELL_BUBBLE_WITHIN_PADDING * 2, CGFLOAT_MAX};
    CGSize retSize;
    NSString *text = self.model.content;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        retSize = [text
                   boundingRectWithSize:textBlockMinSize
                   options:NSStringDrawingUsesLineFragmentOrigin
                   attributes:@{NSFontAttributeName:[[self class] textLabelFont]}
                   context:nil].size;
    }else{
        retSize = [text
                   sizeWithFont:[[self class] textLabelFont]
                   constrainedToSize:textBlockMinSize
                   lineBreakMode:[[self class] textLabelLineBreakModel]];
    }
    
    CGFloat height = CHATCELL_HEAD_SIZE;
    if (2*CHATCELL_BUBBLE_WITHIN_PADDING + retSize.height > height) {
        height = 2*CHATCELL_BUBBLE_WITHIN_PADDING + retSize.height;
    }

    return CGSizeMake(retSize.width + CHATCELL_BUBBLE_WITHIN_PADDING*2 + CHATCELL_BUBBLE_ARROW_WIDTH, height);
}

+(UIFont *)textLabelFont{
    return [UIFont systemFontOfSize:LABEL_FONT_SIZE];
}

+(NSLineBreakMode)textLabelLineBreakModel{
    return NSLineBreakByCharWrapping;
}

+(CGFloat)heightForChatModel:(EMChatCellBubbleModel *)model{
    [super heightForChatModel:model];
    CGSize textBlockMinSize = {CHATCELL_BUBBLE_WIDTH, CGFLOAT_MAX};
    CGSize size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        size = [model.content
                boundingRectWithSize:textBlockMinSize
                options:NSStringDrawingUsesLineFragmentOrigin
                attributes:@{NSFontAttributeName:[self textLabelFont]}
                context:nil].size;
    }else{
        size = [model.content
                sizeWithFont:[self textLabelFont]
                constrainedToSize:textBlockMinSize
                lineBreakMode:[self textLabelLineBreakModel]];
    }
    return 2 * CHATCELL_BUBBLE_WITHIN_PADDING + size.height;
}


@end
