//
//  EMDeviceManagerAudioDelegate.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/11/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "EMDeviceManagerDelegateBase.h"

@class EMError;
@protocol EMDeviceManagerAudioDelegate <EMDeviceManagerDelegateBase>

@optional
- (void)didPlaySystemSound:(SystemSoundID)soundId;
- (void)didPlayAudio:(NSString *)aFilePath error:(EMError *)error;
- (void)didRecordAudio:(NSString *)aFilePath duration:(NSInteger)duration error:(EMError *)error;
- (void)didCancelRecordAudio:(NSString *)aFilePath error:(EMError *)error;

@end
