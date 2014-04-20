//
//  IEMChatProgressDelegate.h
//  EaseMobClientSDK
//
//  Created by jifang on 2/19/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IEMChatProgressDelegate <NSObject>

@required
-(void)setProgress:(float)progress;

@end
