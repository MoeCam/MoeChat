//
//  EMChatCellVoiceBubble.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "EMChatCellVoiceBubble.h"

@interface EMChatCellVoiceBubble (){
    UILabel *_timerLabel;
    UIImageView *_speakerImageView;
}

@end

@implementation EMChatCellVoiceBubble

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _timerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timerLabel.userInteractionEnabled = NO;
        _timerLabel.multipleTouchEnabled = NO;
        [self addSubview:_timerLabel];
        
        _speakerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _speakerImageView.userInteractionEnabled = NO;
        _speakerImageView.multipleTouchEnabled = NO;
        [self addSubview:_speakerImageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSArray *images = nil;
    UIImage *defaultImage = nil;
    if (self.model.isLeft) {
        defaultImage = [UIImage imageNamed:VOICE_LEFT_DEFAULT_IMAGE];
        images = @[VOICE_LEFT_SPEAKER_IMAGE1,
                   VOICE_LEFT_SPEAKER_IMAGE2,
                   VOICE_LEFT_SPEAKER_IMAGE3,
                   VOICE_LEFT_SPEAKER_IMAGE4];
    }else{
        defaultImage = [UIImage imageNamed:VOICE_RIGHT_DEFAULT_IMAGE];
        images = @[VOICE_RIGHT_SPEAKER_IMAGE1,
                   VOICE_RIGHT_SPEAKER_IMAGE2,
                   VOICE_RIGHT_SPEAKER_IMAGE3,
                   VOICE_RIGHT_SPEAKER_IMAGE4];
    }
    [_speakerImageView setImage:defaultImage];
    [_speakerImageView setAnimationImages:images];
    _timerLabel.text = [NSString stringWithFormat:@"%ld",(long)self.model.time];
    if (self.model.isPlaying) {
        [_speakerImageView startAnimating];
    }else {
        [_speakerImageView stopAnimating];
    }
}

- (CGSize)sizeThatFits:(CGSize)size{
    [super sizeThatFits:size];
    CGFloat width = CHATCELL_BUBBLE_PADDING*2 + CHATCELL_BUBBLE_ARROW_WIDTH + VOICE_TIMELABEL_WIDTH +VOICE_TIMELABEL_SPEAKER_SPACING + VOICE_SPEAKER_IMAGE_SIZE;
    
    CGFloat maxHeight = MAX(VOICE_SPEAKER_IMAGE_SIZE, VOICE_TIMELABEL_HEIGHT);
    CGFloat height = CHATCELL_BUBBLE_PADDING*2 + maxHeight;
    return CGSizeMake(width, height);
}

+(CGFloat)heightForChatModel:(EMChatCellBubbleModel *)model;{
    [super heightForChatModel:model];
    return 2 * CHATCELL_BUBBLE_PADDING + VOICE_SPEAKER_IMAGE_SIZE;
}

@end
