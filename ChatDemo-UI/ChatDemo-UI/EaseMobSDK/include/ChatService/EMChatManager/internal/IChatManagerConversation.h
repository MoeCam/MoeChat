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
-(EMConversation *)conversationForChatter:(NSString *)username;

-(NSArray *)conversationsForChatters:(NSArray *)usernames;

#pragma mark - db operations
#pragma mark - load
-(NSArray *)loadAllConversations;

#pragma mark - save
-(NSInteger)saveAllConversations;

-(BOOL)saveConversation:(EMConversation *)conversation;

-(NSInteger)saveConversations:(NSArray *)conversations;

#pragma mark - remove
-(BOOL)removeConversationByChatter:(NSString *)chatter deleteMessages:(BOOL)aDeleteMessages;
-(NSUInteger)removeConversationsByChatters:(NSArray *)chatters deleteMessages:(BOOL)aDeleteMessages;

#pragma mark - message counter
-(NSUInteger)totalUnreadMessagesCount;
-(NSUInteger)unreadMessagesCountForConversation:(NSString *)chatter;
-(NSUInteger)unreadConversationsCount;

#pragma mark - properties
@property (nonatomic, readonly) NSArray *conversations;

@end
