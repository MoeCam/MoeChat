/*!
 @header EaseMobHeaders.h
 @abstract 引入SDK的所有需要的头文件
 @author EaseMob Inc.
 @version 1.0
 */
#ifndef demoApp_EaseMobHeaders_h
#define demoApp_EaseMobHeaders_h

// defs
#import "EMChatServiceDefs.h"
#import "EMDeviceManagerDefs.h"

// managers & delegates
#import "IChatManager.h"
#import "IDeviceManager.h"
#import "IChatManagerDelegate.h"
#import "IDeviceManagerDelegate.h"

// messages
#import "EMMessage.h"

// message bodies
#import "EMVideoMessageBody.h"
#import "EMVoiceMessageBody.h"
#import "EMTextMessageBody.h"
#import "EMLocationMessageBody.h"
#import "EMImageMessageBody.h"
#import "EMFileMessageBody.h"

// chat types
#import "EMChatVideo.h"
#import "EMChatVoice.h"
#import "EMChatText.h"
#import "EMChatLocation.h"
#import "EMChatImage.h"
#import "EMChatFile.h"

// user types
#import "EMBuddy.h"
#import "EMBuddyGroup.h"

// chat sessions
#import "EMConversation.h"

// chat progress
#import "IEMChatProgressDelegate.h"

// cryptor
#import "IEMChatCryptor.h"

#endif
