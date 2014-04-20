//
//  DeviceManager+Private.h
//  EaseMobClientSDK
//
//  Created by jifang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "DeviceManagerBase.h"
#import <CoreLocation/CoreLocation.h>

@interface DeviceManager (Private)<CLLocationManagerDelegate>

#pragma mark - audio helper
-(void)_setupAudioSession;
-(BOOL)_switchAudioOutputToSpeaker;
-(BOOL)_switchAudioOutputToEarphone;
-(BOOL)_chooseAudioPlaybackMode:(EMAudioPlaybackMode)mode;
-(void)_setupFlags;
-(void)_teardownFlags;
-(BOOL)convertAMR:(NSString *)amrFilePath
            toWAV:(NSString *)wavFilePath;
-(BOOL)convertWAV:(NSString *)wavFilePath
            toAMR:(NSString *)amrFilePath;

#pragma mark - location helper
-(void)_setupLocationManager;
-(void)_startUpdatingLocation;
-(void)_stopUpdatingLocation;

#pragma mark - proximity sensor helper
-(void)_setupProximitySensor;

@end
