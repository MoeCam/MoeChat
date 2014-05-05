/*!
 @header EMMessageBody.h
 @abstract 聊天消息体对象基类类型
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatServiceDefs.h"
#import "EMChatObject.h"

/*!
 @class
 @abstract 聊天的消息体基类对象
 */
@interface EMMessageBody : NSObject {
    EMChatObject *_message;
}

/*!
 @property
 @abstract 消息体的类型
 */
@property (nonatomic, readonly) MessageType messageType;

/*!
 @property
 @abstract 消息体的底层聊天对象
 */
@property (nonatomic, strong, readonly) EMChatObject *message;

/*!
 @property
 @abstract 消息体是否被加密
 */
@property (nonatomic, readonly) BOOL isEncrypted;

@end
