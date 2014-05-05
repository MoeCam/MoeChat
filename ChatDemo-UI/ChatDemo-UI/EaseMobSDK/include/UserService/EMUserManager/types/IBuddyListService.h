//
//  IBuddyListService.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 12/28/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IUserBase;
@protocol IBuddyGroup;
@class EMError;
@protocol IBuddyListService <NSObject>

@required
#pragma mark - buddy list
- (NSArray *)fetchBuddyGroupsWithError:(EMError **)error;
- (BOOL)addBuddy:(NSString *)username
       nickname:(NSString *)nickname
        toGroup:(NSString *)groupName
          error:(EMError **)error;
- (BOOL)removeBuddy:(NSString *)username
                    fromGroup:(NSString *)groupName 
                        error:(EMError **)error;;

- (BOOL)blockBuddy:(NSString *)username
                     error:(EMError **)error;
- (BOOL)isBlocked:(NSString *)username
           error:(EMError **)error;
- (BOOL)unBlockBuddy:(NSString *)username
                       error:(EMError **)error;

- (BOOL)createBuddyGroupWithName:(NSString *)groupName
                          error:(EMError **)error;
- (BOOL)deleteBuddyGroup:(NSString *)groupName
                  error:(EMError **)error;

@end
