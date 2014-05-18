/*!
 @header IChatManagerEncryption.h
 @abstract 为ChatManager提供基础的加解密操作
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "IChatManagerBase.h"
#import "IEMChatCryptor.h"

@class EMMessage;

/*!
 @protocol
 @abstract 本协议主要处理聊天数据的加密和解密操作
 @discussion
 */
@protocol IChatManagerEncryption <IChatManagerBase>

@required

/*!
 @property
 @abstract 加解密器
 */
@property (nonatomic, strong) id<IEMChatCryptor> chatCryptor;

@end
