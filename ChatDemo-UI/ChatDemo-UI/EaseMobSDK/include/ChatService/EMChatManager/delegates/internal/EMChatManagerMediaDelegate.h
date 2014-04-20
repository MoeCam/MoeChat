//
//  EMChatManagerMediaDelegate.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/12/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "EMChatManagerDelegateBase.h"

@class EMChatVoice;

/**
 *  本协议包括：播放声音时的回调、录制时的回调、取消录制时的回调等
 */
@protocol EMChatManagerMediaDelegate <EMChatManagerDelegateBase>

@optional
-(void)didPlaySystemSound:(SystemSoundID)soundId;
-(void)didPlayAudio:(EMChatVoice *)aChatVoice error:(EMError *)error;
-(void)didRecordAudio:(EMChatVoice *)aChatVoice error:(EMError *)error;
-(void)didCancelRecordAudio:(EMChatVoice *)aChatVoice error:(EMError *)error;

@end
