//
//  EMChatSendHelper.m
//  ChatDemo
//
//  Created by xieyajie on 14-3-22.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import "EMChatSendHelper.h"
#import "EMMessage.h"
#import "EMChatText.h"
#import "EMTextMessageBody.h"
#import "EaseMob.h"

@implementation EMChatSendHelper

+(EMMessage *)sendTextMessageWithString:(NSString *)str
                             toUsername:(NSString *)username
{
    
    EMChatText *text = [[EMChatText alloc] initWithText:str];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:text];
    return [self sendMessage:username messageBody:body];
}

+(EMMessage *)sendImageMessageWithImage:(UIImage *)image
                             toUsername:(NSString *)username
{
    EMChatImage *chatImage = [[EMChatImage alloc] initWithUIImage:image displayName:@"image"];
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithImage:chatImage thumbnailImage:nil];
    return [self sendMessage:username messageBody:body];
}


+(EMMessage *)sendVoice:(EMChatVoice *)voice
             toUsername:(NSString *)username
{
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithChatObject:voice];
    return [self sendMessage:username messageBody:body];
}

+(EMMessage *)sendLocationLatitude:(double)latitude
                         longitude:(double)longitude
                           address:(NSString *)address
                        toUsername:(NSString *)username
{
    EMChatLocation *chatLocation = [[EMChatLocation alloc] initWithLatitude:latitude longitude:longitude address:address];
    EMLocationMessageBody *body = [[EMLocationMessageBody alloc] initWithChatObject:chatLocation];
    return [self sendMessage:username messageBody:body];
}

// 发送消息
+(EMMessage *)sendMessage:(NSString *)username
              messageBody:(id<IEMMessageBody>)body
{
    EMMessage *msg = [[EMMessage alloc] initWithReceiver:username bodies:[NSArray arrayWithObject:body]];
    
    EMMessage *message = [[EaseMob sharedInstance].chatManager asyncSendMessage:msg progress:nil];
    
    return message;
}

@end
