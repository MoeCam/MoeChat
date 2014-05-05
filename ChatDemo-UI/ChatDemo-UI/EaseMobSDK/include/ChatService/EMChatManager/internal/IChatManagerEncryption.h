/*!
 @header IChatManagerEncryption.h
 @abstract 为ChatManager提供基础的加解密操作
 @author Ji Fang
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
 @method
 @abstract 对未加密的消息进行加密
 @discussion 如果消息已经加密,此方法不进行二次加密
 @param aMessage 要被加密的消息
 @param aKey 密钥
 @result 加密后的消息对象
 */
- (EMMessage *)encryptMessage:(EMMessage *)aMessage forKey:(NSData *)aKey;

/*!
 @method
 @abstract 对加密的消息进行解密
 @discussion 如果消息未被加密,此方法不进行解密
 @param aMessage 要被解密的消息
 @param aKey 密钥
 @result 解密后的消息对象
 */
- (EMMessage *)decryptMessage:(EMMessage *)aMessage forKey:(NSData *)aKey;

/*!
 @property
 @abstract 加解密器
 */
@property (nonatomic, strong) id<IEMChatCryptor> chatCryptor;

@end
