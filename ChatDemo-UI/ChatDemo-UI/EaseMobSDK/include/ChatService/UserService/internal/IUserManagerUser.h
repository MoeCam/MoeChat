//
//  IUserManagerUser.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 3/16/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUserManagerBase.h"

/**
 *  用户体系管理协议，本协议包括：更新用户信息、查找用户信息、获取所有用户列表、注册用户、注册公司、通过公司名获取公司Appkey等操作
 */
@class EMError;
@protocol IUserBase;
@protocol IUserManagerUser <IUserManagerBase>

@required
#pragma mark - user
-(id<IUserBase>)updateUserByUsername:(NSString *)username
                      withAttributes:(NSArray *)attributes
                             andKeys:(NSArray *)keys
                               error:(EMError **)pError;
-(void)asyncUpdateUserByUsername:(NSString *)username 
                  withAttributes:(NSArray *)attributes
                         andKeys:(NSArray *)keys;
-(void)asyncUpdateUserByUsername:(NSString *)username 
                  withAttributes:(NSArray *)attributes
                         andKeys:(NSArray *)keys 
                      completion:(void (^)(id<IUserBase> updatedUser, 
                                           EMError *error))completion
                         onQueue:(dispatch_queue_t)aQueue;

-(id<IUserBase>)findUserByUsername:(NSString *)username
                             error:(EMError **)pError;
-(void)asyncFindUserByUsername:(NSString *)username;
-(void)asyncFindUserByUsername:(NSString *)username 
                    completion:(void (^)(id<IUserBase> user, 
                                         EMError *error))completion 
                       onQueue:(dispatch_queue_t)aQueue;

-(NSArray *)findUsersByUsernames:(NSArray *)usernames
                           error:(EMError **)pError;
-(void)asyncFindUsersByUsernames:(NSArray *)usernames;
-(void)asyncFindUsersByUsernames:(NSArray *)usernames 
                      completion:(void (^)(NSArray *users, 
                                           EMError *error))completion 
                         onQueue:(dispatch_queue_t)aQueue;

-(NSArray *)findAllUsersWithError:(EMError **)pError;
-(void)asyncFindAllUsers;
-(void)asyncFindAllUsersWithCompletion:(void (^)(NSArray *users, 
                                                 EMError *error))completion
                               onQueue:(dispatch_queue_t)aQueue;

-(NSDictionary *)registerNewCompany:(NSString *)company
                          withError:(EMError **)pError;
-(void)asyncRegisterNewCompany:(NSString *)company;
-(void)asyncRegisterNewCompany:(NSString *)company
                    completion:(void (^)(NSDictionary *info, 
                                         EMError *error))completion 
                       onQueue:(dispatch_queue_t)aQueue;

-(NSString *)findAppKeyWithCompany:(NSString *)company
                         withError:(EMError **)pError;
-(void)asyncFindAppKeyWithCompany:(NSString *)company;
-(void)asyncFindAppKeyWithCompany:(NSString *)company
                       completion:(void (^)(NSString *appKey,
                                        EMError *error))completion
                          onQueue:(dispatch_queue_t)aQueue;

-(BOOL)registerNewUsers:(NSArray *)usernames
    withDefaultPassword:(NSString *)password
               userInfo:(NSDictionary *)userInfo
                  error:(EMError **)pError;
-(void)asyncRegisterNewUsers:(NSArray *)usernames
         withDefaultPassword:(NSString *)password
                    userInfo:(NSDictionary *)userInfo;
-(void)asyncRegisterNewUsers:(NSArray *)usernames
         withDefaultPassword:(NSString *)password
                    userInfo:(NSDictionary *)userInfo
                  completion:(void (^)(NSArray *usernames, 
                                       NSString *password,
                                       EMError *error))completion 
                     onQueue:(dispatch_queue_t)aQueue;

-(id<IUserBase>)deleteUser:(NSString *)username
                     error:(EMError **)pError;
-(void)asyncDeleteUser:(NSString *)username;
-(void)asyncDeleteUser:(NSString *)username
            completion:(void (^)(id<IUserBase> user, 
                                 EMError *error))completion 
               onQueue:(dispatch_queue_t)aQueue;

@end
