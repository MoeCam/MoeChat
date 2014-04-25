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
@class EMError;
@protocol IEMChatProgressDelegate;

/**
 *  用户聊天协议, 用于发送信息, 下载多媒体信息等支持
 *  所有不带Block回调的异步方法, 需要监听回调时, 需要先将要接受回调的对象注册到delegate中, 示例代码如下:
 *  [[[EaseMob sharedInstance] chatManager] addDelegate:self delegateQueue:dispatch_get_main_queue]
 */
@protocol IChatManagerChat <IChatManagerBase>

@required
#pragma mark - send message
/**
 *  同步方法, 发送一条消息
 *
 *  @param message  消息对象(包括from, to, body等信息)
 *  @param progress 发送多媒体信息时的progress回调对象
 *  @param pError   错误信息
 *
 *  @return 发送完成后的消息对象
 */
-(EMMessage *)sendMessage:(EMMessage *)message
                 progress:(id<IEMChatProgressDelegate>)progress
                    error:(EMError **)pError;

/**
 *  异步方法, 发送一条消息
 *
 *  @param message  消息对象(包括from, to, body等信息)
 *  @param progress 发送多媒体信息时的progress回调对象
 *
 *  @return 发送的消息对象
 */
-(EMMessage *)asyncSendMessage:(EMMessage *)message
                      progress:(id<IEMChatProgressDelegate>)progress;

/**
 *  异步方法, 发送一条消息
 *
 *  @param message  消息对象(包括from, to, body等信息)
 *  @param progress 发送多媒体信息时的progress回调对象
 *  @param prepare          将要发送消息前的回调block
 *  @param aPrepareQueue    回调block时的线程
 *  @param completion       发送消息完成后的回调
 *  @param aCompletionQueue 回调block时的线程
 *
 *  @return 发送的消息对象(因为是异步方法, 不能作为发送完成或发送成功失败与否的判断)
 */
-(EMMessage *)asyncSendMessage:(EMMessage *)message
                           progress:(id<IEMChatProgressDelegate>)progress
                            prepare:(void (^)(EMMessage *message,
                                              EMError *error))prepare
                            onQueue:(dispatch_queue_t)aPrepareQueue
                         completion:(void (^)(EMMessage *message,
                                              EMError *error))completion
                            onQueue:(dispatch_queue_t)aCompletionQueue;

#pragma mark - message ack
/**
 *  发送一个已收到消息的回执到服务器
 *
 *  @param message 从服务器收到的消息
 */
-(void)sendReceiptForMessage:(EMMessage *)message;

#pragma mark - resend message
/**
 *  重新发送某一条消息(发送失败时, 重新发送可调用该方法)
 *
 *  @param message  消息对象(包括from, to, body等信息)
 *  @param progress 发送多媒体信息时的progress回调对象
 *  @param pError   错误信息
 *
 *  @return
 */
-(EMMessage *)resendMessage:(EMMessage *)message
                        progress:(id<IEMChatProgressDelegate>)progress
                           error:(EMError **)pError;
/**
 *  异步方法, 重新发送某一条消息
 *
 *  @param message  消息对象(包括from, to, body等信息)
 *  @param progress 发送多媒体信息时的progress回调对象
 *
 *  @return 发送的消息对象
 */
-(EMMessage *)asyncResendMessage:(EMMessage *)message
                             progress:(id<IEMChatProgressDelegate>)progress;

/**
 *  异步方法, 发送一条消息
 *
 *  @param message  消息对象(包括from, to, body等信息)
 *  @param progress 发送多媒体信息时的progress回调对象
 *  @param prepare          将要发送消息前的回调block
 *  @param aPrepareQueue    回调block时的线程
 *  @param completion       发送消息完成后的回调
 *  @param aCompletionQueue 回调block时的线程
 *
 *  @return 发送的消息对象(因为是异步方法, 不能作为发送完成或发送成功失败与否的判断)
 */
-(EMMessage *)asyncResendMessage:(EMMessage *)message
                             progress:(id<IEMChatProgressDelegate>)progress 
                              prepare:(void (^)(EMMessage *message, 
                                                EMError *error))prepare
                              onQueue:(dispatch_queue_t)aPrepareQueue
                           completion:(void (^)(EMMessage *message,
                                                EMError *error))completion
                              onQueue:(dispatch_queue_t)aCompletionQueue;

#pragma mark - forward message
/**
 *  将某一条消息转发给另一个聊天用户
 *
 *  @param message     需要转发的消息对象
 *  @param username    需要转发给聊天对象的username
 *  @param isChatroom  是否是转发到一个群组
 *  @param progress    发送多媒体信息时的progress回调对象
 *  @param pError      错误信息
 *
 *  @return 发送的消息对象
 */
-(EMMessage *)forwardMessage:(EMMessage *)message
                               to:(NSString *)username
                       isChatroom:(BOOL)isChatroom
                         progress:(id<IEMChatProgressDelegate>)progress
                            error:(EMError **)pError;

/**
 *  将某一条消息转发给另一个聊天用户
 *
 *  @param message          需要转发的消息对象
 *  @param username         需要转发给聊天对象的username
 *  @param isChatroom       是否是转发到一个群组
 *  @param progress         发送多媒体信息时的progress回调对象
 *
 *  @return 发送的消息对象(因为是异步方法, 不能作为发送完成或发送成功失败与否的判断)
 */
-(EMMessage *)asyncForwardMessage:(EMMessage *)message
                                    to:(NSString *)username 
                            isChatroom:(BOOL)isChatroom
                              progress:(id<IEMChatProgressDelegate>)progress;

/**
 *  将某一条消息转发给另一个聊天用户
 *
 *  @param message          需要转发的消息对象
 *  @param username         需要转发给聊天对象的username
 *  @param isChatroom       是否是转发到一个群组
 *  @param progress         发送多媒体信息时的progress回调对象
 *  @param prepare          将要发送消息前的回调block
 *  @param aPrepareQueue    回调block时的线程
 *  @param completion       发送消息完成后的回调
 *  @param aCompletionQueue 回调block时的线程
 *
 *  @return 发送的消息对象(因为是异步方法, 不能作为发送完成或发送成功失败与否的判断)
 */
-(EMMessage *)asyncForwardMessage:(EMMessage *)message 
                                    to:(NSString *)username 
                            isChatroom:(BOOL)isChatroom
                              progress:(id<IEMChatProgressDelegate>)progress
                               prepare:(void (^)(EMMessage *message,
                                                 EMError *error))prepare
                               onQueue:(dispatch_queue_t)aPrepareQueue
                            completion:(void (^)(EMMessage *message,
                                                 EMError *error))completion
                               onQueue:(dispatch_queue_t)aCompletionQueue;

@end
