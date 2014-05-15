//
//  EMMessageModelManager.m
//  ChatDemo
//
//  Created by xieyajie on 14-4-14.
//  Copyright (c) 2014年 easemobs. All rights reserved.
//

#import "EMMessageModelManager.h"

#import "EMMessageModel.h"
#import "EaseMob.h"

@implementation EMMessageModelManager

+ (id)modelWithMessage:(EMMessage *)message
{
    EMMessageBody *messageBody = [message.messageBodies firstObject];
    NSDictionary *userInfo = [[EaseMob sharedInstance].chatManager loginInfo];
    NSString *login = [userInfo objectForKey:kSDKUsername];
    BOOL isSender = [login isEqualToString:message.from] ? YES : NO;
    
    EMMessageModel *model = [[EMMessageModel alloc] init];
    model.isRead = message.isRead;
    model.type = messageBody.messageBodyType;
    model.messageId = message.messageId;
    model.isSender = isSender;
    model.username = message.from;
    model.isPlaying = NO;
    
    if (isSender) {
        //            model.headImageURL = [NSURL URLWithString:[XDContactManager currentContact].avatar];
        model.headImageURL = nil;
        model.status = message.deliveryState;
    }
    else{
        model.headImageURL = nil;
        //            model.headImageURL = [NSURL URLWithString:[XDContactManager contactFromDBByUsername:message.from].avatar];
        model.status = eMessageDeliveryState_Delivered;
    }

    switch (messageBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            model.content = ((EMTextMessageBody *)messageBody).text;
        }
            break;
        case eMessageBodyType_Image:
        {
            EMImageMessageBody *imgMessageBody = (EMImageMessageBody*)messageBody;
            model.thumbnailSize = imgMessageBody.thumbnailSize;
            model.size = imgMessageBody.size;
            if (isSender)
            {
                model.thumbnailImage = [UIImage imageWithContentsOfFile:imgMessageBody.thumbnailLocalPath];
                model.image = [UIImage imageWithContentsOfFile:imgMessageBody.localPath];
            }else {
                model.thumbnailRemoteURL = [NSURL URLWithString:imgMessageBody.thumbnailRemotePath];
                model.imageRemoteURL = [NSURL URLWithString:imgMessageBody.remotePath];
            }
        }
            break;
        case eMessageBodyType_Location:
        {
            model.address = ((EMLocationMessageBody *)messageBody).address;
            model.latitude = ((EMLocationMessageBody *)messageBody).latitude;
            model.longitude = ((EMLocationMessageBody *)messageBody).longitude;
        }
            break;
        case eMessageBodyType_Voice:
        {
            model.time = ((EMVoiceMessageBody *)messageBody).duration;
//            model.chatVoice = ((EMVoiceMessageBody *)messageBody).voice;
            
            // 本地音频路径
            model.localPath = ((EMVoiceMessageBody *)messageBody).localPath;
            model.remotePath = ((EMVoiceMessageBody *)messageBody).remotePath;
        }
            break;
        case eMessageBodyType_Video:
            break;
        default:
            break;
    }
    
    return model;
}

@end
