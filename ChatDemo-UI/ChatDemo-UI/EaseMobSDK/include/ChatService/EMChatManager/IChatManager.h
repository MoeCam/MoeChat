/*!
 @header IChatManager.h
 @abstract 此接口提供了聊天的基本操作
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "IChatManagerChat.h"
#import "IChatManagerEncryption.h"
#import "IChatManagerConversation.h"
#import "IChatManagerMedia.h"
#import "IChatManagerUtil.h"
#import "IChatManagerLogin.h"
#import "IChatManagerBuddy.h"

/*!
 @protocol
 @abstract 登录、聊天、保存会话、加解密、多媒体支持等协议的集合
 @discussion 可以通过EaseMob类获得此接口的实例, 示例代码如下:
                [[EaseMob sharedInstance] chatManager]
 */
@protocol IChatManager <IChatManagerChat,
                        IChatManagerLogin,
                        IChatManagerConversation,
                        IChatManagerEncryption,
                        IChatManagerMedia,
                        IChatManagerUtil,
                        IChatManagerBuddy>
@required

#pragma mark - Chat

/*!
 @method
 @abstract 发送一条消息
 @discussion 待发送的消息对象和发送后的消息对象是同一个对象, 在发送过程中对象属性可能会被更改
 @param message  消息对象(包括from, to, body列表等信息)
 @param progress 发送多媒体信息时的progress回调对象
 @param pError   错误信息
 @result 发送完成后的消息对象
 */
- (EMMessage *)sendMessage:(EMMessage *)message
                 progress:(id<IEMChatProgressDelegate>)progress
                    error:(EMError **)pError;

/*!
 @method
 @abstract 异步方法, 发送一条消息
 @discussion 待发送的消息对象和发送后的消息对象是同一个对象, 在发送过程中对象属性可能会被更改. 在发送过程中, willSendMessage:error:和didSendMessage:error:这两个回调会被触发
 @param message  消息对象(包括from, to, body列表等信息)
 @param progress 发送多媒体信息时的progress回调对象
 @result 发送的消息对象(因为是异步方法, 不能作为发送完成或发送成功失败与否的判断)
 */
- (EMMessage *)asyncSendMessage:(EMMessage *)message
                      progress:(id<IEMChatProgressDelegate>)progress;

/*!
 @method
 @abstract 异步方法, 发送一条消息
 @discussion 待发送的消息对象和发送后的消息对象是同一个对象, 在发送过程中对象属性可能会被更改
 @param message  消息对象(包括from, to, body列表等信息)
 @param progress 发送多媒体信息时的progress回调对象
 @param prepare          将要发送消息前的回调block
 @param aPrepareQueue    回调block时的线程
 @param completion       发送消息完成后的回调
 @param aCompletionQueue 回调block时的线程
 @result 发送的消息对象(因为是异步方法, 不能作为发送完成或发送成功失败与否的判断)
 */
- (EMMessage *)asyncSendMessage:(EMMessage *)message
                      progress:(id<IEMChatProgressDelegate>)progress
                       prepare:(void (^)(EMMessage *message,
                                         EMError *error))prepare
                       onQueue:(dispatch_queue_t)aPrepareQueue
                    completion:(void (^)(EMMessage *message,
                                         EMError *error))completion
                       onQueue:(dispatch_queue_t)aCompletionQueue;

/*!
 @method
 @abstract 发送一个已收到消息的回执到服务器
 @discussion
 @param message 从服务器收到的消息
 @result
 */
- (void)sendReceiptForMessage:(EMMessage *)message;

/*!
 @method
 @abstract 重新发送某一条消息
 @discussion 待发送的消息对象和发送后的消息对象是同一个对象, 在发送过程中对象属性可能会被更改
 @param message  消息对象(包括from, to, body列表等信息)
 @param progress 发送多媒体信息时的progress回调对象
 @param pError   错误信息
 @result
 */
- (EMMessage *)resendMessage:(EMMessage *)message
                   progress:(id<IEMChatProgressDelegate>)progress
                      error:(EMError **)pError;

/*!
 @method
 @abstract 异步方法, 重新发送某一条消息
 @discussion 待发送的消息对象和发送后的消息对象是同一个对象, 在发送过程中对象属性可能会被更改. 在发送过程中, EMChatManagerChatDelegate中的willSendMessage:error:和didSendMessage:error:这两个回调会被触发
 @param message  消息对象(包括from, to, body列表等信息)
 @param progress 发送多媒体信息时的progress回调对象
 @result 发送的消息对象(因为是异步方法, 不能作为发送完成或发送成功失败与否的判断)
 */
- (EMMessage *)asyncResendMessage:(EMMessage *)message
                        progress:(id<IEMChatProgressDelegate>)progress;

/*!
 @method
 @abstract 异步方法, 重新发送某一条消息
 @discussion 待发送的消息对象和发送后的消息对象是同一个对象, 在发送过程中对象属性可能会被更改
 @param message  消息对象(包括from, to, body列表等信息)
 @param progress 发送多媒体信息时的progress回调对象
 @param prepare          将要发送消息前的回调block
 @param aPrepareQueue    回调block时的线程
 @param completion       发送消息完成后的回调
 @param aCompletionQueue 回调block时的线程
 @result 发送的消息对象(因为是异步方法, 不能作为发送完成或发送成功失败与否的判断)
 */
- (EMMessage *)asyncResendMessage:(EMMessage *)message
                        progress:(id<IEMChatProgressDelegate>)progress
                         prepare:(void (^)(EMMessage *message,
                                           EMError *error))prepare
                         onQueue:(dispatch_queue_t)aPrepareQueue
                      completion:(void (^)(EMMessage *message,
                                           EMError *error))completion
                         onQueue:(dispatch_queue_t)aCompletionQueue;

/*!
 @method
 @abstract 将某一条消息转发给另一个聊天用户
 @discussion
 @param message     需要转发的消息对象
 @param username    需要转发给聊天对象的username
 @param isChatroom  是否是转发到一个群组
 @param progress    发送多媒体信息时的progress回调对象
 @param pError      错误信息
 @result 发送的消息对象
 */
- (EMMessage *)forwardMessage:(EMMessage *)message
                          to:(NSString *)username
                  isChatroom:(BOOL)isChatroom
                    progress:(id<IEMChatProgressDelegate>)progress
                       error:(EMError **)pError;

/*!
 @method
 @abstract 异步方法, 将某一条消息转发给另一个聊天用户
 @discussion 待发送的消息对象和发送后的消息对象是同一个对象, 在发送过程中对象属性可能会被更改. 在发送过程中, EMChatManagerChatDelegate中的willSendMessage:error:和didSendMessage:error:这两个回调会被触发
 @param message     需要转发的消息对象
 @param username    需要转发给聊天对象的username
 @param isChatroom  是否是转发到一个群组
 @param progress    发送多媒体信息时的progress回调对象
 @result 发送的消息对象(因为是异步方法, 不能作为发送完成或发送成功失败与否的判断)
 */
- (EMMessage *)asyncForwardMessage:(EMMessage *)message
                               to:(NSString *)username
                       isChatroom:(BOOL)isChatroom
                         progress:(id<IEMChatProgressDelegate>)progress;

/*!
 @method
 @abstract 异步方法, 将某一条消息转发给另一个聊天用户
 @discussion 待发送的消息对象和发送后的消息对象是同一个对象, 在发送过程中对象属性可能会被更改.
 @param message     需要转发的消息对象
 @param username    需要转发给聊天对象的username
 @param isChatroom  是否是转发到一个群组
 @param progress    发送多媒体信息时的progress回调对象
 @param prepare          将要发送消息前的回调block
 @param aPrepareQueue    回调block时的线程
 @param completion       发送消息完成后的回调
 @param aCompletionQueue 回调block时的线程
 @result 发送的消息对象(因为是异步方法, 不能作为发送完成或发送成功失败与否的判断)
 */
- (EMMessage *)asyncForwardMessage:(EMMessage *)message
                               to:(NSString *)username
                       isChatroom:(BOOL)isChatroom
                         progress:(id<IEMChatProgressDelegate>)progress
                          prepare:(void (^)(EMMessage *message,
                                            EMError *error))prepare
                          onQueue:(dispatch_queue_t)aPrepareQueue
                       completion:(void (^)(EMMessage *message,
                                            EMError *error))completion
                          onQueue:(dispatch_queue_t)aCompletionQueue;

#pragma mark - Login

/*!
 @method
 @abstract 在聊天服务器上创建账号
 @discussion
 @param username 用户名
 @param password 密码
 @param aError   错误信息
 @result 是否注册成功
 */
- (BOOL)registerNewAccount:(NSString *)username password:(NSString *)password error:(EMError **)pError;

/*!
 @method
 @abstract 异步方法, 在聊天服务器上创建账号
 @discussion 在注册过程中, EMChatManagerLoginDelegate中的didRegisterNewAccount:password:error:回调会被触发
 @param username 用户名
 @param password 密码
 @result
 */
- (void)asyncRegisterNewAccount:(NSString *)username
                      password:(NSString *)password;

/*!
 @method
 @abstract 异步方法, 使用用户名密码登录聊天服务器
 @discussion
 @param username 用户名
 @param password 密码
 @param completion 回调
 @param aQueue 回调时的线程
 @result
 */
- (void)asyncRegisterNewAccount:(NSString *)username
                      password:(NSString *)password
                withCompletion:(void (^)(NSString *username,
                                         NSString *password,
                                         EMError *error))completion
                       onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 使用用户名密码登录聊天服务器
 @discussion 如果登陆失败, 返回nil
 @param username 用户名
 @param password 密码
 @param aError   错误信息
 @result 登录后返回的用户信息
 */
- (NSDictionary *)loginWithUsername:(NSString *)username
                          password:(NSString *)password
                             error:(EMError **)aError;

/*!
 @method
 @abstract 异步方法, 使用用户名密码登录聊天服务器
 @discussion 在登陆过程中, EMChatManagerLoginDelegate中的didLoginWithInfo:error:回调会被触发
 @param username 用户名
 @param password 密码
 @result
 */
- (void)asyncLoginWithUsername:(NSString *)username
                     password:(NSString *)password;

/*!
 @method
 @abstract 异步方法, 使用用户名密码登录聊天服务器
 @discussion 在登陆过程中, EMChatManagerLoginDelegate中的didLoginWithInfo:error:回调会被触发
 @param username 用户名
 @param password 密码
 @param completion 回调
 @param aQueue 回调时的线程
 @result
 */
- (void)asyncLoginWithUsername:(NSString *)username
                     password:(NSString *)password
                   completion:(void (^)(NSDictionary *loginInfo, EMError *error))completion
                      onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 注销当前登录用户
 @discussion 目前注销信息不可用
 @param pError 错误信息
 @result 返回注销信息
 */
- (NSDictionary *)logoffWithError:(EMError **)pError;

/*!
 @method
 @abstract 异步方法, 注销当前登录用户
 @discussion 在注销过程中, EMChatManagerLoginDelegate中的didLogoffWithError:回调会被触发. 目前注销信息不可用
 @result
 */
- (void)asyncLogoff;

/*!
 @method
 @abstract 异步方法, 注销当前登录用户
 @discussion 目前注销信息不可用
 @param completion 回调
 @param aQueue     回调时的线程
 @result
 */
- (void)asyncLogoffWithCompletion:(void (^)(NSDictionary *info, EMError *error))completion
                         onQueue:(dispatch_queue_t)aQueue;

/*!
 @property
 @abstract 当前登录的用户信息
 */
@property (nonatomic, strong, readonly) NSDictionary *loginInfo;

/*!
 @property
 @abstract 当前是否已有登录的用户
 */
@property (nonatomic, readonly) BOOL isLoggedIn;

/*!
 @property
 @abstract 当前登陆用户的昵称, 默认为用户名
 */
@property (nonatomic, copy) NSString *nickname;

#pragma mark - Conversation

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

/*!
 @method
 @abstract 获取当前登录用户的会话列表
 @discussion
 @result 会话对象列表
 */
- (NSArray *)loadAllConversations;

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

/*!
 @property
 @abstract 当前登陆用户的会话对象列表
 */
@property (nonatomic, readonly) NSArray *conversations;

#pragma mark - Encryption

/*!
 @method
 @abstract 对未加密的消息进行加密
 @discussion 如果消息已经加密,此方法不进行二次加密
 @param aMessage 要被加密的消息
 @param aKey 密钥
 @result 加密后的消息对象
 */
- (EMMessage *)encryptMessage:(EMMessage *)aMessage forKey:(NSData *)aKey;

/*!
 @method
 @abstract 对加密的消息进行解密
 @discussion 如果消息未被加密,此方法不进行解密
 @param aMessage 要被解密的消息
 @param aKey 密钥
 @result 解密后的消息对象
 */
- (EMMessage *)decryptMessage:(EMMessage *)aMessage forKey:(NSData *)aKey;

/*!
 @property
 @abstract 加解密器
 */
@property (nonatomic, strong) id<IEMChatCryptor> chatCryptor;

#pragma mark - Media

/*!
 @property
 @abstract 是否正在播放音频
 */
@property (nonatomic, readonly) BOOL isPlayingAudio;

/*!
 @method
 @abstract 收到新消息时, 播放声音提示
 @discussion
 @result
 */
- (void)playNewMessageSound;

/*!
 @method
 @abstract 异步方法, 收到新消息时, 播放声音提示
 @discussion 播放完成后, EMChatManagerDelegateMedia中的didPlaySystemSound:回调会被触发
 @result
 */
- (void)asyncPlayNewMessageSound;

/*!
 @method
 @abstract 异步方法, 收到新消息时, 播放声音提示
 @discussion
 @param completion 回调
 @param aQueue     回调时的线程
 @result
 */
- (void)asyncPlayNewMessageWithCompletion:(void (^)(SystemSoundID soundId))completion
                                 onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 收到新消息时, 播放震动提示
 @discussion
 @result
 */
- (void)playVibration;

/*!
 @method
 @abstract 异步方法, 收到新消息时, 播放震动提示
 @discussion 播放完成后, EMChatManagerDelegateMedia中的didPlaySystemSound:回调会被触发
 @result
 */
- (void)asyncPlayVibration;

/*!
 @method
 @abstract 异步方法, 收到新消息时, 播放震动提示
 @discussion
 @param completion 回调
 @param aQueue     回调时的线程
 @result
 */
- (void)asyncPlayVibrationWithCompletion:(void (^)(SystemSoundID soundId))completion
                                onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 判断是否正在播放该聊天声音
 @discussion
 @param aChatVoice 聊天记录声音对象
 @result 是否正在播放该声音对象
 */
- (BOOL)isPlayingAudioChat:(EMChatVoice *)aChatVoice;

/*!
 @method
 @abstract 判断是否正在播放音频
 @discussion
 @result 是否正在播放声音对象
 */
- (BOOL)isPlayingAudio;

/*!
 @method
 @abstract 异步方法, 播放一个聊天记录的声音对象
 @discussion 播放完成后, EMChatManagerDelegateMedia中的didPlayAudio:error:回调会被触发
 @param aChatVoice 需要播放的聊天音频对象
 @result
 */
- (void)asyncPlayAudio:(EMChatVoice *)aChatVoice;

/*!
 @method
 @abstract 异步方法, 播放一个聊天记录的声音对象
 @discussion
 @param aChatVoice 需要播放的聊天音频对象
 @param completion 回调
 @param aQueue     回调时的线程
 @result
 */
- (void)asyncPlayAudio:(EMChatVoice *)aChatVoice
           completion:(void (^)(EMError *error))completion
              onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 停止当前正在播放的音频
 @discussion
 @result 是否成功停止了语音的播放
 */
- (BOOL)stopPlayingAudio;

/*!
 @method
 @abstract 开始录制音频
 @discussion
 @param pError 错误信息
 @result
 */
- (void)startRecordingAudioWithError:(EMError **)pError;

/*!
 @method
 @abstract 异步方法, 停止录制音频
 @discussion 录制完成后, EMChatManagerDelegateMedia中的didRecordAudio:error:回调会被触发
 @result
 */
- (void)asyncStopRecordingAudio;

/*!
 @method
 @abstract 异步方法, 停止录制音频
 @discussion
 @param completion 回调
 @param aQueue     回调时的线程
 @result
 */
- (void)asyncStopRecordingAudioWithCompletion:(void (^)(EMChatVoice *aChatVoice,
                                                       EMError *error))completion
                                     onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 异步方法, 取消录制音频
 @discussion 取消录制后, EMChatManagerDelegateMedia中的didCancelRecordAudio:error:回调会被触发
 @result
 */
- (void)asyncCancelRecordingAudio;

/*!
 @method
 @abstract 异步方法, 取消录制音频
 @discussion
 @param completion 回调
 @param aQueue     回调时的线程
 @result
 */
- (void)asyncCancelRecordingAudioWithCompletion:(void (^)(EMChatVoice *aChatVoice,
                                                         EMError *error))completion
                                       onQueue:(dispatch_queue_t)aQueue;

/*!
 @method
 @abstract 获取录制音频时的音量
 @discussion 停止录音后, 再去调用该方法, 会返回最后一次录制音频的音量
 @result 音量, 值域为0到1.0的浮点数
 */
- (double)peekRecorderVoiceMeter;

#pragma mark - IChatManagerBuddy

@property (nonatomic, strong, readonly) NSArray *buddyList;
@property (nonatomic, strong, readonly) NSArray *groupList;

- (BOOL)addBuddy:(NSString *)username
    withNickName:(NSString *)nickname
         message:(NSString *)message
           error:(EMError **)error;

- (BOOL)addBuddy:(NSString *)username
    withNickName:(NSString *)nickname
         message:(NSString *)message
        toGroups:(NSArray *)groupNames
           error:(EMError **)error;

- (BOOL)removeBuddy:(NSString *)username
              error:(EMError **)error;

- (BOOL)acceptBuddyRequest:(NSString *)username
                     error:(EMError **)error;

- (BOOL)rejectBuddyRequest:(NSString *)username
                     error:(EMError **)error;

#pragma mark - Util

@end
