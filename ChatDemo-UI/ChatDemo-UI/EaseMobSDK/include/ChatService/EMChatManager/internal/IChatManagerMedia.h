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
 *  所有不带Block回调的异步方法, 需要监听回调时, 需要先将要接受回调的对象注册到delegate中, 示例代码如下:
 *  [[[EaseMob sharedInstance] chatManager] addDelegate:self delegateQueue:dispatch_get_main_queue]
 */
@class EMChatVoice;
@class EMError;
@protocol IChatManagerMedia <IChatManagerBase>

@required
/**
 *  是否正在播放音频
 */
@property (nonatomic, readonly) BOOL isPlayingAudio;

/**
 *  收到新消息时, 播放声音提示
 */
-(void)playNewMessageSound;

/**
 *  异步方法, 收到新消息时, 播放声音提示
 */
-(void)asyncPlayNewMessageSound;

/**
 *  异步方法, 收到新消息时, 播放声音提示
 *
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
-(void)asyncPlayNewMessageWithCompletion:(void (^)(SystemSoundID soundId))completion
                                 onQueue:(dispatch_queue_t)aQueue;

/**
 *  收到新消息时, 播放震动提示
 */
-(void)playVibration;

/**
 *  异步方法, 收到新消息时, 播放震动提示
 */
-(void)asyncPlayVibration;

/**
 *  异步方法, 收到新消息时, 播放震动提示
 *
 *  @param completion 回调
 *  @param aQueue     震动完成后的回调
 */
-(void)asyncPlayVibrationWithCompletion:(void (^)(SystemSoundID soundId))completion
                                onQueue:(dispatch_queue_t)aQueue;

/**
 *  判断是否正在播放该聊天声音
 *
 *  @param aChatVoice 聊天记录声音对象
 *
 *  @return YES为正在播放, NO为未播放
 */
-(BOOL)isPlayingAudioChat:(EMChatVoice *)aChatVoice;

/**
 *  判断是否正在播放音频
 *
 *  @return YES为正在播放, NO为未播放
 */
-(BOOL)isPlayingAudio;

/**
 *  异步方法, 播放一个聊天记录的声音对象
 *
 *  @param aChatVoice 需要播放的聊天音频对象
 */
-(void)asyncPlayAudio:(EMChatVoice *)aChatVoice;

/**
 *  异步方法, 播放一个聊天记录的声音对象
 *
 *  @param aChatVoice 需要播放的聊天音频对象
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
-(void)asyncPlayAudio:(EMChatVoice *)aChatVoice
           completion:(void (^)(EMError *error))completion
              onQueue:(dispatch_queue_t)aQueue;

/**
 *  停止当前正在播放的音频
 *
 *  @return 是否stop成功
 */
-(BOOL)stopPlayingAudio;

/**
 *  同步方法, 开始录制音频
 *
 *  @param pError 错误信息
 */
-(void)startRecordingAudioWithError:(EMError **)pError;

/**
 *  异步方法, 停止录制音频
 */
-(void)asyncStopRecordingAudio;

/**
 *  异步方法, 停止录制音频
 *
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
-(void)asyncStopRecordingAudioWithCompletion:(void (^)(EMChatVoice *aChatVoice,
                                                       EMError *error))completion
                                     onQueue:(dispatch_queue_t)aQueue;

/**
 *  异步方法, 取消录制音频
 */
-(void)asyncCancelRecordingAudio;

/**
 *  异步方法, 取消录制音频
 *
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
-(void)asyncCancelRecordingAudioWithCompletion:(void (^)(EMChatVoice *aChatVoice,
                                                         EMError *error))completion
                                       onQueue:(dispatch_queue_t)aQueue;

/**
 *  获取录制音频的时长(stop后, 再去调用该方法, 会返回最后一次录制音频的时长)
 *
 *  @return 音频的时长
 */
-(double)peekRecorderVoiceMeter;

@end
