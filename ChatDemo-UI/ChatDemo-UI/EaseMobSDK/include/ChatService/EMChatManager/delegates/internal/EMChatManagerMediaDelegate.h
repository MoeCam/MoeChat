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
/**
 *  播放系统声音时的回调
 *
 *  @param soundId 系统声音id
 */
-(void)didPlaySystemSound:(SystemSoundID)soundId;

/**
 *  播放录音时的回调
 *
 *  @param aChatVoice 播放的音频对象
 *  @param error      错误信息
 */
-(void)didPlayAudio:(EMChatVoice *)aChatVoice error:(EMError *)error;

/**
 *  录制声音完成后的回调
 *
 *  @param aChatVoice 录制完的音频对象
 *  @param error      错误信息
 */
-(void)didRecordAudio:(EMChatVoice *)aChatVoice error:(EMError *)error;

/**
 *  取消录音后的回调
 *
 *  @param aChatVoice 取消录制的音频对象
 *  @param error      错误信息
 */
-(void)didCancelRecordAudio:(EMChatVoice *)aChatVoice error:(EMError *)error;

@end
