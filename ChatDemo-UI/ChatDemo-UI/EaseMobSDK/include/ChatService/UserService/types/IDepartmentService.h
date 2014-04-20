//
//  IDepartmentService.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 12/28/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMError;
@protocol IDepartmentService <NSObject>

@required
#pragma mark - IDepartmentService
-(NSArray *)fetchDepartmentsInfoWithError:(EMError **)pError;
-(NSString *)rootDepartment;

@end
