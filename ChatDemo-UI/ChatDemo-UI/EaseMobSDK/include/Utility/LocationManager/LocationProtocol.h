//
//  LocationProtocol.h
//  EaseMobClientSDK
//
//  Created by jifang on 10/16/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;
@protocol LocationProtocol <NSObject>

-(void)didDecodeAddress:(NSString *)address
           fromLatitude:(double)latitude
           andLongitude:(double)longitude
                success:(BOOL)success;

-(void)didUpdateLocation:(CLLocation *)updatedLocation;

@end
