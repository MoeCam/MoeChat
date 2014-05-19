/*!
 @header EMChatManagerDelegate.h
 @abstract 关于ChatManager的异步回调内部协议
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatManagerChatDelegate.h"
#import "EMChatManagerEncryptionDelegate.h"
#import "EMChatManagerMediaDelegate.h"
#import "EMChatManagerLoginDelegate.h"
#import "EMChatManagerBuddyDelegate.h"

/*!
 @protocol
 @brief 本协议包括：收发消息, 登陆注销, 加密解密, 媒体操作的回调等其它操作
 @discussion
 */
@protocol EMChatManagerDelegate <EMChatManagerChatDelegate,
                                EMChatManagerLoginDelegate, 
                                EMChatManagerEncryptionDelegate,
                                EMChatManagerMediaDelegate,
                                EMChatManagerBuddyDelegate>

@optional

#pragma mark - Chat delegate

/*!
 @method
 @brief 将要发送消息时的回调
 @discussion
 @param message      将要发送的消息对象
 @param error        错误信息
 @result
 */
- (void)willSendMessage:(EMMessage *)message
                 error:(EMError *)error;

/*!
 @method
 @brief 发送消息后的回调
 @discussion
 @param message      已发送的消息对象
 @param error        错误信息
 @result
 */
- (void)didSendMessage:(EMMessage *)message
                error:(EMError *)error;

/*!
 @method
 @brief 收到消息时的回调
 @discussion 当EMConversation对象的enableReceiveMessage属性为YES时, 会触发此回调
 @param message      消息对象
 @result
 */
- (void)didReceiveMessage:(EMMessage *)message;

/*!
 @method
 @brief 收到"已读回执"时的回调方法
 @discussion 发送方收到接收方发送的一个收到消息的回执, 意味着接收方已阅读了该消息
 @param resp 收到的"已读回执"对象, 包括 from, to, chatId等
 @result
 */
- (void)didReceiveHasReadResponse:(EMReceiptResp *)resp;

/*!
 @method
 @brief 会话列表信息更新时的回调
 @discussion 1. 当会话列表有更改时(新添加,删除), 2. 登陆成功时, 以上两种情况都会触发此回调
 @param conversationList 会话列表
 @result
 */
- (void)didUpdateConversationList:(NSArray *)conversationList;

/*!
 @method
 @brief 未读消息数改变时的回调
 @discussion 当EMConversation对象的enableUnreadMessagesCountEvent为YES时,会触发此回调
 @result
 */
- (void)didUnreadMessagesCountChanged;

#pragma mark - Login delegate

/*!
 @method
 @brief 用户登录后的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error        错误信息
 @result
 */
- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error;

/*!
 @method
 @brief 用户注销后的回调
 @discussion
 @param error        错误信息
 @result
 */
- (void)didLogoffWithError:(EMError *)error;

/*!
 @method
 @brief 修改密码后的回调
 @discussion
 @param aLoginInfo 登录的用户信息
 @param aError     错误信息
 @result
 */
- (void)didChangePassword:(NSDictionary *)aLoginInfo
                   error:(EMError *)aError;

/*!
 @method
 @brief 当前登录账号在其它设备登录时的通知回调
 @discussion
 @result
 */
- (void)didLoginFromOtherDevice;

#pragma mark - Encryption delegate

#pragma mark - Media delegate

/*!
 @method
 @brief 播放完系统声音时的回调
 @discussion
 @param soundId      iOS内部声音文件ID
 @result
 */
- (void)didPlaySystemSound:(SystemSoundID)soundId;

/*!
 @method
 @brief 播放完声音对象时的回调
 @discussion
 @param aChatVoice 声音对象
 @param error 错误信息
 @result
 */
- (void)didPlayAudio:(EMChatVoice *)aChatVoice error:(EMError *)error;

/*!
 @method
 @brief 录制声音完成后的回调
 @discussion
 @param aChatVoice 录制完的音频对象
 @param error 错误信息
 @result
 */
- (void)didRecordAudio:(EMChatVoice *)aChatVoice error:(EMError *)error;

/*!
 @method
 @brief 取消录音后的回调
 @discussion
 @param aChatVoice 录制完的音频对象
 @param error 错误信息
 @result
 */
- (void)didCancelRecordAudio:(EMChatVoice *)aChatVoice error:(EMError *)error;

#pragma mark - EMChatManagerBuddyDelegate

/*!
 @method
 @brief 接收到好友请求时的通知
 @discussion
 @param username 发起好友请求的用户username
 @param message  收到好友请求时的say hello消息
 */
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message;

/*!
 @method
 @brief 通讯录信息发生变化时的通知
 @discussion
 @param buddyList 好友信息列表
 @param changedBuddies 修改了的用户列表
 @param isAdd (YES为新添加好友, NO为删除好友)
 */
- (void)didUpdateBuddyList:(NSArray *)buddyList
            changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd;

/*!
 @method
 @brief 好友分组信息发生变化时的通知
 @discussion
 @param buddyGroupList 好友分组信息
 @since 
 */
- (void)didUpdateBuddyGroupList:(NSArray *)buddyGroupList;

/*!
 @method
 @brief 好友上线和下线时的通知
 @discussion
 @param isOnline 好友信息列表
 @param username 修改了状态的用户
 */
- (void)didChangedOnlineStatus:(BOOL)isOnline
                      forBuddy:(NSString *)username;

@end
