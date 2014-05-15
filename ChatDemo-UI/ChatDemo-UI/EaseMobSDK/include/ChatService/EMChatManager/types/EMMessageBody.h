/*!
 @header EMMessageBody.h
 @abstract 聊天消息体对象基类类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatServiceDefs.h"

@class EMMessage;
@class EMChatObject;

/*!
 @class
 @abstract 聊天的消息体基类对象
 */
@interface EMMessageBody : NSObject

/*!
 @property
 @abstract 消息体的类型
 */
@property (nonatomic, readonly) MessageBodyType messageBodyType;

/*!
 @property
 @abstract 消息体的底层聊天对象
 */
@property (nonatomic, strong, readonly) EMChatObject *chatObject;

/*!
 @property
 @abstract 消息体所在的消息对象
 */
@property (nonatomic, weak) EMMessage *message;

/*!
 @method
 @abstract 由聊天对象构造消息体对象
 @discussion 派生类需要改写此方法
 @param aChatObject 聊天对象
 @result 消息体对象
 */
- (id)initWithChatObject:(EMChatObject *)aChatObject;

@end
