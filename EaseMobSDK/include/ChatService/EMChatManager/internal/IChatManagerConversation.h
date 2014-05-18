/*!
 @header IChatManagerConversation.h
 @abstract 为ChatManager提供基础会话操作
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "IChatManagerBase.h"

@class EMConversation;
@class EMMessage;

/*!
 @protocol
 @abstract 本协议主要用于聊天数据库的操作, 包括获取会话对象、保存会话对象、删除会话对象、获取会话未读记录的条数等
 @discussion
 */
@protocol IChatManagerConversation <IChatManagerBase>

@required
#pragma mark - conversation
#pragma mark - in memory operations

/*!
 @method
 @abstract 从数据库中获取某个用户的会话
 @discussion
 @param username 需要获取会话对象的用户名
 @result 会话对象
 */
- (EMConversation *)conversationForChatter:(NSString *)username;

/*!
 @method
 @abstract 从数据库中根据用户名列表获取会话对象列表
 @discussion
 @param usernames 用户名列表
 @result 会话对象列表
 */
- (NSArray *)conversationsForChatters:(NSArray *)usernames;

#pragma mark - db operations
#pragma mark - load

/*!
 @method
 @abstract 获取当前登录用户的会话列表
 @discussion
 @result 会话对象列表
 */
- (NSArray *)loadAllConversations;

#pragma mark - save

/*!
 @method
 @abstract 保存当前登录用户的会话列表到数据库
 @discussion
 @result 成功保存的会话对象列表的项数
 */
- (NSInteger)saveAllConversations;

/*!
 @method
 @abstract 保存单个会话对象到数据库
 @discussion 对数据库中取出的数据修改后, 需要调用该方法
 @param conversation 需要保存的会话对象
 @result 保存成功或失败
 */
- (BOOL)saveConversation:(EMConversation *)conversation;

/*!
 @method
 @abstract 保存多个会话对象到数据库
 @discussion
 @param conversations 需要保存的会话对象列表
 @result 保存成功的会话对象个数
 */
- (NSInteger)saveConversations:(NSArray *)conversations;

#pragma mark - remove
/*!
 @method
 @abstract 删除某个会话对象
 @discussion
 @param chatter 这个会话对象所对应的用户名
 @param aDeleteMessages 是否删除这个会话对象所关联的聊天记录
 @result 删除成功或失败
 */
- (BOOL)removeConversationByChatter:(NSString *)chatter deleteMessages:(BOOL)aDeleteMessages;

/*!
 @method
 @abstract 删除某几个会话对象
 @discussion
 @param chatters 这几个要被删除的会话对象所对应的用户名列表
 @param aDeleteMessages 是否删除这个会话对象所关联的聊天记录
 @result 成功删除的会话对象的个数
 */
- (NSUInteger)removeConversationsByChatters:(NSArray *)chatters deleteMessages:(BOOL)aDeleteMessages;

#pragma mark - message counter

/*!
 @method
 @abstract 获取总的未读消息数量
 @discussion
 @result 未读消息数量
 */
- (NSUInteger)totalUnreadMessagesCount;

/*!
 @method
 @abstract 获取单个会话对象的未读消息数量
 @discussion
 @param chatter 此会话对象所对应的用户名
 @result 此绘画对象的未读消息数量
 */
- (NSUInteger)unreadMessagesCountForConversation:(NSString *)chatter;

/*!
 @method
 @abstract 获取当前登录用户所有包含未读消息的会话对象的个数
 @discussion
 @result 当前登录用户所有包含未读消息的会话对象的个数
 */
- (NSUInteger)unreadConversationsCount;

#pragma mark - properties

/*!
 @property
 @abstract 当前登陆用户的会话对象列表
 */
@property (nonatomic, readonly) NSArray *conversations;

@end
