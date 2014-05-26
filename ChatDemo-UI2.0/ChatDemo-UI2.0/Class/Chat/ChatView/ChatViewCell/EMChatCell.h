//
//  EMChatCell.h
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EMChatCellBubble;
@class EMChatCellBubbleModel;
@interface EMChatCell : UITableViewCell
@property (nonatomic, strong) EMChatCellBubbleModel *model;
@property (nonatomic, strong) UIView *avtivityView;
@property (nonatomic, strong) UILabel *nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
    withBubbleModel:(EMChatCellBubbleModel *)model;

+ (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
        withChatModel:(EMChatCellBubbleModel *)model;
@end
