//
//  DeviceManagerProximitySensorDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceManagerDelegateBase.h"

@protocol DeviceManagerProximitySensorDelegate <DeviceManagerDelegateBase>

@optional
- (void)proximitySensorChanged:(BOOL)isCloseToUser;

@end
