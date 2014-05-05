//
//  EMDepartmentServiceDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/22/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  本协议包括：获取部门列表等操作时的回调处理
 */
@protocol EMDepartmentServiceDelegate <NSObject>

@optional
/**
 *  部门信息获取操作完成后的回调
 *
 *  @param departments 部门信息列表
 *  @param error       错误信息（如果为nil，则表示无错误）
 */
- (void)didFetchDepartmentList:(NSArray *)departments
                        error:(EMError *)error;

/**
 *  获取单个部门信息操作完成后的回调
 *
 *  @param departmentsInfo 部门信息
 *  @param error           错误信息（如果为nil，则表示无错误）
 */
- (void)didFetchDepartmentsInfo:(NSArray *)departmentsInfo
                         error:(EMError *)error;

@end
