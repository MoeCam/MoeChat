//
//  DeviceManager+Audio.h
//  EaseMobClientSDK
//
//  Created by jifang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "DeviceManagerBase.h"

@class EMError;
@interface DeviceManager (Audio)<AVAudioPlayerDelegate, AVAudioRecorderDelegate>

#pragma mark - audio channel
-(BOOL)chooseAudioPlaybackMode:(EMAudioPlaybackMode)mode;
-(BOOL)switchAudioOutputDevice:(EMAudioOutputDevice)outputDevice;

@property (nonatomic, readonly) EMAudioPlaybackMode currentPlaybackMode;

#pragma mark - play audio functionalities
#pragma mark - properties
// flag to indicate if it is playing audio.
@property (nonatomic, readonly) BOOL isPlayingAudio;

#pragma mark - methods
-(void)playNewMessageSound;
/**
 play sound for new message's arrival
 @returns none
 */
-(void)asyncPlayNewMessageSound;
-(void)asyncPlayNewMessageWithCompletion:(void (^)(SystemSoundID soundId))completion
                                 onQueue:(dispatch_queue_t)aQueue;

-(void)playVibration;
/**
 play vibration for new message's arrival
 @returns none
 */
-(void)asyncPlayVibration;
-(void)asyncPlayVibrationWithCompletion:(void (^)(SystemSoundID soundId))completion
                                onQueue:(dispatch_queue_t)aQueue;

/**
 check if it is playing the specified audio chat
 @param filePath, path of the audio file.
 @returns boolean value indicates if it is playing the specific audio chat.
 */
-(BOOL)isPlayingAudioChat:(NSString *)aFilePath;

/**
 play audio
 @param filePath full filepath of the file.
 @returns none
 @comments file should be of amr encoded, it will be converted to wav to play,
 and the wav file will be deleted after finished playing.
 */
-(void)asyncPlayAudio:(NSString *)aFilePath;
-(void)asyncPlayAudio:(NSString *)aFilePath
           completion:(void (^)(EMError *error))completion
              onQueue:(dispatch_queue_t)aQueue;

/**
 stop playing audio
 @returns boolean value to indicate if we have stopped the audio.
 @comments none.
 */
-(BOOL)stopPlayingAudio;

-(void)startRecordingAudio:(NSString *)aFilePath error:(EMError **)pError;

/**
 stop recording audio
 @returns the full filepath of the file recorded.
 */
-(void)asyncStopRecordingAudio;
-(void)asyncStopRecordingAudioWithCompletion:(void (^)(NSString *aFilePath,
                                                       NSInteger duration,
                                                       EMError *error))completion
                                     onQueue:(dispatch_queue_t)aQueue;

/**
 cancel recording for chatter.
 @returns boolean to indicate if the operation is success.
 */
-(void)asyncCancelRecordingAudio;
-(void)asyncCancelRecordingAudioWithCompletion:(void (^)(NSString *filePath, EMError *error))completion
                                       onQueue:(dispatch_queue_t)aQueue;

/**
 get meter of the recorded voice.
 @returns double to indicate the meter.
 */
-(double)peekRecorderVoiceMeter;

/**
 check if microphone is available.
 @returns boolean to indicate the result.
 @comments result block let users do the future process.
 */
-(BOOL)checkMicrophoneAvailability:(void (^)(BOOL available))result
                           onQueue:(dispatch_queue_t)aQueue;

@end
