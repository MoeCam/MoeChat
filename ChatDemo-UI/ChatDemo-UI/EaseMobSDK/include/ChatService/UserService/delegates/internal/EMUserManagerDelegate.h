//
//  EMUserManagerDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/22/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMUserServiceDelegate.h"
#import "EMDepartmentServiceDelegate.h"
#import "EMBuddyServiceDelegate.h"

/**
 *  本协议包括：用户信息管理回调、部门管理回调、好友管理回调
 */
@protocol EMUserManagerDelegate <EMUserServiceDelegate, 
                                EMDepartmentServiceDelegate, 
                                EMBuddyServiceDelegate>

@end
