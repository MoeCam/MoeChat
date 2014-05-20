/*!
 @header EMMessageBody.h
 @abstract 聊天消息体对象基类类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatServiceDefs.h"

@protocol IEMChatObject;
@class EMMessage;

/*!
 @class
 @brief 聊天的消息体基类对象
 */
@interface EMMessageBody : NSObject {
    id<IEMChatObject> _chatObject;
}

/*!
 @property
 @brief 消息体的类型
 */
@property (nonatomic, readonly) MessageBodyType messageBodyType;

/*!
 @property
 @brief 消息体的底层聊天对象
 */
@property (nonatomic, strong, readonly) id<IEMChatObject> chatObject;

/*!
 @property
 @brief 消息体所在的消息对象
 */
@property (nonatomic, weak) EMMessage *message;

/*!
 @method
 @brief 由聊天对象构造消息体对象
 @discussion 派生类需要改写此方法
 @param aChatObject 聊天对象
 @result 消息体对象
 */
- (id)initWithChatObject:(id<IEMChatObject>)aChatObject;

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
    将消息体转为字典对象
 @discussion
    派生类需要改写此方法,此方法用于发送消息过程中
 @result 
    带有消息体信息的字典对象
 */
- (NSDictionary *)toDictionary;

@end
