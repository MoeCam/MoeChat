//
//  EMChatManagerDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/15/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMChatManagerChatDelegate.h"
#import "EMChatManagerEncryptionDelegate.h"
#import "EMChatManagerMediaDelegate.h"
#import "EMChatManagerLoginDelegate.h"

/**
 *  本协议主要处理聊天时的一些回调操作（如发送消息成功、收到消息、收到添加好友邀请等消息时的回调操作）
 */
@protocol EMChatManagerDelegate <EMChatManagerChatDelegate,
                                EMChatManagerLoginDelegate, 
                                EMChatManagerEncryptionDelegate,
                                EMChatManagerMediaDelegate>

@optional

@end
