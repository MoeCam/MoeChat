//
//  EMChatManagerChatDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/16/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMChatManagerDelegateBase.h"

@class EMMessage;
@class EMConversation;
@class EMError;
@class EMReceiptReq;
@class EMReceiptResp;

/**
 *  本协议包括：发送消息时的回调、接收到消息时的回调等其它操作
 */
@protocol EMChatManagerChatDelegate <EMChatManagerDelegateBase>

@optional
// message delegate
-(void)willSendMessage:(EMMessage *)message 
        inConversation:(EMConversation *)conversation 
                 error:(EMError *)error;
-(void)didSendMessage:(EMMessage *)message 
       inConversation:(EMConversation *)conversation 
                error:(EMError *)error;

-(void)didReceiveMessage:(EMMessage *)message 
          inConversation:(EMConversation *)conversation;

-(void)didFetchMessage:(EMMessage *)message 
                 error:(EMError *)error;

// ack
-(void)didReceiveReceiptReq:(EMReceiptReq *)req;
-(void)didReceiveReceiptResp:(EMReceiptResp *)resp;

// conversation delegate
-(void)didUpdateConversationList:(NSArray *)conversationList;
-(void)didUnreadMessagesCountChanged;

@end
