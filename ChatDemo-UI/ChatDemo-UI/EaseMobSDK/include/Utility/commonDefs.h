//
//  commonDefs.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#ifndef EaseMobClientSDK_commonDefs_h
#define EaseMobClientSDK_commonDefs_h

#define kEaseMobChatDomain [[NSDictionary dictionaryWithContentsOfURL:\
                            [[NSBundle bundleWithURL:[[NSBundle mainBundle] \
                            URLForResource:@"EaseMob" withExtension:@"bundle"]] \
                            URLForResource:@"SDKConfig" withExtension:@"plist"]] \
                            objectForKey:@"EASEMOB_CHAT_DOMAIN"]

#define kEaseMobChatroomDomain [[NSDictionary dictionaryWithContentsOfURL:\
                                [[NSBundle bundleWithURL:[[NSBundle mainBundle] \
                                URLForResource:@"EaseMob" withExtension:@"bundle"]] \
                                URLForResource:@"SDKConfig" withExtension:@"plist"]] \
                                objectForKey:@"EASEMOB_CHATROOM_DOMAIN"]

#define kEaseMobChatAddress [[NSDictionary dictionaryWithContentsOfURL:\
                            [[NSBundle bundleWithURL:[[NSBundle mainBundle] \
                            URLForResource:@"EaseMob" withExtension:@"bundle"]] \
                            URLForResource:@"SDKConfig" withExtension:@"plist"]] \
                            objectForKey:@"EASEMOB_CHAT_ADDRESS"]

#define kEaseMobChatPort [[[NSDictionary dictionaryWithContentsOfURL:\
                            [[NSBundle bundleWithURL:[[NSBundle mainBundle] \
                            URLForResource:@"EaseMob" withExtension:@"bundle"]] \
                            URLForResource:@"SDKConfig" withExtension:@"plist"]] \
                            objectForKey:@"EASEMOB_CHAT_PORT"] integerValue]

#define kEaseMobStorageUrl [[NSDictionary dictionaryWithContentsOfURL:\
                            [[NSBundle bundleWithURL:[[NSBundle mainBundle] \
                            URLForResource:@"EaseMob" withExtension:@"bundle"]] \
                            URLForResource:@"SDKConfig" withExtension:@"plist"]] \
                            objectForKey:@"EASEMOB_STORAGE_URL"]

#endif
