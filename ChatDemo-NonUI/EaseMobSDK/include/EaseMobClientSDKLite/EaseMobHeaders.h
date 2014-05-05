//
//  EaseMobHeaders.h
//  demoApp
//
//  Created by Ji Fang on 3/17/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#ifndef demoApp_EaseMobHeaders_h
#define demoApp_EaseMobHeaders_h

// defs
#import "EMChatServiceDefs.h"
#import "EMPushServiceDefs.h"
#import "EMDeviceManagerDefs.h"

// managers & delegates
#import "IChatManager.h"
#import "IPushManager.h"
#import "IDeviceManager.h"
#import "IChatManagerDelegate.h"
#import "IPushManagerDelegate.h"
#import "IDeviceManagerDelegate.h"

// messages
#import "EMMessage.h"

// message bodies
#import "EMCommandMessageBody.h"
#import "EMVideoMessageBody.h"
#import "EMVoiceMessageBody.h"
#import "EMTextMessageBody.h"
#import "EMLocationMessageBody.h"
#import "EMImageMessageBody.h"
#import "EMFileMessageBody.h"

// chat types
#import "EMChatCommand.h"
#import "EMChatVideo.h"
#import "EMChatVoice.h"
#import "EMChatText.h"
#import "EMChatLocation.h"
#import "EMChatImage.h"
#import "EMChatFile.h"

// push notifications
#import "EMPushData.h"

// commands
#import "LBSCommandProcessor.h"
#import "ChatroomCommandProcessor.h"

// chat sessions
#import "EMConversation.h"

// chat progress
#import "IEMChatProgressDelegate.h"

// cryptor
#import "IEMChatCryptor.h"

#endif
