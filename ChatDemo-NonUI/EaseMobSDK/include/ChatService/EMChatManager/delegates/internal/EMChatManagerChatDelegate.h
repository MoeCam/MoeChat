/*!
 @header EMChatManagerChatDelegate.h
 @abstract 关于ChatManager中聊天相关功能的异步回调
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatManagerDelegateBase.h"

@class EMMessage;
@class EMConversation;
@class EMError;
@class EMReceiptReq;
@class EMReceiptResp;

/*!
 @protocol
 @abstract 本协议包括：发送消息时的回调、接收到消息时的回调等其它操作
 @discussion
 */
@protocol EMChatManagerChatDelegate <EMChatManagerDelegateBase>

@optional

/*!
 @method
 @abstract 将要发送消息时的回调
 @discussion
 @param message      将要发送的消息对象
 @param error        错误信息
 @result
 */
- (void)willSendMessage:(EMMessage *)message
                 error:(EMError *)error;

/*!
 @method
 @abstract 发送消息后的回调
 @discussion
 @param message      已发送的消息对象
 @param error        错误信息
 @result
 */
- (void)didSendMessage:(EMMessage *)message
                error:(EMError *)error;

/*!
 @method
 @abstract 收到消息时的回调
 @discussion 当EMConversation对象的enableReceiveMessage属性为YES时, 会触发此回调
 @param message      消息对象
 @result
 */
- (void)didReceiveMessage:(EMMessage *)message;

/*!
 @method
 @abstract 收到回执请求时的回调方法
 @discussion 接收方收到发送方的回执请求消息, 可以选择发送回执响应给发送方. 如发送方未收到接收方返回的回执响应, 则用户下次登录后, 仍会收到该消息
 @param req 收到的回执请求对象
 @result
 */
- (void)didReceiveReceiptReq:(EMReceiptReq *)req;

/*!
 @method
 @abstract 收到回执响应时的回调方法
 @discussion 发送方收到接收方发送的一个收到消息的回执, 意味着接收方已阅读了该消息
 @param resp 收到的回执响应对象
 @result
 */
- (void)didReceiveReceiptResp:(EMReceiptResp *)resp;

/*!
 @method
 @abstract 会话列表信息更新时的回调
 @discussion 1. 当会话列表有更改时(新添加,删除), 2. 登陆成功时, 以上两种情况都会触发此回调
 @param conversationList 会话列表
 @result
 */
- (void)didUpdateConversationList:(NSArray *)conversationList;

/*!
 @method
 @abstract 未读消息数改变时的回调
 @discussion 当EMConversation对象的enableUnreadMessagesCountEvent为YES时,会触发此回调
 @result
 */
- (void)didUnreadMessagesCountChanged;

@end
