//
//  EMChatLocation.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/15/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMChatObject.h"

@class CLLocation;
@interface EMChatLocation : EMChatObject

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) CLLocation *location;

-(id)initWithLatitude:(double)latitude 
            longitude:(double)longitude 
              address:(NSString *)address;

-(id)initWithLocation:(CLLocation *)location;

-(NSString *)description;

@end
