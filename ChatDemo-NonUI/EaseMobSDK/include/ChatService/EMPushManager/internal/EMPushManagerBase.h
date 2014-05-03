//
//  EMPushManagerBase.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 4/22/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPushManagerBase.h"
#import "IPushManager.h"

@protocol EMPushManagerDelegate;
@class GCDMulticastDelegate;
@interface EMPushManager : NSObject <IPushManager>{
    // delegates
    GCDMulticastDelegate<EMPushManagerDelegate> *_delegates;
    
    // chat queue
    dispatch_queue_t _push_queue;
}

+ (EMPushManager *)sharedInstance;

#pragma mark - delegate
- (void)addDelegate:(id<EMPushManagerDelegate>)delegate delegateQueue:(dispatch_queue_t)queue;
- (void)removeDelegate:(id<EMPushManagerDelegate>)delegate;

@end
