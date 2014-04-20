//
//  DeviceManager+Location.h
//  EaseMobClientSDK
//
//  Created by jifang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "DeviceManagerBase.h"
#import <CoreLocation/CoreLocation.h>

@class EMError;
@interface DeviceManager (Location)<CLLocationManagerDelegate>

#pragma mark - location service
@property (nonatomic, readonly) BOOL isLocationServicesEnabled;
@property (nonatomic, readonly) CLLocation *lastLocation;

-(void)startUpdatingLocation;
-(void)stopUpdatingLocation;
-(void)refreshLocation;

-(NSString *)decodeAddressFromLatitude:(double)latitude
                          andLongitude:(double)longitude
                                 error:(EMError **)pError;
-(void)asyncDecodeAddressFromLatitude:(double)latitude
                         andLongitude:(double)longitude;
-(void)asyncDecodeAddressFromLatitude:(double)latitude
                         andLongitude:(double)longitude
                           completion:(void (^)(NSString *address, EMError *))completion
                              onQueue:(dispatch_queue_t)queue;

@end
