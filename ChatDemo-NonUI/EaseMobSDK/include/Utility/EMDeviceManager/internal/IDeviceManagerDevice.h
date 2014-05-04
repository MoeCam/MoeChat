//
//  IDeviceManagerDevice.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 5/3/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDeviceManagerBase.h"

@protocol IDeviceManagerDevice <IDeviceManagerBase>

@required

#pragma mark - device version
@property (nonatomic, readonly) float deviceVersion;
@property (nonatomic, readonly) NSString *uniqueId;
@property (nonatomic, readonly) NSString *compactUniqueId;

@end
