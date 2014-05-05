//
//  IUserServiceFactory.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 1/9/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IUserService;
@protocol IBuddyListService;
@protocol IDepartmentService;
/**
 *  工厂类方法, 用于创建三个Service的实例, 然后做相应的操作.
 */
@protocol IUserServiceFactory <NSObject>

/**
 *  创建一个符合 IUserService 协议的对象(Service), 用于处理用户信息的一些操作(如登录、修改用户信息、查找用户等操作)
 *
 *  @return
 */
- (id<IUserService>)createUserService;

/**
 *  创建一个符合 IDepartmentService 协议的对象(Service), 用于处理部门的一些操作
 *
 *  @return
 */
- (id<IDepartmentService>)createDepartmentService;

@end
