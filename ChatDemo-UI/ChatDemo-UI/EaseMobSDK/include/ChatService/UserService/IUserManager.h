//
//  IUserManager.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 3/16/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUserManagerLogin.h"
#import "IUserManagerUser.h"
#import "IUserManagerBuddyGroup.h"
#import "IUserManagerDepartment.h"

/**
 *  登录、好友详细信息，部门管理，信息修改等协议的集合
 */
@protocol IUserManager <IUserManagerBuddyGroup, 
                        IUserManagerDepartment, 
                        IUserManagerLogin, 
                        IUserManagerUser>
@required

@end
