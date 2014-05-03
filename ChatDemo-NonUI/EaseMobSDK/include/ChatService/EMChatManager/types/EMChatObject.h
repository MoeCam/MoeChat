/*!
 @header EMChatObject.h
 @abstract 聊天对象基类
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>

/*!
 @class 
 @abstract 聊天对象的基类类型
 */
@interface EMChatObject : NSObject {
    BOOL _isEncrypted;
}

/*!
 @property
 @abstract 聊天对象是否已加密
 */
@property (nonatomic) BOOL isEncrypted;

@end
