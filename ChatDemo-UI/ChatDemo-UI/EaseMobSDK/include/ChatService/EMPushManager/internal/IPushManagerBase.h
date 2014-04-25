//
//  IPushManagerBase.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 4/22/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EMPushManagerDelegate;

@protocol IPushManagerBase <NSObject>

@required
/**
 *  注册一个监听对象到监听列表中
 *
 *  @param delegate 需要注册的监听对象
 *  @param queue    通知监听对象时的线程
 */
-(void)addDelegate:(id<EMPushManagerDelegate>)delegate delegateQueue:(dispatch_queue_t)queue;

/**
 *  从监听列表中移除一个监听对象
 *
 *  @param delegate 需要移除的监听对象
 */
-(void)removeDelegate:(id<EMPushManagerDelegate>)delegate;

@end
