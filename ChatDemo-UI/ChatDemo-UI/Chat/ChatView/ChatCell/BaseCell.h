//
//  BaseCell.h
//  leCar
//
//  Created by dujiepeng on 14-3-5.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatCellModel.h"
#import "ChatBaseBubbleView.h"

#define HEAD_SIZE 40 // 头像大小
#define HEAD_PADDING 5 // 头像到cell的内间距和头像到bubble的间距
#define CELLPADDING 8 // Cell之间间距

@interface BaseCell : UITableViewCell
@property (nonatomic, strong) ChatCellModel *model;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) ChatBaseBubbleView *bubbleView;

+(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
         withObject:(ChatCellModel *)model;

@end
