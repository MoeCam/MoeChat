//
//  IUserManagerDepartment.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 3/16/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUserManagerBase.h"

/**
 *  本协议包括：“获取部门树”等方法
 *  所有不带Block回调的异步方法, 需要监听回调时, 需要先将要接受回调的对象注册到delegate中, 示例代码如下:
 *  [[[EaseMob sharedInstance] userManager] addDelegate:self delegateQueue:dispatch_get_main_queue]
 */
@class EMError;
@protocol IUserManagerDepartment <IUserManagerBase>

@required
/**
 *  获取部门信息
 *
 *  @param pError 错误信息
 *
 *  @return 服务器返回的部门信息
 */
-(NSArray *)fetchDepartmentsWithError:(EMError **)pError;
/**
 *  异步获取部门信息
 */
-(void)asyncFetchDepartments;

/**
 *  异步获取部门信息
 *
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
-(void)asyncFetchDepartmentsWithCompletion:(void (^)(NSArray *departments, 
                                                     EMError *error))completion 
                                   onQueue:(dispatch_queue_t)aQueue;

/**
 *  <#Description#>
 *
 *  @param pError <#pError description#>
 *
 *  @return <#return value description#>
 */
-(NSArray *)fetchDepartmentsInfoWithError:(EMError **)pError;

/**
 *  <#Description#>
 */
-(void)asyncFetchDepartmentsInfo;

/**
 *  <#Description#>
 *
 *  @param completion <#completion description#>
 *  @param aQueue     <#aQueue description#>
 */
-(void)asyncFetchDepartmentsInfoWithCompletion:(void (^)(NSArray *departmentsInfo, 
                                                         EMError *error))completion
                                       onQueue:(dispatch_queue_t)aQueue;

/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
-(NSString *)rootDepartment;

@end
