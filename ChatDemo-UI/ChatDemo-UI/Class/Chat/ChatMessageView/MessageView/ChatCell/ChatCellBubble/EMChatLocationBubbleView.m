//
//  EMChatLocationBubbleView.m
//  ChatDemo
//
//  Created by xieyajie on 14-3-6.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import "EMChatLocationBubbleView.h"

NSString *const kRouterEventLocationBubbleTapEventName = @"kRouterEventLocationBubbleTapEventName";

@interface EMChatLocationBubbleView ()

@property (nonatomic, strong) UIImageView *locationImageView;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation EMChatLocationBubbleView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LOCATION_IMAGEVIEW_SIZE, LOCATION_IMAGEVIEW_SIZE)];
        [self addSubview:_locationImageView];
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:LOCATION_ADDRESS_LABEL_FONT_SIZE];
        _addressLabel.textColor = [UIColor whiteColor];
        _addressLabel.numberOfLines = 0;
        _addressLabel.backgroundColor = [UIColor clearColor];
        [_locationImageView addSubview:_addressLabel];
    }
    return self;
}

-(CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(LOCATION_IMAGEVIEW_SIZE + BUBBLE_VIEW_PADDING * 2 + BUBBLE_ARROW_WIDTH, 2 * BUBBLE_VIEW_PADDING + LOCATION_IMAGEVIEW_SIZE);
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
    [self.locationImageView setFrame:frame];
    _addressLabel.frame = CGRectMake(5, self.locationImageView.frame.size.height - 30, self.locationImageView.frame.size.width - 10, 25);
}

#pragma mark - setter

- (void)setModel:(EMMessageModel *)model
{
    [super setModel:model];
    
    _locationImageView.image = [UIImage imageNamed:LOCATION_IMAGE]; // 设置地图图片
    _addressLabel.text = model.address;
}

#pragma mark - public

-(void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventLocationBubbleTapEventName userInfo:@{KMESSAGEKEY:self.model}];
}

+(CGFloat)heightForBubbleWithObject:(EMMessageModel *)object
{
    return 2 * BUBBLE_VIEW_PADDING + LOCATION_IMAGEVIEW_SIZE;
}
@end
