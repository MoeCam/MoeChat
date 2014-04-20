//
//  EMVideoMessageBody.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/16/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "EMFileMessageBody.h"

@class EMChatVideo;
@interface EMVideoMessageBody : EMFileMessageBody

@property (nonatomic, readonly) NSString *displayName;
@property (nonatomic, readonly) NSInteger duration;
@property (nonatomic, readonly) NSString *localPath;
@property (nonatomic, readonly) NSString *remotePath;
@property (nonatomic, readonly) EMChatVideo *video;

-(id)initWithMessage:(EMChatVideo *)message;

-(NSString *)description;

@end
