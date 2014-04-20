//
//  ChatCellManager.h
//  leCar
//
//  Created by dujiepeng on 14-3-10.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatCellModel;
@class ChatBaseBubbleView;
@interface ChatCellManager : NSObject

+(UITableViewCell *)tableView:(UITableView *)tableView
               cellWithObject:(NSObject *)obj;

+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
          andObject:(NSObject *)obj;

+(ChatBaseBubbleView *)tableView:(UITableView *)tableView bubbleWithModel:(ChatCellModel *)model;
@end
