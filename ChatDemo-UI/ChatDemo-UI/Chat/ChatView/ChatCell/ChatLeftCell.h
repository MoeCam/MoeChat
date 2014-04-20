//
//  ChatLeftCell.h
//  leCar
//
//  Created by dujiepeng on 14-3-5.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "BaseCell.h"

#define NAME_LABEL_WIDTH 180 // nameLabel宽度
#define NAME_LABEL_HEIGHT 20 // nameLabel 高度
#define NAME_LABEL_PADDING 0 // nameLabel间距
#define NAME_LABEL_FONT_SIZE 14 // 字体

@interface ChatLeftCell : BaseCell
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic) CGFloat nameLabelHeight;

@end
