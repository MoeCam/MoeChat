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
    withNickname:(NSString *)nickname
         message:(NSString *)message
           error:(EMError **)pError;

- (BOOL)addBuddy:(NSString *)username
    withNickname:(NSString *)nickname
         message:(NSString *)message
        toGroups:(NSArray *)groupNames
           error:(EMError **)pError;

- (BOOL)removeBuddy:(NSString *)username
   removeFromRemote:(BOOL)removeFromRemote
              error:(EMError **)pError;

- (BOOL)acceptBuddyRequest:(NSString *)username
                     error:(EMError **)pError;

- (BOOL)rejectBuddyRequest:(NSString *)username
                    reason:(NSString *)reason
                     error:(EMError **)pError;

@end
