//
//  EMVoiceMessageBody.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "EMFileMessageBody.h"

@class EMChatVoice;
@interface EMVoiceMessageBody : EMFileMessageBody

@property (nonatomic, readonly) NSString *displayName;
@property (nonatomic, readonly) NSString *localPath;
@property (nonatomic, readonly) NSString *remotePath;
@property (nonatomic, readonly) NSInteger duration;
@property (nonatomic, readonly) long long fileLength;
@property (nonatomic, readonly) EMChatVoice *voice;

-(id)initWithMessage:(EMChatVoice *)message;

-(NSString *)description;

@end
