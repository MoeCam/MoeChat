//
//  EMChatVideo.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/15/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMChatFile.h"

@interface EMChatVideo : EMChatFile

@property (nonatomic, copy) NSString *displayName;
@property (nonatomic) NSInteger duration;
@property (nonatomic, copy) NSString *localPath;
@property (nonatomic, copy) NSString *remotePath;
@property (nonatomic, strong) NSData *video;

-(id)initWithVideo:(NSData *)aVideo displayName:(NSString *)aDisplayName;

-(id)initWithFile:(NSString *)videoFile displayName:(NSString *)aDisplayName;

-(NSString *)description;

-(void)update;

@end
