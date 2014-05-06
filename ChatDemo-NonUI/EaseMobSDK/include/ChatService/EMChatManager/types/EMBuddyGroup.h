//
//  EMBuddyGroup.h
//  EaseMobClientSDK
//
//  Created by Li Zhiping on 14-5-3.
//  Copyright (c) 2014年 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMBuddyGroup : NSObject

+ (instancetype)buddyGroupWithGroupName:(NSString *)groupName;

/*!
 *  分组名称
 */
@property (copy, nonatomic, readonly)NSString *groupName;

/*!
 *  由NSString对象(username)组成
 */
@property (strong, nonatomic)NSArray *members;

@end
