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
        _timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VOICE_TIMELABEL_WIDTH, VOICE_TIMELABEL_HEIGHT)];
        _timerLabel.userInteractionEnabled = NO;
        _timerLabel.multipleTouchEnabled = NO;
        [self addSubview:_timerLabel];
        
        _speakerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VOICE_SPEAKER_IMAGE_WIDTH, VOICE_SPEAKER_IMAGE_HEIGHT)];
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
        images = @[[UIImage imageNamed:VOICE_LEFT_SPEAKER_IMAGE1],
                   [UIImage imageNamed:VOICE_LEFT_SPEAKER_IMAGE2],
                   [UIImage imageNamed:VOICE_LEFT_SPEAKER_IMAGE3],
                   [UIImage imageNamed:VOICE_LEFT_SPEAKER_IMAGE4]];
        CGRect frame = _speakerImageView.frame;
        frame.origin.x = CHATCELL_BUBBLE_ARROW_WIDTH + CHATCELL_BUBBLE_WITHIN_PADDING;
        frame.origin.y = CHATCELL_BUBBLE_WITHIN_PADDING;
        _speakerImageView.frame = frame;
        frame = _timerLabel.frame;
        frame.origin.x = _speakerImageView.frame.origin.x + _speakerImageView.frame.size.width + VOICE_TIMELABEL_SPEAKER_SPACING;
        frame.origin.y = CHATCELL_BUBBLE_WITHIN_PADDING;
        _timerLabel.frame = frame;
        
    }else{
        defaultImage = [UIImage imageNamed:VOICE_RIGHT_DEFAULT_IMAGE];
        images = @[[UIImage imageNamed:VOICE_RIGHT_SPEAKER_IMAGE1],
                   [UIImage imageNamed:VOICE_RIGHT_SPEAKER_IMAGE2],
                   [UIImage imageNamed:VOICE_RIGHT_SPEAKER_IMAGE3],
                   [UIImage imageNamed:VOICE_RIGHT_SPEAKER_IMAGE4]];
        
        CGRect frame = _timerLabel.frame;
        frame.origin.x = CHATCELL_BUBBLE_WITHIN_PADDING;
        frame.origin.y = CHATCELL_BUBBLE_WITHIN_PADDING;
        _timerLabel.frame = frame;
        frame = _speakerImageView.frame;
        frame.origin.x = _timerLabel.frame.origin.x + _timerLabel.frame.size.width + VOICE_TIMELABEL_SPEAKER_SPACING;
        frame.origin.y = CHATCELL_BUBBLE_WITHIN_PADDING;
        _speakerImageView.frame = frame;
    }
    _timerLabel.text = [NSString stringWithFormat:@"%ld'",(long)self.model.time];
    [_speakerImageView setImage:defaultImage];
    [_speakerImageView setAnimationImages:images];
    
    
    if (self.model.isPlaying) {
        [_speakerImageView startAnimating];
    }else {
        [_speakerImageView stopAnimating];
    }
}

- (CGSize)sizeThatFits:(CGSize)size{
    [super sizeThatFits:size];
    CGFloat width = CHATCELL_BUBBLE_WITHIN_PADDING*2 + CHATCELL_BUBBLE_ARROW_WIDTH + VOICE_TIMELABEL_WIDTH +VOICE_TIMELABEL_SPEAKER_SPACING + VOICE_SPEAKER_IMAGE_WIDTH;
    
    CGFloat maxHeight = MAX(VOICE_SPEAKER_IMAGE_HEIGHT, VOICE_TIMELABEL_HEIGHT);
    CGFloat height = CHATCELL_BUBBLE_WITHIN_PADDING*2 + maxHeight;
    return CGSizeMake(width, height);
}

+(CGFloat)heightForChatModel:(EMChatCellBubbleModel *)model;{
    [super heightForChatModel:model];
    return 2 * CHATCELL_BUBBLE_WITHIN_PADDING + VOICE_SPEAKER_IMAGE_HEIGHT;
}

@end
