//
//  EMTextMessageBody.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "EMMessageBody.h"

@class EMChatText;
@interface EMTextMessageBody : EMMessageBody

@property (nonatomic, readonly) EMChatText *text;

-(id)initWithMessage:(EMChatText *)message;

-(NSString *)description;

@end
