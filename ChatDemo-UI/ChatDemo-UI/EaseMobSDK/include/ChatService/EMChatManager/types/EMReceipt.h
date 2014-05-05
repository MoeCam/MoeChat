/*!
 @header EMReceipt.h
 @abstract 聊天回执请求与响应
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>

#pragma mark - EMReceipt Base
/*!
 @class
 @abstract 聊天回执基类
 */
@interface EMReceipt : NSObject

/*!
 @property
 @abstract 发送方
 */
@property (nonatomic, copy) NSString *from;

/*!
 @property
 @abstract 接收方
 */
@property (nonatomic, copy) NSString *to;

/*!
 @property
 @abstract 此回执关联的聊天ID
 */
@property (nonatomic, copy) NSString *chatId;

/*!
 @property
 @abstract 此回执是否用于群聊
 */
@property (nonatomic) BOOL isChatroom;

/*!
 @property
 @abstract 时间戳, UTC时间, 单位为毫秒
 */
@property (nonatomic) long long timestamp;

@end

@class EMMessage;

#pragma mark - EMReceipt Request

/*!
 @class
 @abstract 聊天回执请求
 */
@interface EMReceiptReq : EMReceipt

/*!
 @method
 @abstract 由消息创建回执请求
 @discussion
 @param message 消息对象
 @result 聊天回执请求实例
 */
+ (EMReceiptReq *)createFromMessage:(EMMessage *)message;

@end

#pragma mark - EMReceipt Response

/*!
 @class
 @abstract 聊天回执响应
 */
@interface EMReceiptResp : EMReceipt

/*!
 @method
 @abstract 由消息创建回执响应
 @discussion
 @param message 消息对象
 @result 聊天回执响应实例
 */
+ (EMReceiptResp *)createFromMessage:(EMMessage *)message;

@end
