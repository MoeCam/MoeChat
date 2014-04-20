//
//  ChatTextBubbleView.m
//  leCar
//
//  Created by dujiepeng on 14-3-6.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatTextBubbleView.h"
#import "ChatTextModel.h"

NSString *const kRouterEventTextBubbleTapEventName = @"kRouterEventTextBubbleTapEventName";
@interface ChatTextBubbleView ()
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ChatTextBubbleView

-(id)init{
    if (self = [super init]) {
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



-(void)layoutSubviews{
    [super layoutSubviews];
    ChatTextModel *model = (ChatTextModel *)self.model;
    _textLabel.text = ((ChatTextModel *)self.model).textMessage;
    CGRect frame = self.bounds;
    frame.size.width -= BUBBLE_ARROW_WIDTH;
    frame = CGRectInset(frame, BUBBLE_VIEW_PADDING, BUBBLE_VIEW_PADDING);
    if (model.isLeft) {
        frame.origin.x = BUBBLE_VIEW_PADDING + BUBBLE_ARROW_WIDTH;
    }else{
        frame.origin.x = BUBBLE_VIEW_PADDING;
    }
    
    frame.origin.y = BUBBLE_VIEW_PADDING;
    [self.textLabel setFrame:frame];
    [self.bubbleImageView setFrame:self.bounds];
}

- (CGSize)sizeThatFits:(CGSize)size{
    CGSize textBlockMinSize = {TEXTLABEL_MAX_WIDTH, CGFLOAT_MAX};
    CGSize retSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        retSize = [((ChatTextModel *)self.model).textMessage
                   boundingRectWithSize:textBlockMinSize
                   options:NSStringDrawingUsesLineFragmentOrigin
                   attributes:@{NSFontAttributeName:[[self class] textLabelFont]}
                   context:nil].size;
    }else{
        retSize = [((ChatTextModel *)self.model).textMessage
                   sizeWithFont:[[self class] textLabelFont]
                   constrainedToSize:textBlockMinSize
                   lineBreakMode:[[self class] textLabelLineBreakModel]];
    }
    return CGSizeMake(retSize.width + BUBBLE_VIEW_PADDING*2 + BUBBLE_ARROW_WIDTH, 2*BUBBLE_VIEW_PADDING + retSize.height);
}

-(void)bubbleViewPressed:(id)sender{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    [userInfo setObject:self.model forKey:@"ChatCellModel"];
}


+(CGFloat)heightForBubbleWithObject:(ChatCellModel *)object{
    CGSize textBlockMinSize = {TEXTLABEL_MAX_WIDTH, CGFLOAT_MAX};
    CGSize size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        size = [((ChatTextModel *)object).textMessage
                boundingRectWithSize:textBlockMinSize
                options:NSStringDrawingUsesLineFragmentOrigin
                attributes:@{NSFontAttributeName:[self textLabelFont]}
                context:nil].size;
    }else{
        size = [((ChatTextModel *)object).textMessage
                sizeWithFont:[self textLabelFont]
                constrainedToSize:textBlockMinSize
                lineBreakMode:[self textLabelLineBreakModel]];
    }
    return 2 * BUBBLE_VIEW_PADDING + size.height;
}

+(UIFont *)textLabelFont{
    return [UIFont systemFontOfSize:LABEL_FONT_SIZE];
}

+(NSLineBreakMode)textLabelLineBreakModel{
    return NSLineBreakByCharWrapping;
}


@end
