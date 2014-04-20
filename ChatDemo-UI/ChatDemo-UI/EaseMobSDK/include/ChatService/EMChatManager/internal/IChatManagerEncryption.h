//
//  IChatManagerEncryption.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IChatManagerBase.h"
#import "IEMChatCryptor.h"

/**
 *  本协议主要处理聊天数据的加密和解密操作
 */
@class EMMessage;
@protocol IChatManagerEncryption <IChatManagerBase>

@required
-(EMMessage *)encryptMessage:(EMMessage *)aMessage forKey:(NSData *)aKey;
-(EMMessage *)decryptMessage:(EMMessage *)aMessage forKey:(NSData *)aKey;

@property (nonatomic, strong) id<IEMChatCryptor> chatCryptor;

@end
