//
//  EMChatViewBaseCell.m
//  ChatDemo
//
//  Created by xieyajie on 14-4-15.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import "EMChatViewBaseCell.h"

#import "UIImageView+WebCache.h"

NSString *const kRouterEventChatHeadImageTapEventName = @"kRouterEventChatHeadImageTapEventName";

@interface EMChatViewBaseCell()

@end

@implementation EMChatViewBaseCell

- (id)initWithMessage:(EMMessageModel *)message reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImagePressed:)];
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HEAD_PADDING, CELLPADDING, HEAD_SIZE, HEAD_SIZE)];
        [_headImageView addGestureRecognizer:tap];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.multipleTouchEnabled = YES;
        _headImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headImageView];
        
        [self setupSubviewsForMessage:message];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = _headImageView.frame;
    frame.origin.x = _message.isSender ? (self.bounds.size.width - _headImageView.frame.size.width - HEAD_PADDING) : HEAD_PADDING;
    _headImageView.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter

- (void)setMessage:(EMMessageModel *)message
{
    _message = message;
    
    UIImage *placeholderImage = [UIImage imageNamed:@"account_defaultHead"];
    [self.headImageView setImageWithURL:_message.headImageURL placeholderImage:placeholderImage];
}

#pragma mark - private

-(void)headImagePressed:(id)sender
{
    [super routerEventWithName:kRouterEventChatHeadImageTapEventName userInfo:@{KMESSAGEKEY:self.message}];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [super routerEventWithName:eventName userInfo:userInfo];
}

#pragma mark - public

- (void)setupSubviewsForMessage:(EMMessageModel *)message
{
    if (message.isSender) {
        self.headImageView.frame = CGRectMake(self.bounds.size.width - HEAD_SIZE - HEAD_PADDING, CELLPADDING, HEAD_SIZE, HEAD_SIZE);
    }
    else{
        self.headImageView.frame = CGRectMake(0, CELLPADDING, HEAD_SIZE, HEAD_SIZE);
    }
}

+ (NSString *)cellIdentifierForMessage:(EMMessageModel *)message
{
    NSString *identifier = @"MessageCell";
    if (message.isSender) {
        identifier = [identifier stringByAppendingString:@"Sender"];
    }
    else{
        identifier = [identifier stringByAppendingString:@"Receiver"];
    }
    
    switch (message.type) {
        case eMessageBodyType_Text:
        {
            identifier = [identifier stringByAppendingString:@"Text"];
        }
            break;
        case eMessageBodyType_Image:
        {
            identifier = [identifier stringByAppendingString:@"Image"];
        }
            break;
        case eMessageBodyType_Voice:
        {
            identifier = [identifier stringByAppendingString:@"Audio"];
        }
            break;
        case eMessageBodyType_Location:
        {
            identifier = [identifier stringByAppendingString:@"Location"];
        }
            break;
        case eMessageBodyType_Video:
        {
            identifier = [identifier stringByAppendingString:@"Video"];
        }
            break;
            
        default:
            break;
    }
    
    return identifier;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(EMMessageModel *)model
{
    return HEAD_SIZE + CELLPADDING;
}

@end
