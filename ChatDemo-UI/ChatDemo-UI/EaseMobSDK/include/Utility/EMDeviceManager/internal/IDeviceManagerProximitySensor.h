//
//  IDeviceManagerProximitySensor.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 5/3/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDeviceManagerBase.h"

@protocol IDeviceManagerProximitySensor <IDeviceManagerBase>

@required

#pragma mark - proximity sensor
@property (nonatomic, readonly) BOOL isSupportProximitySensor;
@property (nonatomic, readonly) BOOL isCloseToUser;
@property (nonatomic, readonly) BOOL isProximitySensorEnabled;

- (BOOL)enableProximitySensor;
- (BOOL)disableProximitySensor;

@end
