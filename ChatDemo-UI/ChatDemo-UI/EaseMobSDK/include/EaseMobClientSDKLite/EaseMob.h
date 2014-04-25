//
//  EaseMob.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/13/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EaseMobHeaders.h"

/**
 *  SDK集成进工程后, 最先使用的类, 所有的类对象, 均是通过这个单实例来获取
 */
@interface EaseMob : NSObject

/**
 *  获取单实例
 *
 *  @return
 */
+(EaseMob *)sharedInstance;

/**
 *  聊天管理器, 获取该对象后, 可以做登录、聊天、加好友等操作
 */
@property (nonatomic, readonly, strong) id<IChatManager> chatManager;

/**
 *  用户体系管理器, 获取该对象后, 可以做登录、获取用户信息、修改用户信息、获取部门信息等操作。
 */
@property (nonatomic, readonly, strong) id<IUserManager> userManager;

@property (nonatomic, readonly, strong) id<IPushManager> pushManager;

@end
