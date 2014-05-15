/*!
 @header EMTextMessageBody.h
 @abstract 聊天的文本消息体对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import "EMMessageBody.h"

@class EMChatText;

/*!
 @class
 @abstract 聊天的文本消息体对象
 */
@interface EMTextMessageBody : EMMessageBody

/*!
 @property
 @abstract 文本消息体的内部文本对象的文本
 */
@property (nonatomic, readonly) NSString *text;

/*!
 @method
 @abstract 以文本对象创建文本消息体实例
 @discussion
 @param aChatText 文本对象
 @result 文本消息体
 */
- (id)initWithChatObject:(EMChatText *)aChatText;

@end
