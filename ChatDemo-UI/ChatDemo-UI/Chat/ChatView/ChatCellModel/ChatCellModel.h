//
//  ChatLeftCellModel.h
//  leCar
//
//  Created by dujiepeng on 14-3-5.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum{
    eChatLeftTextCellType = 0,
    eChatLeftImageCellType,
    eChatLeftLocationCellType,
    eChatLeftAudioCellType,
    eChatRightTextCellType,
    eChatRightImageCellType,
    eChatRightLocationCellType,
    eChatRightAudioCellType
}ChatCellType;

@interface ChatCellModel : NSObject 
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSURL *headImageURL;
@property (nonatomic) ChatCellType cellType;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *username;
@property (nonatomic) MessageDeliveryState sendStatus;
@property (nonatomic) BOOL isLeft;
@property (nonatomic) BOOL isChatroom;

@end
