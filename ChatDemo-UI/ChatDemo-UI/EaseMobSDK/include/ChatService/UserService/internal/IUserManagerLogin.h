//
//  IUserManagerLogin.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 3/16/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUserManagerBase.h"

/**
 *  本协议包括：登录、退出、修改密码等操作
 */
@class EMError;
@protocol IUserManagerLogin <IUserManagerBase>

@required
@property (nonatomic, readonly) BOOL isLoggedin;
@property (nonatomic, readonly) NSDictionary *loginInfo;

#pragma mark - user
-(NSDictionary *)loginWithUsername:(NSString *)username
                          password:(NSString *)password
                             error:(EMError **)pError;
-(void)asyncLoginWithUsername:(NSString *)aUsername
                     password:(NSString *)aPassword;
-(void)asyncLoginWithUsername:(NSString *)aUsername
                     password:(NSString *)aPassword
                   completion:(void (^)(NSDictionary *loginInfo, EMError *error))completion 
                      onQueue:(dispatch_queue_t)aQueue;

-(NSDictionary *)logoffWithError:(EMError **)pError;
-(void)asyncLogoff;
-(void)asyncLogoffWithCompletion:(void (^)(NSDictionary *info, EMError *error))completion
                         onQueue:(dispatch_queue_t)aQueue;

-(BOOL)changePassword:(NSString *)oldPassword
          newPassword:(NSString *)newPassword
              forUser:(NSString *)username
                error:(EMError **)pError;
-(void)asyncChangePassword:(NSString *)oldPassword 
               newPassword:(NSString *)newPassword 
                   forUser:(NSString *)username;
-(void)asyncChangePassword:(NSString *)oldPassword 
               newPassword:(NSString *)newPassword 
                   forUser:(NSString *)username
                completion:(void (^)(NSDictionary *info, EMError *error))completion
                   onQueue:(dispatch_queue_t)aQueue;

@end
