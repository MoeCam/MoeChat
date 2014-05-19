/*!
 @header EMLocationMessageBody.h
 @abstract 聊天的位置消息体对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import "EMMessageBody.h"

@class EMChatLocation;

/*!
 @class
 @brief 聊天的位置消息体对象
 */
@interface EMLocationMessageBody : EMMessageBody

/*!
 @property
 @brief 纬度
 */
@property (nonatomic, readonly) double latitude;

/*!
 @property
 @brief 经度
 */
@property (nonatomic, readonly) double longitude;

/*!
 @property
 @brief 地理位置信息
 */
@property (nonatomic, readonly) NSString *address;

/*!
 @method
 @brief 以位置对象创建位置消息体实例
 @discussion
 @param aChatLocation 位置对象
 @result 位置消息体
 */
- (id)initWithChatObject:(EMChatLocation *)aChatLocation;

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
    将位置消息体转为字典对象
 @discussion
    此方法用于发送消息过程中
 @result
    带有位置消息体信息的字典对象
 */
- (NSDictionary *)toDictionary;

@end
