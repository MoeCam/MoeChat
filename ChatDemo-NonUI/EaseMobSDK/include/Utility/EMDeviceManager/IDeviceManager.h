//
//  IDeviceManager.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 5/3/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "internal/IDeviceManagerProximitySensor.h"
#import "internal/IDeviceManagerLocation.h"
#import "internal/IDeviceManagerDevice.h"
#import "internal/IDeviceManagerCamera.h"
#import "internal/IDeviceManagerAudio.h"

@protocol IDeviceManager <IDeviceManagerAudio,
                        IDeviceManagerCamera,
                        IDeviceManagerDevice,
                        IDeviceManagerLocation,
                        IDeviceManagerProximitySensor>

@required

@end
