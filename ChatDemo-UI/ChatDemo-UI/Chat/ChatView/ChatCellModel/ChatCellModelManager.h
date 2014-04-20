//
//  ChatCellModelManager.h
//  leCar
//
//  Created by dujiepeng on 14-3-6.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatCellModel.h"
#import "ChatTextModel.h"


@class ChatCellModel;
@interface ChatCellModelManager : NSObject
+(ChatCellModel *)modelWithMessage:(EMMessage *)message;

@end
