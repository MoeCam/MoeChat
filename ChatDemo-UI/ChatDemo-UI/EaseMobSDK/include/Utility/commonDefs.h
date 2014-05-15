/*!
 @header commonDefs.h
 @abstract 用户在线状态及聊天状态定义
 @author Ji Fang
 @version 1.0
 */
#ifndef EaseMobClientSDK_commonDefs_h
#define EaseMobClientSDK_commonDefs_h

#define kEaseMobAppKey [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_APPKEY"]
#define kUserServiceFactoryClassName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_USERSERVICE_FACTORY_CLASS"]

#define kSDKPassword   @"password"
#define kSDKUsername   @"username"

#pragma mark - buddy chatting state
typedef enum {
    eChatState_Stopped = 0,
    eChatState_Composing,
    eChatState_Paused,
}EMChatState;

#pragma mark - buddy online state
typedef enum {
    eOnlineStatus_OffLine = 0,
    eOnlineStatus_Online,
    eOnlineStatus_Away,
    eOnlineStatus_Busy,
    eOnlineStatus_Invisible,
    eOnlineStatus_Do_Not_Disturb
}EMOnlineStatus;

#endif
