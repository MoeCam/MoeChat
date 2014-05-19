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
 @brief 聊天的文本消息体对象
 */
@interface EMTextMessageBody : EMMessageBody

/*!
 @property
 @brief 文本消息体的内部文本对象的文本
 */
@property (nonatomic, readonly) NSString *text;

/*!
 @method
 @brief 以文本对象创建文本消息体实例
 @discussion
 @param aChatText 文本对象
 @result 文本消息体
 */
- (id)initWithChatObject:(EMChatText *)aChatText;

/*!
 @method
 @brief
    由字典创建消息体对象
 @discussion
    派生类需要改写此方法,此方法用于从远端发来的消息来构建消息体对象
 @param aBodyDict
    消息体对象字典
 @param aMessageDict
    消息对象字典
 @result
    消息体对象
 */
- (id)initWithBodyDict:(NSDictionary *)aBodyDict messageDict:(NSDictionary *)aMessageDict;

/*!
 @method
 @brief
    将文本消息体转为字典对象
 @discussion
    此方法用于发送消息过程中
 @result
    带有文本消息体信息的字典对象
 */
- (NSDictionary *)toDictionary;

@end
