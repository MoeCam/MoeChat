//
//  EMFileMessageBody.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "EMMessageBody.h"

@class EMChatFile;
@interface EMFileMessageBody : EMMessageBody

@property (nonatomic, readonly) NSString *displayName;
@property (nonatomic, readonly) NSString *localPath;
@property (nonatomic, readonly) NSString *remotePath;
@property (nonatomic, readonly) long long fileLength;
@property (nonatomic, readonly) EMChatFile *file;

-(id)initWithMessage:(EMChatFile *)message;

-(NSString *)description;

@end
