//
//  IChatManagerBase.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EMChatManagerDelegate;

@protocol IChatManagerBase <NSObject>

@required
-(void)addDelegate:(id<EMChatManagerDelegate>)delegate delegateQueue:(dispatch_queue_t)queue;
-(void)removeDelegate:(id<EMChatManagerDelegate>)delegate;

@end
