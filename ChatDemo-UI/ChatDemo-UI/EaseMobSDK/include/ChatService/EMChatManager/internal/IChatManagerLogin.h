//
//  IChatManagerLogin.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 3/26/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IChatManagerBase.h"

/**
 *  本协议包括：登录、退出、修改密码等方法
 */
@protocol IChatManagerLogin <IChatManagerBase>

#pragma mark - login
-(NSDictionary *)loginWithUsername:(NSString *)username
                          password:(NSString *)password
                             error:(EMError **)aError;
-(void)asyncLoginWithUsername:(NSString *)username
                     password:(NSString *)password;
-(void)asyncLoginWithUsername:(NSString *)username
                     password:(NSString *)password
                   completion:(void (^)(NSDictionary *loginInfo, EMError *error))completion
                      onQueue:(dispatch_queue_t)aQueue;

#pragma mark - logoff
-(NSDictionary *)logoffWithError:(EMError **)pError;
-(void)asyncLogoff;
-(void)asyncLogoffWithCompletion:(void (^)(NSDictionary *info, EMError *error))completion
                         onQueue:(dispatch_queue_t)aQueue;

#pragma mark - change password
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

#pragma mark - properties
@property (nonatomic, strong, readonly) NSDictionary *loginInfo;
@property (nonatomic, readonly) BOOL isLoggedIn;

@end
