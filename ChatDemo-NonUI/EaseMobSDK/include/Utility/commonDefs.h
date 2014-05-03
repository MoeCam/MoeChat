//
//  commonDefs.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#ifndef EaseMobClientSDK_commonDefs_h
#define EaseMobClientSDK_commonDefs_h

#define kEaseMobAppKey [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_APPKEY"]
#define kUserServiceFactoryClassName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_USERSERVICE_FACTORY_CLASS"]

#define kSDKPassword   @"password"
#define kSDKUsername   @"username"

#pragma mark - buddy chatting state
typedef enum _EMChatState {
    eChatState_Stopped = 0,
    eChatState_Composing,
    eChatState_Paused,
}EMChatState;

#pragma mark - buddy online state
typedef enum _EMOnlineStatus {
    eOnlineStatus_OffLine = 0,
    eOnlineStatus_Online,
    eOnlineStatus_Away,
    eOnlineStatus_Busy,
    eOnlineStatus_Invisible,
    eOnlineStatus_Do_Not_Disturb
}EMOnlineStatus;

#endif
