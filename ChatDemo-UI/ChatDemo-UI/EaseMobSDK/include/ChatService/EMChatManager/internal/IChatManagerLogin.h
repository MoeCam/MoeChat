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
 *  所有不带Block回调的异步方法, 需要监听回调时, 需要先将要接受回调的对象注册到delegate中, 示例代码如下:
 *  [[[EaseMob sharedInstance] chatManager] addDelegate:self delegateQueue:dispatch_get_main_queue]
 */
@protocol IChatManagerLogin <IChatManagerBase>

#pragma mark - login
/**
 *  同步方法, 使用用户名密码登录聊天服务器
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param aError   错误信息
 *
 *  @return 登录后返回的用户信息
 */
-(NSDictionary *)loginWithUsername:(NSString *)username
                          password:(NSString *)password
                             error:(EMError **)aError;

/**
 *  异步方法, 使用用户名密码登录聊天服务器
 *
 *  @param username 用户名
 *  @param password 密码
 */
-(void)asyncLoginWithUsername:(NSString *)username
                     password:(NSString *)password;

/**
 *  异步方法, 使用用户名密码登录聊天服务器
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
-(void)asyncLoginWithUsername:(NSString *)username
                     password:(NSString *)password
                   completion:(void (^)(NSDictionary *loginInfo, EMError *error))completion
                      onQueue:(dispatch_queue_t)aQueue;

#pragma mark - logoff
/**
 *  注销当前登录用户
 *
 *  @param pError 错误信息
 *
 *  @return 注销后的用户信息
 */
-(NSDictionary *)logoffWithError:(EMError **)pError;

/**
 *  注销当前登录用户
 */
-(void)asyncLogoff;

/**
 *  注销当前登录用户
 *
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
-(void)asyncLogoffWithCompletion:(void (^)(NSDictionary *info, EMError *error))completion
                         onQueue:(dispatch_queue_t)aQueue;

#pragma mark - change password
/**
 *  同步方法, 修改当前登录用户的密码
 *
 *  @param oldPassword 旧密码
 *  @param newPassword 新密码
 *  @param username    需要修改密码的用户(需要与当前登录的用户名一致, 否则不能修改成功)
 *  @param pError      错误信息
 *
 *  @return 密码是否修改成功
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
 *  @param username    需要修改密码的用户(需要与当前登录的用户名一致, 否则不能修改成功)
 */
-(void)asyncChangePassword:(NSString *)oldPassword
               newPassword:(NSString *)newPassword
                   forUser:(NSString *)username;

/**
 *  异步方法, 修改当前登录用户的密码
 *
 *  @param oldPassword 旧密码
 *  @param newPassword 新密码
 *  @param username    需要修改密码的用户(需要与当前登录的用户名一致, 否则不能修改成功)
 *  @param completion  回调
 *  @param aQueue      回调时的线程
 */
-(void)asyncChangePassword:(NSString *)oldPassword
               newPassword:(NSString *)newPassword
                   forUser:(NSString *)username
                completion:(void (^)(NSDictionary *info, EMError *error))completion
                   onQueue:(dispatch_queue_t)aQueue;

#pragma mark - properties
/**
 *  当前登录的用户信息
 */
@property (nonatomic, strong, readonly) NSDictionary *loginInfo;

/**
 *  当前是否已有登录的用户
 */
@property (nonatomic, readonly) BOOL isLoggedIn;

@end
