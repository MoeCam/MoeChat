//
//  EMChatManagerBuddyDelegate.h
//  EaseMobClientSDK
//
//  Created by Li Zhiping on 14-5-3.
//  Copyright (c) 2014年 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMChatManagerDelegateBase.h"
#import "IChatManager.h"

@protocol EMChatManagerBuddyDelegate <NSObject>

@optional
/*!
 @method
 @abstract 接收到好友请求时的通知
 @discussion
 @param username 发起好友请求的用户username
 */
- (void)didReceiveBuddyRequest:(NSString *)username;

/*!
 @method
 @abstract 通讯录信息发生变化时的通知
 @discussion
 @param buddyList 好友信息列表
 @param changedBuddies 修改了的用户列表
 @param isAdd (YES为新添加好友, NO为删除好友)
 */
- (void)didUpdateBuddyList:(NSArray *)buddyList
            changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd;

/*!
 @method
 @abstract 好友上线和下线时的通知
 @discussion
 @param isOnline 好友信息列表
 @param username 修改了状态的用户
 */
- (void)didChangedOnlineStatus:(BOOL)isOnline
                      forBuddy:(NSString *)username;

@end
