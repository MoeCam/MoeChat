//
//  IEMChatCryptor.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/16/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IEMChatCryptor <NSObject>

@required
- (NSData *)encryptData:(NSData *)data withKey:(NSData *)key;
- (NSData *)decryptData:(NSData *)data withKey:(NSData *)key;

- (NSString *)encryptString:(NSString *)string withKey:(NSData *)key;
- (NSString *)decryptString:(NSString *)string withKey:(NSData *)key;

@optional
- (NSData *)keyForName:(NSString *)keyName;

@end
