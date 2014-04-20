//
//  EMChatServiceDefs.h
//  EaseMobClientSDK
//
//  Created by jifang on 2/12/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#ifndef EaseMobClientSDK_EMChatServiceDefs_h
#define EaseMobClientSDK_EMChatServiceDefs_h

#import "commonDefs.h"

typedef enum _MessageType {
    eMessageType_Text = 1,
    eMessageType_Image,
    eMessageType_Video,
    eMessageType_Location,
    eMessageType_Voice,
    eMessageType_File,
    eMessageType_Command
}MessageType;

typedef enum _MessageDeliveryState {
    eMessageDeliveryState_Pending = 0, 
    eMessageDeliveryState_Delivering, 
    eMessageDeliveryState_Delivered, 
    eMessageDeliveryState_Failure
}MessageDeliveryState;

#define kChatManagerLoginInfoUsername @"kChatManagerLoginInfoUsername"
#define kChatManagerLoginInfoPassword @"kChatManagerLoginInfoPassword"

#endif
