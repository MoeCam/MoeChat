//
//  ChatSendHelper.m
//  leCar
//
//  Created by dujiepeng on 14-3-22.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "ChatSendHelper.h"
#import "EMMessageBody.h"
#import "EMMessage.h"
#import "EMChatText.h"
#import "EMTextMessageBody.h"
#import "EaseMob.h"

@implementation ChatSendHelper

+(EMMessage *)sendTextMessageWithString:(NSString *)str
                             toUsername:(NSString *)username{
    
    EMChatText *text = [[EMChatText alloc] initWithText:str];
    EMMessageBody *body = [[EMTextMessageBody alloc] initWithMessage:text];
    return [self sendMessage:username messageBody:body];
}

// 发送消息
+(EMMessage *)sendMessage:(NSString *)username
              messageBody:(EMMessageBody *)body{
    NSDictionary *userInfo = [[EaseMob sharedInstance].userManager loginInfo];
    NSString *sender = [userInfo objectForKey:kUserLoginInfoUsername];
 
    EMMessage *msg = [[EMMessage alloc] initWithSender:sender
                                              receiver:username
                                                bodies:[NSArray arrayWithObject:body]];
    
    EMMessage *message = [[EaseMob sharedInstance].chatManager
                          asyncSendMessage:msg
                          progress:nil];
    
    return message;
}

// 跳转发送消息页面
+(void)sendMessageWithUsername:(NSString *)username
                 andIsChatroom:(BOOL)isChatroom{
    NSString *toUsername = username;
    NSNumber *isChatroomMessage = [NSNumber numberWithBool:isChatroom];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              toUsername,WILLSENDMESSAGETOUSERNAME,
                              isChatroomMessage, WILLSENDMESSAGETOUSERNAME_CHATROOMMESSAGE,
                              nil];
    [self performSelector:@selector(sendWithUserInfo:)
               withObject:userInfo
               afterDelay:0.05];
}

+(void)sendWithUserInfo:(NSDictionary *)userInfo{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:NTF_WILLSENDMESSAGETOUSERNAME
     object:nil
     userInfo:userInfo];
}

@end
