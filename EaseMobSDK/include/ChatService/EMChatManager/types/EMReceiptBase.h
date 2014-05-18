/*!
 @header EMReceiptBase.h
 @abstract 聊天回执请求与响应基类
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>

#pragma mark - EMReceipt Base
/*!
 @class
 @abstract 聊天回执基类
 */
@interface EMReceiptBase : NSObject

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
