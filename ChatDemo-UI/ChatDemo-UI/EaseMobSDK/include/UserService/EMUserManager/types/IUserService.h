//
//  IUserService.h
//  EaseMob
//
//  Created by Ji Fang on 7/1/13.
//  Copyright (c) 2013 Ji Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMError;
@protocol IUserBase;

/**
 *  此协议包括:使用用户名密码登录、修改用户信息、查找用户、注册用户等操作
 */
@protocol IUserService <NSObject>

@required
#pragma mark - user
/**
 *  同步方法, 使用用户名和密码进行登录.
 *
 *  @param username 登录时的用户名
 *  @param password 登录时的密码
 *  @param pError   错误信息（如果为nil，则表示无错误）
 *
 *  @return 登录后返回的用户信息(若登录失败, 则返回nil)
 */
- (NSDictionary *)loginWithUsername:(NSString *)username
                          password:(NSString *)password
                             error:(EMError **)pError;

/**
 *  同步方法, 注销当前登录的用户
 *
 *  @param pError 错误信息（如果为nil，则表示无错误）
 *
 *  @return
 */
- (NSDictionary *)logoffWithError:(EMError **)pError;

/**
 *  同步方法, 通过用户名修改用户的信息
 *
 *  @param username   被修改的用户username
 *  @param attributes 被修改的key的value(需要与keys一一对应)
 *  @param keys       被修改的key(需要与values一一对应)
 *  @param pError     错误信息（如果为nil，则表示无错误）
 *
 *  @return 更新后的用户信息
 */
- (id<IUserBase>)updateUserByUsername:(NSString *)username
                 withAttributes:(NSArray *)attributes
                        andKeys:(NSArray *)keys
                          error:(EMError **)pError;

/**
 *  同步方法, 通过username去服务器查找用户信息
 *
 *  @param username 用户名
 *  @param pError   错误信息（如果为nil，则表示无错误）
 *
 *  @return 查询结果
 */
- (id<IUserBase>)findUserByUsername:(NSString *)username
                        error:(EMError **)pError;

/**
 *  同步方法, 通过关键字查找user列表
 *
 *  @param keyword 关键字
 *  @param error   查询失败时的错误信息
 *
 *  @return 查询结果
 */
- (NSArray *)findUsersByKeyword:(NSString *)keyword
                         error:(EMError **)error;
/**
 *  通过username数组, 批量查找用户信息
 *
 *  @param usernames username数组(由NSString对象cfxe)
 *  @param pError    错误信息（如果为nil，则表示无错误）
 *
 *  @return 查询结果
 */
- (NSArray *)findUsersByUsernames:(NSArray *)usernames
                      error:(EMError **)pError;

/**
 *  同步方法, 从服务器获取所有用户列表
 *
 *  @param pError 错误信息（如果为nil，则表示无错误）
 *
 *  @return 查询结果
 */
- (NSArray *)findAllUsersWithError:(EMError **)pError;

/**
 *  同步方法, 注册一个新公司
 *
 *  @param company 公司名称
 *  @param pError  错误信息（如果为nil，则表示无错误）
 *
 *  @return 注册成功后, 公司的appKey
 */
- (NSString *)registerNewCompany:(NSString *)company
                      withError:(EMError **)pError;

/**
 *  同步方法, 通过公司名, 查找公司的appKey
 *
 *  @param companyName 公司名称
 *  @param pError      错误信息（如果为nil，则表示无错误）
 *
 *  @return 查询结果(公司的appKey)
 */
- (NSString *)findAppKeyWithCompanyName:(NSString *)companyName
                                 error:(EMError **)pError;

/**
 *  同步方法, 批量注册新用户
 *
 *  @param usernames 批量注册的用户名
 *  @param password  统一的注册密码
 *  @param userInfo  注册时的用户信息
 *  @param pError    错误信息（如果为nil，则表示无错误）
 *
 *  @return 注册成功或失败
 */
- (BOOL)registerNewUsers:(NSArray *)usernames
    withDefaultPassword:(NSString *)password
               userInfo:(NSDictionary *)userInfo
                  error:(EMError **)pError;

- (BOOL)changePassword:(NSString *)oldPassword
          newPassword:(NSString *)newPassword
              forUser:(NSString *)username
                error:(EMError **)pError;

- (id<IUserBase>)deleteUser:(NSString *)username
                     error:(EMError **)pError;

@end
