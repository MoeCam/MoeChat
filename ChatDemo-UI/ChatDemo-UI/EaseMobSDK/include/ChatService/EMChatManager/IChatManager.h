//
//  IChatManager.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IChatManagerChat.h"
#import "IChatManagerEncryption.h"
#import "IChatManagerConversation.h"
#import "IChatManagerMedia.h"
#import "IChatManagerUtil.h"
#import "IChatManagerLogin.h"

/**
 *  登录、聊天、保存会话、加解密、多媒体支持等协议的集合
 */
@protocol IChatManager <IChatManagerChat,
                        IChatManagerLogin,
                        IChatManagerConversation,
                        IChatManagerEncryption,
                        IChatManagerMedia,
                        IChatManagerUtil>
@required

@end
