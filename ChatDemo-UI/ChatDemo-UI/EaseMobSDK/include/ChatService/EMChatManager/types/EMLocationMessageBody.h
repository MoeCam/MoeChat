//
//  EMLocationMessageBody.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "EMMessageBody.h"

@class EMChatLocation;
@interface EMLocationMessageBody : EMMessageBody

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) EMChatLocation *location;

-(id)initWithMessage:(EMChatLocation *)message;

-(NSString *)description;

@end
