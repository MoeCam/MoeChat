//
//  LBSCommandProcessor.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/23/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IEMCommandProcessor.h"

@class EMChatCommand;
@interface LBSCommandProcessor : NSObject<IEMCommandProcessor>

#pragma mark - IEMChatCommandProcessor protocol
- (BOOL)process:(EMChatCommand *)cmd;
- (BOOL)canProcess:(EMChatCommand *)cmd;

@end
