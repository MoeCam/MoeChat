//
//  LocationDelegateManager.h
//  EaseMobClientSDK
//
//  Created by jifang on 10/16/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationProtocol.h"

@interface LocationDelegateManager : NSObject<LocationProtocol>

+(LocationDelegateManager *)sharedInstance;

-(void)addDelegate:(id<LocationProtocol>)delegate onQueue:(dispatch_queue_t)aQueue;
-(void)removeDelegate:(id<LocationProtocol>)delegate;

@end
