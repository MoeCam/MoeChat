//
//  EMImageMessageBody.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "EMFileMessageBody.h"
#import <CoreGraphics/CGGeometry.h>

@class EMChatImage;
@interface EMImageMessageBody : EMFileMessageBody {
}

@property (nonatomic, readonly) NSString *thumbnailDisplayName;
@property (nonatomic, readonly) NSString *thumbnailLocalPath;
@property (nonatomic, readonly) NSString *thumbnailRemotePath;
@property (nonatomic, readonly) CGSize thumbnailSize;
@property (nonatomic, readonly) long long thumbnailFileLength;

@property (nonatomic, readonly) NSString *displayName;
@property (nonatomic, readonly) NSString *localPath;
@property (nonatomic, readonly) NSString *remotePath;
@property (nonatomic, readonly) CGSize size;
@property (nonatomic, readonly) long long fileLength;

@property (nonatomic, readonly, strong) EMChatImage *image;
@property (nonatomic, readonly, strong) EMChatImage *thumbnailImage;

-(id)initWithImage:(EMChatImage *)aImage thumbnailImage:(EMChatImage *)aThumbnialImage;

-(NSString *)description;

@end
