//
//  EMBuddyServiceDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/22/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBuddyGroup;
@protocol IUserBase;
@class EMError;

/**
 *  本协议包括：获取好友分组信息、添加分组、删除分组、添加好友、删除好友、添加黑名单等操作时的回调处理
 */
@protocol EMBuddyServiceDelegate <NSObject>

@optional
/**
 *  获取好友分组信息操作完成后的回调
 *
 *  @param groups 服务器返回的分组信息
 *  @param error  错误信息（如果为nil，则表示无错误）
 */
-(void)didFetchBuddyGroupList:(NSArray *)groups 
                        error:(EMError *)error;

/**
 *  添加好友分组操作完成后的回调
 *
 *  @param contact 添加的好友信息
 *  @param group   分组信息
 *  @param error   错误信息（如果为nil，则表示无错误）
 */
-(void)didAddBuddy:(id<IUserBase>)contact
           toGroup:(id<IBuddyGroup>)group
             error:(EMError *)error;

/**
 *  删除好友分组操作完成后的回调
 *
 *  @param contact 添加的好友信息
 *  @param group   分组信息
 *  @param error   错误信息（如果为nil，则表示无错误）
 */
-(void)didRemoveBuddy:(id<IUserBase>)contact
            fromGroup:(id<IBuddyGroup>)group
                error:(EMError *)error;

/**
 *  屏蔽好友(加黑名单)操作完成后的回调
 *
 *  @param contact 屏蔽的好友
 *  @param error   错误信息（如果为nil，则表示无错误）
 */
-(void)didBlockBuddy:(id<IUserBase>)contact
               error:(EMError *)error;

/**
 *  取消屏蔽好友(取消黑名单)操作完成后的回调
 *
 *  @param contact 屏蔽的好友
 *  @param error   错误信息（如果为nil，则表示无错误）
 */
-(void)didUnBlockBuddy:(id<IUserBase>)contact
                 error:(EMError *)error;

/**
 *  创建好友分组操作完成后的回调
 *
 *  @param buddyGroup 创建成功后的分组信息
 *  @param error      错误信息（如果为nil，则表示无错误）
 */
-(void)didCreateBuddyGroup:(id<IBuddyGroup>)buddyGroup
                     error:(EMError *)error;

/**
 *  删除分组操作完成后的回调
 *
 *  @param buddyGroup 删除成功后的分组信息
 *  @param error      错误信息（如果为nil，则表示无错误）
 */
-(void)didDeleteBuddyGroup:(id<IBuddyGroup>)buddyGroup
                     error:(EMError *)error;

@end
