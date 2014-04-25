//
//  IUserManagerBuddyGroup.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 3/16/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUserManagerBase.h"

@protocol IUserBase;
@protocol IBuddyGroup;
@protocol IDepartment;
@class EMError;

/**
 *  好友分组管理协议，主要用于获取好友分组列表、添加好友、删除好友、添加黑名单等操作
 *  所有不带Block回调的异步方法, 需要监听回调时, 需要先将要接受回调的对象注册到delegate中, 示例代码如下:
 *  [[[EaseMob sharedInstance] userManager] addDelegate:self delegateQueue:dispatch_get_main_queue];
 */
@protocol IUserManagerBuddyGroup <IUserManagerBase>

@required
#pragma mark - buddy groups
/**
 *  同步获取用户的好友分组信息
 *
 *  @param pError 获取信息发生错误时返回的错误信息
 *
 *  @return 获取成功后的好友分组信息
 */
-(NSArray *)fetchBuddyGroupsWithError:(EMError **)pError;

/**
 *  异步获取好友的用户信息
 */
-(void)asyncFetchBuddyGroups;

/**
 *  异步获取用户分组信息
 *
 *  @param completion 用户分组信息完成后的block回调
 *  @param aQueue     回调时的queue
 */
-(void)asyncFetchBuddyGroupsWithCompletion:(void (^)(NSArray *groups, 
                                                     EMError *error))completion 
                                   onQueue:(dispatch_queue_t)aQueue;

#pragma mark - add buddy.
/**
 *  同步方法, 添加好友到分组
 *
 *  @param contact   好友信息
 *  @param groupName 分组名称
 *  @param pError    获取信息发生错误时返回的错误信息
 *
 *  @return
 */
-(id<IBuddyGroup>)addBuddy:(id<IUserBase>)contact
                   toGroup:(NSString *)groupName 
                     error:(EMError **)pError;

/**
 *  异步添加好友到分组
 *
 *  @param contact   需要添加的用户信息
 *  @param groupName 分组名称
 */
-(void)asyncAddBuddy:(id<IUserBase>)contact
             toGroup:(NSString *)groupName;

/**
 *  异步添加好友到分组
 *
 *  @param contact    需要添加的好友信息
 *  @param groupName  需要添加到的分组
 *  @param completion 完成后的block回调
 *  @param aQueue     block回调时的queue
 */
-(void)asyncAddBuddy:(id<IUserBase>)contact
             toGroup:(NSString *)groupName 
          completion:(void (^)(id<IUserBase> contact, 
                               id<IBuddyGroup> buddyGroup, 
                               EMError *error))completion
             onQueue:(dispatch_queue_t)aQueue;

#pragma mark - remove buddy.
/**
 *  将用户从分组中移除
 *
 *  @param username  需要被移除的用户username
 *  @param groupName 分组名称
 *  @param pError    发生错误时返回的错误信息
 *
 *  @return 移除用户后的分组信息
 */
-(id<IBuddyGroup>)removeBuddy:(NSString *)username
                    fromGroup:(NSString *)groupName 
                        error:(EMError **)pError;
/**
 *  异步将用户从分组中移除
 *
 *  @param username  用户名
 *  @param groupName 分组名
 */
-(void)asyncRemoveBuddy:(NSString *)username
              fromGroup:(NSString *)groupName;

/**
 *  异步将用户从分组中移除
 *
 *  @param username   用户名
 *  @param groupName  分组名
 *  @param completion 回调
 *  @param aQueue     回调时的线程
 */
-(void)asyncRemoveBuddy:(NSString *)username
              fromGroup:(NSString *)groupName
             completion:(void (^)(id<IUserBase> contact, 
                                  id<IBuddyGroup> buddyGroup, 
                                  EMError *error))completion
                onQueue:(dispatch_queue_t)aQueue;

#pragma mark - is blocked buddy.

/**
 *  判断当前用户是否屏蔽了某个用户
 *
 *  @param username 用户名
 *  @param pError   错误信息
 *
 *  @return 某个用户是否在黑名单中
 */
-(BOOL)isBlocked:(NSString *)username
           error:(EMError **)pError;

#pragma mark - block buddy.
/**
 *  同步方法, 将某个用户加入黑名单
 *
 *  @param username 用户名
 *  @param pError   错误信息
 *
 *  @return
 */
-(id<IUserBase>)blockBuddy:(NSString *)username
                     error:(EMError **)pError;

/**
 *  异步方法, 将某个用户加入黑名单
 *
 *  @param username 用户名
 */
-(void)asyncBlockBuddy:(NSString *)username;

/**
 *  异步方法, 将某个用户加入黑名单
 *
 *  @param username     用户名
 *  @param completion   回调
 *  @param aQueue       回调时的线程
 */
-(void)asyncBlockBuddy:(NSString *)username 
            completion:(void (^)(id<IUserBase> contact, 
                                 EMError *error))completion 
               onQueue:(dispatch_queue_t)aQueue;

#pragma mark - unblock buddy.
/**
 *  同步方法, 将某个用户从黑名单中移除
 *
 *  @param username 用户名
 *  @param pError   错误信息
 *
 *  @return
 */
-(id<IUserBase>)unBlockBuddy:(NSString *)username
                       error:(EMError **)pError;
/**
 *  异步方法, 将某个用户从黑名单中移除
 *
 *  @param username 用户名
 */
-(void)asyncUnBlockBuddy:(NSString *)username;

/**
 *  异步方法, 将某个用户从黑名单中移除
 *
 *  @param username    用户名
 *  @param completion  回调
 *  @param aQueue      回调时的线程
 */
-(void)asyncUnBlockBuddy:(NSString *)username 
              completion:(void (^)(id<IUserBase> contact, 
                                   EMError *error))completion 
                 onQueue:(dispatch_queue_t)aQueue;

#pragma mark - create buddygroup
/**
 *  同步方法, 创建分组
 *
 *  @param groupName  分组名
 *  @param pError     错误信息
 *
 *  @return 创建成功后的分组信息
 */
-(id<IBuddyGroup>)createBuddyGroupWithName:(NSString *)groupName 
                                     error:(EMError **)pError;

/**
 *  异步方法, 创建分组
 *
 *  @param groupName 分组名
 */
-(void)asyncCreateBuddyGroupWithName:(NSString *)groupName;

/**
 *  异步方法, 创建分组
 *
 *  @param groupName    分组名
 *  @param completion   回调
 *  @param aQueue       回调时的线程
 */
-(void)asyncCreateBuddyGroupWithName:(NSString *)groupName 
                          completion:(void (^)(id<IBuddyGroup> buddyGroup, 
                                               EMError *error))completion
                             onQueue:(dispatch_queue_t)aQueue;

#pragma mark - delete buddygroup

/**
 *  同步方法, 删除分组
 *
 *  @param groupName 分组名
 *  @param pError    错误信息
 *
 *  @return 删除后的分组信息
 */
-(id<IBuddyGroup>)deleteBuddyGroup:(NSString *)groupName
                             error:(EMError **)pError;

/**
 *  异步方法, 删除分组
 *
 *  @param groupName 分组名
 */
-(void)asyncDeleteBuddyGroup:(NSString *)groupName;

/**
 *  异步方法, 删除分组
 *
 *  @param groupName   分组名
 *  @param completion  回调
 *  @param aQueue      回调时的线程
 */
-(void)asyncDeleteBuddyGroup:(NSString *)groupName 
                  completion:(void (^)(id<IBuddyGroup> buddyGroup, 
                                       EMError *error))completion 
                     onQueue:(dispatch_queue_t)aQueue;

@end
