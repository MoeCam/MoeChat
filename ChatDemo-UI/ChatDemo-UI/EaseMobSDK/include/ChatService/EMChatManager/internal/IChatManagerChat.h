//
//  IChatManagerChat.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IChatManagerBase.h"

@class EMMessage;
@class EMConversation;
@class EMError;
@protocol IEMChatProgressDelegate;

/**
 *  用户聊天协议, 用于发送信息, 下载多媒体信息等支持
 */
@protocol IChatManagerChat <IChatManagerBase>

@required
#pragma mark - send message
-(EMMessage *)sendMessage:(EMMessage *)message
                 progress:(id<IEMChatProgressDelegate>)progress
                    error:(EMError **)pError;
-(EMMessage *)asyncSendMessage:(EMMessage *)message
                      progress:(id<IEMChatProgressDelegate>)progress;
-(EMMessage *)asyncSendMessage:(EMMessage *)message
                           progress:(id<IEMChatProgressDelegate>)progress
                            prepare:(void (^)(EMMessage *message, 
                                              EMConversation *conversation, 
                                              EMError *error))prepare
                            onQueue:(dispatch_queue_t)aPrepareQueue
                         completion:(void (^)(EMMessage *message,
                                              EMConversation *conversation,
                                              EMError *error))completion
                            onQueue:(dispatch_queue_t)aCompletionQueue;

#pragma mark - message ack
-(void)sendReceiptForMessage:(EMMessage *)message;

#pragma mark - resend message
-(EMMessage *)resendMessage:(EMMessage *)message
                        progress:(id<IEMChatProgressDelegate>)progress
                           error:(EMError **)pError;
-(EMMessage *)asyncResendMessage:(EMMessage *)message
                             progress:(id<IEMChatProgressDelegate>)progress;
-(EMMessage *)asyncResendMessage:(EMMessage *)message
                             progress:(id<IEMChatProgressDelegate>)progress 
                              prepare:(void (^)(EMMessage *message, 
                                                EMConversation *conversation, 
                                                EMError *error))prepare
                              onQueue:(dispatch_queue_t)aPrepareQueue
                           completion:(void (^)(EMMessage *message, 
                                                EMConversation *conversation, 
                                                EMError *error))completion
                              onQueue:(dispatch_queue_t)aCompletionQueue;

#pragma mark - forward message
-(EMMessage *)forwardMessage:(EMMessage *)message
                               to:(NSString *)username
                       isChatroom:(BOOL)isChatroom
                         progress:(id<IEMChatProgressDelegate>)progress
                            error:(EMError **)pError;
-(EMMessage *)asyncForwardMessage:(EMMessage *)message
                                    to:(NSString *)username 
                            isChatroom:(BOOL)isChatroom
                              progress:(id<IEMChatProgressDelegate>)progress;
-(EMMessage *)asyncForwardMessage:(EMMessage *)message 
                                    to:(NSString *)username 
                            isChatroom:(BOOL)isChatroom
                              progress:(id<IEMChatProgressDelegate>)progress
                               prepare:(void (^)(EMMessage *message, 
                                                 EMConversation *conversation, 
                                                 EMError *error))prepare
                               onQueue:(dispatch_queue_t)aPrepareQueue
                            completion:(void (^)(EMMessage *message, 
                                                 EMConversation *conversation, 
                                                 EMError *error))completion
                               onQueue:(dispatch_queue_t)aCompletionQueue;

#pragma mark - fetch message
-(EMMessage *)fetchMessage:(EMMessage *)message
                  progress:(id<IEMChatProgressDelegate>)progress
                     error:(EMError **)pError;
-(void)asyncFetchMessage:(EMMessage *)message
                progress:(id<IEMChatProgressDelegate>)progress;
-(void)asyncFetchMessage:(EMMessage *)message
                progress:(id<IEMChatProgressDelegate>)progress
              completion:(void (^)(EMMessage *message, EMError *error))completion
                 onQueue:(dispatch_queue_t)aQueue;

@end
