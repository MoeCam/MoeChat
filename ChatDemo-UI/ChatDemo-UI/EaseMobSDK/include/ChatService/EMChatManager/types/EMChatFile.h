//
//  EMChatFile.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/15/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMChatObject.h"

@interface EMChatFile : EMChatObject {
    NSString *_displayName;
    NSString *_localPath;
    NSString *_remotePath;
    long long _fileLength;
}

@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy) NSString *localPath;
@property (nonatomic, copy) NSString *remotePath;
@property (nonatomic) long long fileLength;

-(NSString *)generateName;
-(long long)lengthOfFile:(NSString *)path;
-(void)update;

-(id)initWithData:(NSData *)aData displayName:(NSString *)aDisplayName;
-(id)initWithFile:(NSString *)filePath displayName:(NSString *)aDisplayName;

-(NSString *)description;

@end
