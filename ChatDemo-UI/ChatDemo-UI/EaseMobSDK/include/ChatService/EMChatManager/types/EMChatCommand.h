//
//  EMChatCommand.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/15/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "EMChatObject.h"

@interface EMChatCommand : EMChatObject

@property (nonatomic, copy) NSString *cmd;
@property (nonatomic, strong) NSArray *params;

-(NSString *)description;

@end
