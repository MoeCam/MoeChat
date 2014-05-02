//
//  EMChatTextBubbleView.m
//  ChatDemo
//
//  Created by xieyajie on 14-3-6.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import "EMChatTextBubbleView.h"

NSString *const kRouterEventTextBubbleTapEventName = @"kRouterEventTextBubbleTapEventName";

@interface EMChatTextBubbleView ()

@end

@implementation EMChatTextBubbleView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
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

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    frame.size.width -= BUBBLE_ARROW_WIDTH;
    frame = CGRectInset(frame, BUBBLE_VIEW_PADDING, BUBBLE_VIEW_PADDING);
    if (self.model.isSender) {
        frame.origin.x = BUBBLE_VIEW_PADDING;
    }else{
        frame.origin.x = BUBBLE_VIEW_PADDING + BUBBLE_ARROW_WIDTH;
    }
    
    frame.origin.y = BUBBLE_VIEW_PADDING;
    [self.textLabel setFrame:frame];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize textBlockMinSize = {TEXTLABEL_MAX_WIDTH, CGFLOAT_MAX};
    CGSize retSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        retSize = [self.model.content boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[[self class] textLabelFont]} context:nil].size;
    }else{
        retSize = [self.model.content sizeWithFont:[[self class] textLabelFont] constrainedToSize:textBlockMinSize lineBreakMode:[[self class] textLabelLineBreakModel]];
    }
    return CGSizeMake(retSize.width + BUBBLE_VIEW_PADDING*2 + BUBBLE_ARROW_WIDTH, 2*BUBBLE_VIEW_PADDING + retSize.height);
}

#pragma mark - setter

- (void)setModel:(EMMessageModel *)model
{
    [super setModel:model];
    
    _textLabel.text = self.model.content;
}

#pragma mark - public

//-(void)bubbleViewPressed:(id)sender
//{
//    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [userInfo setObject:self.model forKey:KMESSAGEKEY];
//    [self routerEventWithName:kRouterEventTextBubbleTapEventName userInfo:userInfo];
//}


+(CGFloat)heightForBubbleWithObject:(EMMessageModel *)object
{
    CGSize textBlockMinSize = {TEXTLABEL_MAX_WIDTH, CGFLOAT_MAX};
    CGSize size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        size = [object.content boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[self textLabelFont]} context:nil].size;
    }else{
        size = [object.content sizeWithFont:[self textLabelFont] constrainedToSize:textBlockMinSize lineBreakMode:[self textLabelLineBreakModel]];
    }
    return 2 * BUBBLE_VIEW_PADDING + size.height;
}

+(UIFont *)textLabelFont
{
    return [UIFont systemFontOfSize:LABEL_FONT_SIZE];
}

+(NSLineBreakMode)textLabelLineBreakModel
{
    return NSLineBreakByCharWrapping;
}


@end
