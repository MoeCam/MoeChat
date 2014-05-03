//
//  EMDeviceManagerDefs.h
//  EaseMobClientSDK
//
//  Created by jifang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#ifndef EaseMobClientSDK_DeviceManagerDefs_h
#define EaseMobClientSDK_DeviceManagerDefs_h

typedef enum _EMAudioOutputDevice {
    // output to earphone
    eAudioOutputDevice_earphone = 0,
    
    // output to speaker
    eAudioOutputDevice_speaker
}EMAudioOutputDevice;

typedef enum _EMAudioPlaybackMode {
    // play sound, stop in background&screen lock, mixed with others
    eAudioPlayMode_Simple = 0,
    
    // play sound, stop in background&screen lock, play sound exclusively
    eAudioPlayMode_SimpleExclusive,
    
    // play sound, persist in backgound&screen lock
    eAudioPlayMode_PersistPlay,
    
    // record sound only
    eAudioPlayMode_RecordOnly,
    
    // play & record
    eAudioPlayMode_PlayAndRecord
}EMAudioPlaybackMode;

#endif
