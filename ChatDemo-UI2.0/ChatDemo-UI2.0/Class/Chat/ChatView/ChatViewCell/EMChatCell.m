//
//  EMChatCell.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "EMChatCell.h"
#import "EMChatCellBubble.h"
#import "EMChatCellTextBubble.h"
#import "EMChatCellVoiceBubble.h"
#import "EMChatCellLocationBubble.h"
#import "EMChatCellImageBubble.h"
#import "UIImageView+WebCache.h"
#import "EMChatCellConfig.h"

@interface EMChatCell (){
    EMChatCellBubble *_bubbleView;
    UIImageView *_headView;
    UILabel *_nameLabel;
    UIActivityIndicatorView *_activityIndicatorView;
    UIButton *_retryBtn;
}

@end

@implementation EMChatCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withBubbleModel:(EMChatCellBubbleModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        switch (model.bubbleType) {
            case BubbleViewType_Text:{
                _bubbleView = [[EMChatCellTextBubble alloc] initWithFrame:CGRectZero];
            }
                break;
            case BubbleViewType_Image:{
                _bubbleView = [[EMChatCellImageBubble alloc] initWithFrame:CGRectZero];
            }
                break;
            case BubbleViewType_Location:{
                 _bubbleView = [[EMChatCellLocationBubble alloc] initWithFrame:CGRectZero];
            }
                break;
            case BubbleViewType_Voice:{
                 _bubbleView = [[EMChatCellVoiceBubble alloc] initWithFrame:CGRectZero];
            }
                
                break;
                
            default:
                break;
        }
        _bubbleView.model = model;
        [self.contentView addSubview:_bubbleView];
        
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CHATCELL_HEAD_SIZE, CHATCELL_HEAD_SIZE)];
        [self.contentView addSubview:_headView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CHATCELL_CHATNAMAE_HEIGHT)];
        [_nameLabel setHidden:YES];
        [self.contentView addSubview:_nameLabel];
        
        // 菊花
        _activityIndicatorView = [[UIActivityIndicatorView alloc]
                                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.backgroundColor = [UIColor clearColor];
        [_avtivityView addSubview:_activityIndicatorView];
        [_avtivityView setHidden:YES];
        
        // 重发按钮
        _retryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _retryBtn.frame = _activityIndicatorView.frame;
        [_avtivityView addSubview:_retryBtn];
        [_retryBtn addTarget:self action:@selector(retryButtonPressed)
            forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_avtivityView];
        self.backgroundColor = CHATVIEWBACKGROUNDCOLOR;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 得到bubbleViewFrame
    [_bubbleView sizeToFit];
    [_bubbleView setNeedsLayout];
    
    CGRect headFrame = CGRectMake(0, 0, CHATCELL_HEAD_SIZE, CHATCELL_HEAD_SIZE);
 
    if (self.model.isLeft) {
        headFrame.origin.x = CHATCELL_HEAD_X_SPACING;
    }else {
        headFrame.origin.x = CGRectGetWidth(self.contentView.frame) - CHATCELL_HEAD_SIZE - CHATCELL_HEAD_X_SPACING;
    }
    if (self.model.isChatroom) {
        [_nameLabel setHidden:NO];
        //[_nameLabel setText:contact.nickname?contact.nickname:contact.username];
        headFrame.origin.y = CHATCELL_CHATNAMAE_HEIGHT + CHATCELL_CHATNAME_HEAD_HEIGHT+ CHATCELL_HEAD_Y_SPACING;
    }else {
        [_nameLabel setHidden:YES];
        headFrame.origin.y = CHATCELL_HEAD_Y_SPACING;
    }
    _headView.frame = headFrame;
    [_headView setImageWithURL:self.model.avatarURL
              placeholderImage:[UIImage imageNamed:CHATCELL_HEAD_DEFAULT_IMAGE]];
    
    CGRect frame = _bubbleView.frame;
    frame.origin.x = headFrame.size.width + headFrame.origin.x + CHATCELL_HEAD_X_SPACING;
    if (self.model.isChatroom) {
        frame.origin.y = CHATCELL_CHATNAMAE_HEIGHT;
    }
    _bubbleView.frame = frame;
}

-(void)setModel:(EMChatCellBubbleModel *)model{
    _model = model;
    [_bubbleView setModel:model];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)retryButtonPressed{
    NSLog(@"重发按钮按下");
}

+ (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
       withChatModel:(EMChatCellBubbleModel *)model;{
    CGFloat ret = 0;
    if (model.isLeft) {
        ret = CHATCELL_CHATNAMAE_HEIGHT + CHATCELL_CHATNAME_HEAD_HEIGHT+ CHATCELL_HEAD_Y_SPACING;
    }else{
        ret = CHATCELL_HEAD_Y_SPACING;
    }
    ret += [EMChatCellBubble heightForChatModel:model];
    return ret;
}

@end
