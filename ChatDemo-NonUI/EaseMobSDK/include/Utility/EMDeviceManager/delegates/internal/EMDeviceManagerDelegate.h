//
//  EMDeviceManagerDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 10/31/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMDeviceManagerProximitySensorDelegate.h"
#import "EMDeviceManagerLocationDelegate.h"
#import "EMDeviceManagerAudioDelegate.h"

@protocol EMDeviceManagerDelegate <EMDeviceManagerProximitySensorDelegate,
                                EMDeviceManagerAudioDelegate,
                                EMDeviceManagerLocationDelegate>

@optional

@end
