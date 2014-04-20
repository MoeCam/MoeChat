//
//  DeviceManagerProtocol.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 10/31/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceManagerProximitySensorDelegate.h"
#import "DeviceManagerLocationDelegate.h"
#import "DeviceManagerAudioDelegate.h"

@protocol DeviceManagerDelegate <DeviceManagerProximitySensorDelegate,
                                DeviceManagerAudioDelegate, 
                                DeviceManagerLocationDelegate>

@optional

@end
