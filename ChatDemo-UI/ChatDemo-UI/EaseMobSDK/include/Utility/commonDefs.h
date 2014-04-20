//
//  commonDefs.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#ifndef EaseMobClientSDK_commonDefs_h
#define EaseMobClientSDK_commonDefs_h

#define kEaseMobChatDomain [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_CHAT_DOMAIN"]
#define kEaseMobChatroomDomain [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_CHATROOM_DOMAIN"]
#define kEaseMobChatAddress [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_CHAT_ADDRESS"]
#define kEaseMobChatPort [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_CHAT_PORT"] integerValue]
#define kEaseMobStorageUrl [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_STORAGE_URL"]

#endif
