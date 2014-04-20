//
//  ChatLeftCell.m
//  leCar
//
//  Created by dujiepeng on 14-3-5.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatLeftCell.h"

@implementation ChatLeftCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _nameLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLable.textAlignment = UITextAlignmentLeft;
        _nameLable.textColor = [UIColor blackColor];
        _nameLable.font = [UIFont systemFontOfSize:NAME_LABEL_FONT_SIZE];
        [self.contentView addSubview:_nameLable];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)layoutSubviews{
    [super layoutSubviews];
    // 设置头像位置
    CGRect frame = self.headImageView.frame;
    frame.origin.x = HEAD_PADDING;
    frame.origin.y = 0;
    self.headImageView.frame = frame;
    
    //　根据头像位置，设置姓名显示位置
    frame = self.nameLable.frame;
    BOOL isChatroom = ((ChatCellModel *)self.model).isChatroom;
    if (isChatroom) {
        [self.nameLable setHidden:NO];
        frame.origin.x = HEAD_PADDING * 2 + HEAD_SIZE + NAME_LABEL_PADDING;
        frame.origin.y = 0;
        
        frame.size.width = NAME_LABEL_WIDTH;
        frame.size.height = NAME_LABEL_HEIGHT;
        self.nameLable.frame = frame;
        self.nameLable.text = ((ChatCellModel *)self.model).nickName;
        self.nameLabelHeight = NAME_LABEL_HEIGHT;
    }else{
        [self.nameLable setHidden:YES];
        self.nameLabelHeight = 0;
    }
}


+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
         withObject:(ChatCellModel *)model{
    if (model.isChatroom) {
        return NAME_LABEL_HEIGHT + HEAD_PADDING + CELLPADDING;
    }else{
        return 0;
    }
}
@end
