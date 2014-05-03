//
//  EMDeviceManagerProximitySensorDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMDeviceManagerDelegateBase.h"

@protocol EMDeviceManagerProximitySensorDelegate <EMDeviceManagerDelegateBase>

@optional
- (void)proximitySensorChanged:(BOOL)isCloseToUser;

@end
