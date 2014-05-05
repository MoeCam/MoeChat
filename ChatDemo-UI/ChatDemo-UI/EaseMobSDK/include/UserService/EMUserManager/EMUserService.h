//
//  EMUserService.h
//  EaseMobClientSDK
//
//  Created by Li Zhiping on 14-5-3.
//  Copyright (c) 2014年 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUserManager.h"

@interface EMUserService : NSObject

+ (instancetype)sharedInstance;

/*!
 @property
 @abstract 用户管理器, 获取该对象后, 可以添加好友, 删除好友, 获取好友信息等操作
 */
@property (nonatomic, readonly, strong) id<IUserManager> userManager;

@end
