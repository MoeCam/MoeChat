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
 *  所有不带Block回调的异步方法, 需要监听回调时, 需要先将要接受回调的对象注册到delegate中, 示例代码如下:
 *  [[[EaseMob sharedInstance] userManager] addDelegate:self delegateQueue:dispatch_get_main_queue]
 */
@class EMError;
@protocol IUserBase;
@protocol IUserManagerUser <IUserManagerBase>

@required
#pragma mark - user
/**
 *  同步方法, 更新用户信息
 *
 *  @param username   需要更新信息的用户username
 *  @param attributes 修改的value数组(需要与keys 一一对应)
 *  @param keys       修改的key数组(需要与value一一对应)
 *  @param pError     错误信息
 *
 *  @return 修改后的用户信息
 */
- (id<IUserBase>)updateUserByUsername:(NSString *)username
                      withAttributes:(NSArray *)attributes
                             andKeys:(NSArray *)keys
                               error:(EMError **)pError;

/**
 *  异步方法, 更新用户信息
 *
 *  @param username   需要更新信息的用户username
 *  @param attributes 修改的value数组(需要与keys 一一对应)
 *  @param keys       修改的key数组(需要与value一一对应)
 */
- (void)asyncUpdateUserByUsername:(NSString *)username 
                  withAttributes:(NSArray *)attributes
                         andKeys:(NSArray *)keys;

/**
 *  异步方法, 更新用户信息
 *
 *  @param username   需要更新信息的用户username
 *  @param attributes 修改的value数组(需要与keys 一一对应)
 *  @param keys       修改的key数组(需要与value一一对应)
 *  @param completion 请求完成后的回调
 *  @param aQueue     block回调时的线程
 */
- (void)asyncUpdateUserByUsername:(NSString *)username 
                  withAttributes:(NSArray *)attributes
                         andKeys:(NSArray *)keys 
                      completion:(void (^)(id<IUserBase> updatedUser, 
                                           EMError *error))completion
                         onQueue:(dispatch_queue_t)aQueue;

/**
 *  通过username查找用户信息
 *
 *  @param username 需要获取信息的username
 *  @param pError   错误信息
 *
 *  @return 查找结果
 */
- (id<IUserBase>)findUserByUsername:(NSString *)username
                             error:(EMError **)pError;

/**
 *  异步查找用户信息
 *
 *  @param username 用户名
 */
- (void)asyncFindUserByUsername:(NSString *)username;

/**
 *  异步查找用户信息
 *
 *  @param username   用户名
 *  @param completion 完成后的block回调
 *  @param aQueue     block回调时的线程
 */
- (void)asyncFindUserByUsername:(NSString *)username 
                    completion:(void (^)(id<IUserBase> user, 
                                         EMError *error))completion 
                       onQueue:(dispatch_queue_t)aQueue;

/**
 *  查找数组中的用户信息
 *
 *  @param usernames 需要查找的username数组
 *  @param pError    错误信息
 *
 *  @return 查询结果
 */
- (NSArray *)findUsersByUsernames:(NSArray *)usernames
                           error:(EMError **)pError;

/**
 *  异步查找数组中的用户信息
 *
 *  @param usernames 需要查找的username数组
 */
- (void)asyncFindUsersByUsernames:(NSArray *)usernames;

/**
 *  异步查找数组中的用户信息
 *
 *  @param usernames  需要查找的username数组
 *  @param completion 请求完成后的回调
 *  @param aQueue     block回调时的线程
 */
- (void)asyncFindUsersByUsernames:(NSArray *)usernames 
                      completion:(void (^)(NSArray *users, 
                                           EMError *error))completion 
                         onQueue:(dispatch_queue_t)aQueue;

/**
 *  同步方法, 获取所有用户信息
 *
 *  @param pError 错误信息
 *
 *  @return 查询结果
 */
- (NSArray *)findAllUsersWithError:(EMError **)pError;

/**
 *  异步方法, 获取所有用户信息
 */
- (void)asyncFindAllUsers;

/**
 *  异步方法, 获取所有用户信息
 *
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
- (void)asyncFindAllUsersWithCompletion:(void (^)(NSArray *users, 
                                                 EMError *error))completion
                               onQueue:(dispatch_queue_t)aQueue;

/**
 *  同步方法, 注册一个公司
 *
 *  @param company 公司名
 *  @param pError  错误信息
 *
 *  @return 注册成功后的公司信息
 */
- (NSDictionary *)registerNewCompany:(NSString *)company
                          withError:(EMError **)pError;

/**
 *  异步方法, 注册一个公司
 *
 *  @param company 公司名称
 */
- (void)asyncRegisterNewCompany:(NSString *)company;

/**
 *  异步方法, 注册一个公司
 *
 *  @param company    公司名称
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
- (void)asyncRegisterNewCompany:(NSString *)company
                    completion:(void (^)(NSDictionary *info, 
                                         EMError *error))completion 
                       onQueue:(dispatch_queue_t)aQueue;

/**
 *  同步方法, 通过公司名查找appkey
 *
 *  @param company 公司名
 *  @param pError  错误信息
 *
 *  @return 查找到的appkey
 */
- (NSString *)findAppKeyWithCompany:(NSString *)company
                         withError:(EMError **)pError;

/**
 *  异步方法, 通过公司名查找appkey
 *
 *  @param company 公司名
 */
- (void)asyncFindAppKeyWithCompany:(NSString *)company;

/**
 *  异步方法, 通过公司名查找appkey
 *
 *  @param company    公司名
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
- (void)asyncFindAppKeyWithCompany:(NSString *)company
                       completion:(void (^)(NSString *appKey,
                                        EMError *error))completion
                          onQueue:(dispatch_queue_t)aQueue;

/**
 *  同步方法, 注册多个用户
 *
 *  @param usernames 用户名列表
 *  @param password  密码
 *  @param userInfo  注册时的用户信息
 *  @param pError    错误信息
 *
 *  @return 注册成功或失败
 */
- (BOOL)registerNewUsers:(NSArray *)usernames
    withDefaultPassword:(NSString *)password
               userInfo:(NSDictionary *)userInfo
                  error:(EMError **)pError;
/**
 *  异步方法, 注册多个用户
 *
 *  @param usernames 用户名列表
 *  @param password  密码
 *  @param userInfo  注册时的用户信息
 */
- (void)asyncRegisterNewUsers:(NSArray *)usernames
         withDefaultPassword:(NSString *)password
                    userInfo:(NSDictionary *)userInfo;

/**
 *  异步方法, 注册多个用户
 *
 *  @param usernames  用户名列表
 *  @param password   密码
 *  @param userInfo   注册时的用户信息
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
- (void)asyncRegisterNewUsers:(NSArray *)usernames
         withDefaultPassword:(NSString *)password
                    userInfo:(NSDictionary *)userInfo
                  completion:(void (^)(NSArray *usernames, 
                                       NSString *password,
                                       EMError *error))completion 
                     onQueue:(dispatch_queue_t)aQueue;

/**
 *  同步方法, 删除用户
 *
 *  @param username 需要删除的用户名
 *  @param pError   错误信息
 *
 *  @return 删除时的用户信息
 */
- (id<IUserBase>)deleteUser:(NSString *)username
                     error:(EMError **)pError;

/**
 *  异步方法, 删除用户
 *
 *  @param username 需要删除的用户名
 */
- (void)asyncDeleteUser:(NSString *)username;

/**
 *  异步方法, 删除用户
 *
 *  @param username   需要删除的用户名
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
- (void)asyncDeleteUser:(NSString *)username
            completion:(void (^)(id<IUserBase> user, 
                                 EMError *error))completion 
               onQueue:(dispatch_queue_t)aQueue;

@end
