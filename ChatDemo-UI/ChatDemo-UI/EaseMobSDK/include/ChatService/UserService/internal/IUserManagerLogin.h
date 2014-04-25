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
 *  所有不带Block回调的异步方法, 需要监听回调时, 需要先将要接受回调的对象注册到delegate中, 示例代码如下:
 *  [[[EaseMob sharedInstance] userManager] addDelegate:self delegateQueue:dispatch_get_main_queue]
 */
@class EMError;
@protocol IUserManagerLogin <IUserManagerBase>

@required
/**
 *  当前是否已登录
 */
@property (nonatomic, readonly) BOOL isLoggedin;

/**
 *  登录的用户信息
 */
@property (nonatomic, readonly) NSDictionary *loginInfo;

#pragma mark - user
/**
 *  同步方法, 使用用户名密码登录
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param pError   错误信息
 *
 *  @return 登录后的用户信息
 */
-(NSDictionary *)loginWithUsername:(NSString *)username
                          password:(NSString *)password
                             error:(EMError **)pError;

/**
 *  异步方法, 使用用户名密码登录
 *
 *  @param username 用户名
 *  @param password 密码
 */
-(void)asyncLoginWithUsername:(NSString *)aUsername
                     password:(NSString *)aPassword;

/**
 *  同步方法, 使用用户名密码登录
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
-(void)asyncLoginWithUsername:(NSString *)aUsername
                     password:(NSString *)aPassword
                   completion:(void (^)(NSDictionary *loginInfo, EMError *error))completion 
                      onQueue:(dispatch_queue_t)aQueue;

/**
 *  注销当前登录用户
 *
 *  @param pError 错误信息
 *
 *  @return 注销的用户的信息
 */
-(NSDictionary *)logoffWithError:(EMError **)pError;

/**
 *  异步方法, 注销当前登录用户
 */
-(void)asyncLogoff;

/**
 *  异步方法, 注销当前登录用户
 *
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
-(void)asyncLogoffWithCompletion:(void (^)(NSDictionary *info, EMError *error))completion
                         onQueue:(dispatch_queue_t)aQueue;

/**
 *  同步方法, 修改当前登录用户的密码
 *
 *  @param oldPassword 旧密码
 *  @param newPassword 新密码
 *  @param username    需要修改密码的用户
 *  @param pError      错误信息
 *
 *  @return 修改成功与否
 */
-(BOOL)changePassword:(NSString *)oldPassword
          newPassword:(NSString *)newPassword
              forUser:(NSString *)username
                error:(EMError **)pError;

/**
 *  异步方法, 修改当前登录用户的密码
 *
 *  @param oldPassword 旧密码
 *  @param newPassword 新密码
 *  @param username    需要修改密码的用户
 */
-(void)asyncChangePassword:(NSString *)oldPassword 
               newPassword:(NSString *)newPassword 
                   forUser:(NSString *)username;

/**
 *  异步方法, 修改当前登录用户的密码
 
 *  @param oldPassword 旧密码
 *  @param newPassword 新密码
 *  @param username    需要修改密码的用户
 *  @param completion  回调
 *  @param aQueue      回调时的线程
 */
-(void)asyncChangePassword:(NSString *)oldPassword 
               newPassword:(NSString *)newPassword 
                   forUser:(NSString *)username
                completion:(void (^)(NSDictionary *info, EMError *error))completion
                   onQueue:(dispatch_queue_t)aQueue;

@end
