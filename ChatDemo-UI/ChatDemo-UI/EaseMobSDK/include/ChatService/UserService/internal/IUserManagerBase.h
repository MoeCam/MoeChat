//
//  IUserManagerBase.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 3/16/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EMUserManagerDelegate;

/**
 *  UserService 各种操作的基础协议，用于注册监听的对象和反注册监听的对象
 */
@protocol IUserManagerBase <NSObject>

@required
-(void)addDelegate:(id<EMUserManagerDelegate>)delegate delegateQueue:(dispatch_queue_t)queue;
-(void)removeDelegate:(id<EMUserManagerDelegate>)delegate;;

@end
