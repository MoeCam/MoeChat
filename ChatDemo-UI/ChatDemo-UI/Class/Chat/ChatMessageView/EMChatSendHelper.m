//
//  EMChatSendHelper.m
//  ChatDemo
//
//  Created by xieyajie on 14-3-22.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import "EMChatSendHelper.h"
#import "EMMessageBody.h"
#import "EMMessage.h"
#import "EMChatText.h"
#import "EMTextMessageBody.h"
#import "EaseMob.h"

@implementation EMChatSendHelper

+(EMMessage *)sendTextMessageWithString:(NSString *)str
                             toUsername:(NSString *)username
{
    
    EMChatText *text = [[EMChatText alloc] initWithText:str];
    EMMessageBody *body = [[EMTextMessageBody alloc] initWithMessage:text];
    return [self sendMessage:username messageBody:body];
}

+(EMMessage *)sendImageMessageWithImage:(UIImage *)image
                             toUsername:(NSString *)username
{
    EMChatImage *chatImage = [[EMChatImage alloc] initWithImage:image displayName:@"image"];
    EMMessageBody *body = [[EMImageMessageBody alloc] initWithImage:chatImage thumbnailImage:nil];
    return [self sendMessage:username messageBody:body];
}


+(EMMessage *)sendVoice:(EMChatVoice *)voice
             toUsername:(NSString *)username
{
    EMMessageBody *body = [[EMVoiceMessageBody alloc]initWithMessage:voice];
    return [self sendMessage:username messageBody:body];
}

+(EMMessage *)sendLocationLatitude:(double)latitude
                         longitude:(double)longitude
                           address:(NSString *)address
                        toUsername:(NSString *)username
{
    EMChatLocation *chatLocation = [[EMChatLocation alloc] initWithLatitude:latitude longitude:longitude address:address];
    EMMessageBody *body = [[EMLocationMessageBody alloc] initWithMessage:chatLocation];
    return [self sendMessage:username messageBody:body];
}

// 发送消息
+(EMMessage *)sendMessage:(NSString *)username
              messageBody:(EMMessageBody *)body
{
    EMMessage *msg = [[EMMessage alloc] initWithReceiver:username bodies:[NSArray arrayWithObject:body]];
    
    EMMessage *message = [[EaseMob sharedInstance].chatManager asyncSendMessage:msg progress:nil];
    
    return message;
}

// 跳转发送消息页面
+(void)sendMessageWithUsername:(NSString *)username
                 andIsChatroom:(BOOL)isChatroom
{
    NSString *toUsername = username;
    NSNumber *isChatroomMessage = [NSNumber numberWithBool:isChatroom];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys: toUsername,WILLSENDMESSAGETOUSERNAME, isChatroomMessage, WILLSENDMESSAGETOUSERNAME_CHATROOMMESSAGE, nil];
    [self performSelector:@selector(sendWithUserInfo:) withObject:userInfo afterDelay:0.05];
}

+(void)sendWithUserInfo:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NTF_WILLSENDMESSAGETOUSERNAME object:nil userInfo:userInfo];
}

@end
