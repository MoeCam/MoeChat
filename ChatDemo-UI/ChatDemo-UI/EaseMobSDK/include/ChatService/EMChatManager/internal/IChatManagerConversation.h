//
//  IChatManagerConversation.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IChatManagerBase.h"

/**
 *  本协议主要用于聊天DB的操作, 包括获取聊天记录、保存聊天记录、删除聊天记录、获取聊天未读记录的条数等
 */
@class EMConversation;
@class EMMessage;
@protocol IChatManagerConversation <IChatManagerBase>

@required
#pragma mark - conversation
#pragma mark - in memory operations

/**
 *  从db中获取某个用户的聊天记录
 *
 *  @param username 需要获取聊天记录的用户名
 *
 *  @return 聊天记录对象
 */
-(EMConversation *)conversationForChatter:(NSString *)username;

/**
 *  从db中获取用户数组中的聊天记录
 *
 *  @param usernames 用户名数组
 *
 *  @return 聊天记录对象列表
 */
-(NSArray *)conversationsForChatters:(NSArray *)usernames;

#pragma mark - db operations
#pragma mark - load
/**
 *  获取当前登录用户的所有聊天记录
 *
 *  @return 所有聊天记录
 */
-(NSArray *)loadAllConversations;

#pragma mark - save
/**
 *  保存所有聊天信息到db
 *
 *  @return 保存成功的聊天记录数量
 */
-(NSInteger)saveAllConversations;

/**
 *  保存单个会话信息到db(对db中取出的数据修改后, 需要调用该方法)
 *
 *  @param conversation 需要保存的会话信息
 *
 *  @return 保存成功或失败
 */
-(BOOL)saveConversation:(EMConversation *)conversation;

/**
 *  保存多个会话信息到db
 *
 *  @param conversations 需要保存的会话列表
 *
 *  @return 保存成功的会话数量
 */
-(NSInteger)saveConversations:(NSArray *)conversations;

#pragma mark - remove
-(BOOL)removeConversationByChatter:(NSString *)chatter deleteMessages:(BOOL)aDeleteMessages;
-(NSUInteger)removeConversationsByChatters:(NSArray *)chatters deleteMessages:(BOOL)aDeleteMessages;

#pragma mark - message counter
/**
 *  获取总的未读消息数量
 *
 *  @return 未读消息数量
 */
-(NSUInteger)totalUnreadMessagesCount;

/**
 *  获取单个聊天对象的未读消息数量
 *
 *  @param chatter
 *
 *  @return
 */
-(NSUInteger)unreadMessagesCountForConversation:(NSString *)chatter;

/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
-(NSUInteger)unreadConversationsCount;

#pragma mark - properties
/**
 *  <#Description#>
 */
@property (nonatomic, readonly) NSArray *conversations;

@end
