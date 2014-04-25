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

/**
 *  将要发送消息时的回调
 *
 *  @param message      将要发送的消息对象
 *  @param error        错误信息
 */
-(void)willSendMessage:(EMMessage *)message
                 error:(EMError *)error;

/**
 *  发送消息后的回调
 *
 *  @param message      将要发送的消息对象
 *  @param error        错误信息 */
-(void)didSendMessage:(EMMessage *)message
                error:(EMError *)error;

/**
 *  收到消息时的回调
 *
 *  @param message      消息对象
 */
-(void)didReceiveMessage:(EMMessage *)message;

/**
 *  主动获取消息后的回调
 *
 *  @param message 获取到的消息对象
 *  @param error   错误信息
 */
//-(void)didFetchMessage:(EMMessage *)message 
//                 error:(EMError *)error;

/**
 *  收到回执request时的回调方法(即发送方需要接收方发送一个收到消息的回执, 如发送方未收到接收方返回的回执, 则用户下次登录后, 仍会收到该消息)
 *
 *  @param req 收到的回执request对象
 */
-(void)didReceiveReceiptReq:(EMReceiptReq *)req;

/**
 *  收到回执response时的回调方法
 *
 *  @param resp 收到的回执response对象
 */
-(void)didReceiveReceiptResp:(EMReceiptResp *)resp;

/**
 *  会话列表信息更新时的回调
 *
 *  @param conversationList 会话列表
 */
-(void)didUpdateConversationList:(NSArray *)conversationList;

/**
 *  未读消息数改变时的回调
 */
-(void)didUnreadMessagesCountChanged;

@end
