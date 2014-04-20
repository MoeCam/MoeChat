//
//  IChatManagerMedia.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "IChatManagerBase.h"

/**
 *  本协议主要处理：录音、播放录音、停止录音、震动等操作
 */
@class EMChatVoice;
@class EMError;
@protocol IChatManagerMedia <IChatManagerBase>

@required
@property (nonatomic, readonly) BOOL isPlayingAudio;

-(void)playNewMessageSound;
-(void)asyncPlayNewMessageSound;
-(void)asyncPlayNewMessageWithCompletion:(void (^)(SystemSoundID soundId))completion
                                 onQueue:(dispatch_queue_t)aQueue;

-(void)playVibration;
-(void)asyncPlayVibration;
-(void)asyncPlayVibrationWithCompletion:(void (^)(SystemSoundID soundId))completion
                                onQueue:(dispatch_queue_t)aQueue;

-(BOOL)isPlayingAudioChat:(EMChatVoice *)aChatVoice;
-(BOOL)isPlayingAudio;

-(void)asyncPlayAudio:(EMChatVoice *)aChatVoice;
-(void)asyncPlayAudio:(EMChatVoice *)aChatVoice
           completion:(void (^)(EMError *error))completion
              onQueue:(dispatch_queue_t)aQueue;

-(BOOL)stopPlayingAudio;

-(void)startRecordingAudioWithError:(EMError **)pError;
-(void)asyncStopRecordingAudio;
-(void)asyncStopRecordingAudioWithCompletion:(void (^)(EMChatVoice *aChatVoice,
                                                       EMError *error))completion
                                     onQueue:(dispatch_queue_t)aQueue;

-(void)asyncCancelRecordingAudio;
-(void)asyncCancelRecordingAudioWithCompletion:(void (^)(EMChatVoice *aChatVoice,
                                                         EMError *error))completion
                                       onQueue:(dispatch_queue_t)aQueue;

-(double)peekRecorderVoiceMeter;

@end
