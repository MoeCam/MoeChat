//
//  LocationManager.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 10/13/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject<CLLocationManagerDelegate>

+(LocationManager *)sharedInstance;

@property (nonatomic, readonly) BOOL isLocationServicesEnabled;

-(void)startUpdatingLocation;
-(void)stopUpdatingLocation;
-(void)refreshLocation;
-(CLLocation *)getLastLocation;

-(NSString *)getAddressFromLatitude:(double)latitude
                       andLongitude:(double)longitude;
-(void)asyncGetAddressFromLatitude:(double)latitude
                      andLongitude:(double)longitude;
-(void)asyncGetAddressFromLatitude:(double)latitude
                      andLongitude:(double)longitude
                        completion:(void (^)(NSString *address, BOOL success))completion
                           onQueue:(dispatch_queue_t)queue;

@end
