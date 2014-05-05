//
//  IEMCommandProcessor.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/23/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMChatCommand;
@protocol IEMCommandProcessor <NSObject>

@required
- (BOOL)process:(EMChatCommand *)cmd;
- (BOOL)canProcess:(EMChatCommand *)cmd;

@end
