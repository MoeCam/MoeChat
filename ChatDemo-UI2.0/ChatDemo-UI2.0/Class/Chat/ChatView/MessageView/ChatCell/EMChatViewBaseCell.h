//
//  EMChatViewBaseCell.h
//  ChatDemo
//
//  Created by xieyajie on 14-4-15.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EMMessageModel.h"
#import "EMChatBaseBubbleView.h"

#import "UIResponder+Router.h"

#define HEAD_SIZE 40 // 头像大小
#define HEAD_PADDING 5 // 头像到cell的内间距和头像到bubble的间距
#define CELLPADDING 8 // Cell之间间距

#define NAME_LABEL_WIDTH 180 // nameLabel宽度
#define NAME_LABEL_HEIGHT 20 // nameLabel 高度
#define NAME_LABEL_PADDING 0 // nameLabel间距
#define NAME_LABEL_FONT_SIZE 14 // 字体

extern NSString *const kRouterEventChatHeadImageTapEventName;

@interface EMChatViewBaseCell : UITableViewCell
{
    UIImageView *_headImageView;
    UILabel *_nameLabel;
    EMChatBaseBubbleView *_bubbleView;
    
    CGFloat _nameLabelHeight;
    EMMessageModel *_message;
}

@property (nonatomic, strong) EMMessageModel *message;

@property (nonatomic, strong) UIImageView *headImageView;       //头像
@property (nonatomic, strong) UILabel *nameLabel;               //姓名（暂时不支持显示）
@property (nonatomic, strong) EMChatBaseBubbleView *bubbleView;   //内容区域

- (id)initWithMessage:(EMMessageModel *)message reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setupSubviewsForMessage:(EMMessageModel *)message;

+ (NSString *)cellIdentifierForMessage:(EMMessageModel *)message;

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(EMMessageModel *)model;

@end
