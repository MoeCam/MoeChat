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
-(NSArray *)buddyGroups;
-(id<IBuddyGroup>)addBuddy:(id<IUserBase>)user 
                   toGroup:(NSString *)groupName 
                     error:(EMError **)error;
-(id<IBuddyGroup>)removeBuddy:(NSString *)jid
                    fromGroup:(NSString *)groupName 
                        error:(EMError **)error;;

-(id<IUserBase>)blockBuddy:(NSString *)jid
            error:(EMError **)error;;
-(BOOL)isBlocked:(NSString *)jid 
           error:(EMError **)error;
-(id<IUserBase>)unBlockBuddy:(NSString *)jid
              error:(EMError **)error;

-(id<IBuddyGroup>)createBuddyGroupWithName:(NSString *)groupName 
                                     error:(EMError **)error;
-(id<IBuddyGroup>)deleteBuddyGroup:(NSString *)groupName
                             error:(EMError **)error;

@end
