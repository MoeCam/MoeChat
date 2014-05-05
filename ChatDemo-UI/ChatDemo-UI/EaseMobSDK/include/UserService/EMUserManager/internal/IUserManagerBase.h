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
/**
 *  将一个对象注册到监听列表
 *
 *  @param delegate 需要注册的对象
 *  @param queue    回调时的线程
 */
- (void)addDelegate:(id<EMUserManagerDelegate>)delegate delegateQueue:(dispatch_queue_t)queue;

/**
 *  将一个对象从监听列表中移除
 *
 *  @param delegate 需要移除的对象
 */
- (void)removeDelegate:(id<EMUserManagerDelegate>)delegate;;

@end
