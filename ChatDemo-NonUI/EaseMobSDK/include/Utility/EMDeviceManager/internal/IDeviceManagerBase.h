//
//  IDeviceManagerBase.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 5/3/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDeviceManagerDelegate.h"

@protocol IDeviceManagerBase <NSObject>

@required
- (void)addDelegate:(id<IDeviceManagerDelegate>)delegate onQueue:(dispatch_queue_t)aQueue;
- (void)removeDelegate:(id<IDeviceManagerDelegate>)delegate;

@end
