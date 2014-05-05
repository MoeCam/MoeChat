//
//  DeviceManager.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 10/30/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceManagerDefs.h"
#import "DeviceManagerDelegate.h"
#import <AVFoundation/AVFoundation.h>

@class CLLocationManager;
@class GCDMulticastDelegate;
@interface DeviceManager : NSObject<AVAudioSessionDelegate> {
    EMAudioPlaybackMode _currentPlaybackMode;
    BOOL _isSupportProximitySensor;
    BOOL _isCloseToUser;
    
    // CLLocation
    CLLocationManager *_locationManager;
    CLLocation *_checkinLocation;
    BOOL _isStartUpdateLocation;
    
    // multicast delegate
    GCDMulticastDelegate<DeviceManagerDelegate> *_delegates;
    
    // audio playback
    AVAudioPlayer *_audioPlayer;
    AVAudioRecorder *_audioRecorder;
}

+ (DeviceManager *)sharedInstance;

- (void)addDelegate:(id<DeviceManagerDelegate>)delegate onQueue:(dispatch_queue_t)aQueue;
- (void)removeDelegate:(id<DeviceManagerDelegate>)delegate;

@end
