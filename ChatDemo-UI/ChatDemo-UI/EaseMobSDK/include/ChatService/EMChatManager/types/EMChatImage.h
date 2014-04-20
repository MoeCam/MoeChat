//
//  EMChatImage.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/15/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import "EMChatFile.h"

@class UIImage;
@interface EMChatImage : EMChatFile {
    CGSize _size;
}

@property (nonatomic) CGSize size;

-(id)initWithImage:(UIImage *)aImage displayName:(NSString *)aDisplayName;

-(id)initWithFile:(NSString *)imageFile displayName:(NSString *)aDisplayName;

-(NSString *)description;

@end
