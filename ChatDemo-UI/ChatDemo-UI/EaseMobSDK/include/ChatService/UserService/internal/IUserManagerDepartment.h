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
 */
@class EMError;
@protocol IUserManagerDepartment <IUserManagerBase>

@required
-(NSArray *)fetchDepartmentsWithError:(EMError **)pError;
-(void)asyncFetchDepartments;
-(void)asyncFetchDepartmentsWithCompletion:(void (^)(NSArray *departments, 
                                                     EMError *error))completion 
                                   onQueue:(dispatch_queue_t)aQueue;

-(NSArray *)fetchDepartmentsInfoWithError:(EMError **)pError;
-(void)asyncFetchDepartmentsInfo;
-(void)asyncFetchDepartmentsInfoWithCompletion:(void (^)(NSArray *departmentsInfo, 
                                                         EMError *error))completion
                                       onQueue:(dispatch_queue_t)aQueue;

-(NSString *)rootDepartment;

@end
