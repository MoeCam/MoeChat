//
//  ChatCellModelManager.m
//  leCar
//
//  Created by dujiepeng on 14-3-6.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatCellModelManager.h"
#import "Contact.h"

@implementation ChatCellModelManager
+(ChatCellModel *)modelWithMessage:(EMMessage *)message{
    NSString *currentUsername = [[[EaseMob sharedInstance].userManager loginInfo] objectForKey:kUserLoginInfoUsername];
    
    BOOL isLeft = ![currentUsername isEqualToString:message.from];
    for (EMMessageBody *messageBody in message.messageBodies) {
        switch (messageBody.messageType) {
            case eMessageType_Text:
            {
                ChatTextModel *ret = [[ChatTextModel alloc] init];
                ret.messageId = message.messageId;
                ret.isChatroom = message.isChatroom;
                ret.textMessage = ((EMTextMessageBody *)messageBody).text.text;
                ret.isLeft = isLeft;
                ret.username = message.from;
                if (isLeft) {
                    ret.cellType = eChatLeftTextCellType;
                    ret.nickName = message.from;
                    ret.sendStatus = eMessageDeliveryState_Delivered;
                }else {
                    ret.cellType = eChatRightTextCellType;
                    ret.sendStatus = message.deliveryState;
                }
                return ret;
            }
                break;
                           break;
            default:
                break;
        }
        
    }
    
    return nil;
}

@end
