//
//  DeviceManagerLocationDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 1/31/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceManagerDelegateBase.h"

@class CLLocation;
@class EMError;
@protocol DeviceManagerLocationDelegate <DeviceManagerDelegateBase>

@optional
- (void)didDecodeAddress:(NSString *)address
           fromLatitude:(double)latitude
           andLongitude:(double)longitude
                  error:(EMError *)error;

- (void)didUpdateLocation:(CLLocation *)updatedLocation;

- (void)didStopLocation;

- (void)didFailToLocateUserWithError:(EMError *)error;

@end
