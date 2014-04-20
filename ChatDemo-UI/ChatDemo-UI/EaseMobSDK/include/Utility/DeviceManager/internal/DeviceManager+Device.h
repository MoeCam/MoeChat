//
//  DeviceManager+Device.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "DeviceManagerBase.h"

@interface DeviceManager (Device)

#pragma mark - device version
@property (nonatomic, readonly) float deviceVersion;
@property (nonatomic, readonly) NSString *uniqueId;
@property (nonatomic, readonly) NSString *compactUniqueId;

@end
