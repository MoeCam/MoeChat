//
//  EMCommandMessageBody.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/16/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "EMMessageBody.h"

@class EMChatCommand;
@interface EMCommandMessageBody : EMMessageBody

-(id)initWithMessage:(EMChatCommand *)message;

-(NSString *)description;

@end
