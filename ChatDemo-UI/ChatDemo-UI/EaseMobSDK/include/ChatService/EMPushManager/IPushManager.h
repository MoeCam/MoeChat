//
//  IPushManager.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 4/22/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IPushManagerChat.h"

@class EMError;

@protocol IPushManager <IPushManagerChat>

@optional

// didFinishLaunchingWithOptions 回调中, 需要调用此方法
- (void)setupWithOption:(NSDictionary *)launchingOption;

// 注册APNS的推送类型(登录成功时调用)
- (void)registerForRemoteNotificationTypes:(UIRemoteNotificationType)types;

// 上传deviceToken到服务器(didRegisterForRemoteNotificationsWithDeviceToken 回调中, 需要调用此方法)
- (void)registerDeviceToken:(NSData *)deviceToken error:(EMError **)error;
- (void)asyncRegisterDeviceToken:(NSData *)deviceToken;
- (void)asyncRegisterDeviceToken:(NSData *)deviceToken
                      completion:(void (^)(EMError *error))completion;

// 注销当前设备 (退出登录时调用)
- (void)unregisterDeviceWithError:(EMError **)error;
- (void)asyncUnregisterDevice;
- (void)asyncUnregisterDeviceWithCompletion:(void (^)(EMError *error))completion;

// 处理远程通知(didReceiveRemoteNotification 方法中需要调用此方法)
- (void)handleRemoteNotification:(NSDictionary *)remoteInfo;

// 注册一个topic列表
- (void)registerTopics:(NSArray *)topics error:(EMError **)error;
- (void)asyncRegisterTopics:(NSArray *)topics;
- (void)asyncRegisterTopics:(NSArray *)topics
                 completion:(void (^)(EMError *error))completion;

@end
