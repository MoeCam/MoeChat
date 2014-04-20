//
//  ChatCellManager.m
//  leCar
//
//  Created by dujiepeng on 14-3-10.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatCellManager.h"
#import "ChatTextModel.h"
#import "ChatLeftTextCell.h"
#import "ChatRightTextCell.h"
#import "XDChatTimeCell.h"

@implementation ChatCellManager
+(UITableViewCell *)tableView:(UITableView *)tableView
               cellWithObject:(NSObject *)obj{
    
    if (![obj isKindOfClass:[NSString class]]) {
        ChatCellModel * model = (ChatCellModel *)obj;
        switch (model.cellType) {
            case eChatLeftTextCellType:
            {
                ChatLeftTextCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatLeftTextCell"];
                
                cell.model = model;
                return cell;
            }
                break;
            case eChatRightTextCellType:{
                ChatRightTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatRightTextCell"];
                cell.model = model;
                return cell;
            }
                break;
                
            default:
                return nil;
                break;
        }
        
    }else { // 显示时间用
        XDChatTimeCell *timeCell = [tableView
                                    dequeueReusableCellWithIdentifier:
                                    @"XDChatTimeCell"];
        
        timeCell.textLabel.text = (NSString *)obj;
        return timeCell;
    }
}

+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
          andObject:(NSObject *)obj{
    CGFloat ret = 25;
    if (![obj isKindOfClass:[NSString class]]) {
        ChatCellModel *model = (ChatCellModel *)obj;
        switch (model.cellType) {
            case eChatLeftTextCellType:
            {
                ret = [ChatLeftTextCell tableView:tableView heightForRowAtIndexPath:indexPath
                                       withObject:model];
            }
                break;
            case eChatRightTextCellType:
            {
                ret = [ChatRightTextCell tableView:tableView heightForRowAtIndexPath:indexPath
                                        withObject:model];
            }
                break;
                
            default:
                break;
        }
    }
    
    return ret;
}

+(ChatBaseBubbleView *)tableView:(UITableView *)tableView bubbleWithModel:(ChatCellModel *)model{
    UITableViewCell *cell = [self tableView:tableView cellWithObject:model];
    if (![cell isKindOfClass:[XDChatTimeCell class]]) {
        return ((BaseCell *)cell).bubbleView;
    }else {
        return nil;
    }
}
@end
