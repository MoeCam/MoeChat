//
//  EMChatVoice.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/15/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMChatFile.h"

@interface EMChatVoice : EMChatFile {
}

@property (nonatomic) NSInteger duration;

-(id)initWithVoice:(NSData *)aVoice displayName:(NSString *)aDisplayName;

-(id)initWithFile:(NSString *)voiceFile displayName:(NSString *)aDisplayName;

-(NSString *)description;

@end
