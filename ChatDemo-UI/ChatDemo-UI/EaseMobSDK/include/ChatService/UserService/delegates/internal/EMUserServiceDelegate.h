//
//  EMUserServiceDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/22/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMError;
@protocol IUserBase;

/**
 *  本协议包括：用户登录成功、登录失败、修改密码、更新用户信息、查找好友、注册用户、删除用户、注册公司等操作时的回调处理
 */
@protocol EMUserServiceDelegate <NSObject>

@optional
/**
 *  用户登录后返回的结果回调操作
 *
 *  @param aLoginInfo 登录信息
 *  @param aError     错误信息（如果为nil，则表示无错误）
 */
-(void)didLoginWithLoginInfo:(NSDictionary *)aLoginInfo 
                       error:(EMError *)aError;

/**
 *  用户退出后返回的结果回调操作
 *
 *  @param aInfo  用户信息
 *  @param aError 错误信息（如果为nil，则表示无错误）
 */
-(void)didLogoffWithInfo:(NSDictionary *)aInfo 
                   error:(EMError *)aError;

/**
 *  用户修改密码操作的回调
 *
 *  @param aLoginInfo 用户信息
 *  @param aError     错误信息（如果为nil，则表示无错误）
 */
-(void)didChangePassword:(NSDictionary *)aLoginInfo
                   error:(EMError *)aError;

#pragma mark - user
/**
 *  修改用户信息时的回调操作
 *
 *  @param updatedUser 更新后的用户信息
 *  @param error       错误信息（如果为nil，则表示无错误）
 */
-(void)didUpdateUser:(id<IUserBase>)updatedUser
               error:(EMError *)error;

/**
 *  通过username查找用户信息时的回调操作
 *
 *  @param user  查找到的用户信息
 *  @param error 错误信息（如果为nil，则表示无错误）
 */
-(void)didFindUser:(id<IUserBase>)user 
                    error:(EMError *)error;

/**
 *  通过多个username查找用户列表时返回的用户信息
 *
 *  @param users 查找到的用户列表
 *  @param error 错误信息（如果为nil，则表示无错误）
 */
-(void)didFindUsers:(NSArray *)users
              error:(EMError *)error;

/**
 *  注册新公司完成时的回调操作
 *
 *  @param appKey 注册成功后返回的该公司appKey
 *  @param error  错误信息（如果为nil，则表示无错误）
 */
-(void)didRegisterNewCompany:(NSString *)appKey
                       error:(EMError *)error;

/**
 *  通过公司名查找 appKey操作完成时的回调
 *
 *  @param appKey 查找时返回的appKey信息
 *  @param error  错误信息（如果为nil，则表示无错误）
 */
-(void)didFindAppKeyWithCompany:(NSString *)appKey
                          error:(EMError *)error;

/**
 *  批量注册新用户操作完成时的回调
 *
 *  @param usernames 注册后的用户名列表
 *  @param password  注册时的密码
 *  @param error     错误信息（如果为nil，则表示无错误）
 */
-(void)didRegisterNewUsers:(NSArray *)usernames
       withDefaultPassword:(NSString *)password
                     error:(EMError *)error;

/**
 *  删除用户操作完成时的回调
 *
 *  @param user  被删除的用户信息
 *  @param error 错误信息（如果为nil，则表示无错误）
 */
-(void)didDeleteUser:(id<IUserBase>)user
               error:(EMError *)error;

/**
 *  更新用户信息操作完成后的回调
 *
 *  @param userList 更新后的用户信息列表
 */
-(void)didUpdateUserList:(NSArray *)userList;

@end
