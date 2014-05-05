//
//  IChatManagerBuddy.h
//  EaseMobClientSDK
//
//  Created by Li Zhiping on 14-5-3.
//  Copyright (c) 2014年 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IChatManagerBase.h"

@protocol IChatManagerBuddy <IChatManagerBase>

@property (nonatomic, strong, readonly) NSArray *buddyList;
@property (nonatomic, strong, readonly) NSArray *groupList;

- (BOOL)addBuddy:(NSString *)username
    withNickName:(NSString *)nickname
         message:(NSString *)message
           error:(EMError **)error;

- (BOOL)addBuddy:(NSString *)username
    withNickName:(NSString *)nickname
         message:(NSString *)message
        toGroups:(NSArray *)groupNames
           error:(EMError **)error;

- (BOOL)removeBuddy:(NSString *)username
              error:(EMError **)error;

- (BOOL)acceptBuddyRequest:(NSString *)username
                     error:(EMError **)error;

- (BOOL)rejectBuddyRequest:(NSString *)username
                     error:(EMError **)error;

@end
