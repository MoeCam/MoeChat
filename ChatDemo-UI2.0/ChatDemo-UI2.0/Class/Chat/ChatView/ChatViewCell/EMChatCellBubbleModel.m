//
//  EMChatCellBubbleModel.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "EMChatCellBubbleModel.h"


@implementation EMChatCellBubbleModel

+(instancetype)modelWithMessage:(EMMessage *)message{
    EMChatCellBubbleModel *bubbleModel = [[EMChatCellBubbleModel alloc] init];
    id<IEMMessageBody> body = message.messageBodies.lastObject;
    bubbleModel.isChatroom = message.isChatroom;
    NSString *usename = [[[EaseMob sharedInstance].chatManager loginInfo]
                         objectForKey:kSDKUsername];
    
    if ([usename isEqualToString:message.to]) {
        bubbleModel.isLeft = YES;
    }else{
        bubbleModel.isLeft = NO;
    }
    
    switch (body.messageBodyType) {
        case eMessageBodyType_Text:
        {
            bubbleModel.content = ((EMTextMessageBody *)body.chatObject).text;
            bubbleModel.bubbleType = BubbleViewType_Text;
        }
            break;
            
        case eMessageBodyType_Image:
        {
            bubbleModel.imageRemoteURL = [NSURL URLWithString:
                                          ((EMImageMessageBody *)body).remotePath];
            bubbleModel.thumbnailImage = [UIImage imageWithContentsOfFile:
                                          ((EMImageMessageBody *)body).thumbnailLocalPath];
            bubbleModel.bubbleType = BubbleViewType_Image;
        }
            break;
            
        case eMessageBodyType_Location:
        {
            bubbleModel.latitude = ((EMLocationMessageBody *)body.chatObject).latitude;
            bubbleModel.longitude = ((EMLocationMessageBody *)body.chatObject).longitude;
            bubbleModel.address = ((EMLocationMessageBody *)body.chatObject).address;
            bubbleModel.bubbleType = BubbleViewType_Location;
        }
            break;
            
        case eMessageBodyType_Voice:
        {
            bubbleModel.localPath = ((EMVoiceMessageBody *)body.chatObject).localPath;
            bubbleModel.time = ((EMVoiceMessageBody *)body.chatObject).duration;
            bubbleModel.bubbleType = BubbleViewType_Voice;
        }
            break;
            
        default:
            break;
    }
    
    return bubbleModel;
}

@end
