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

@required

// didFinishLaunchingWithOptions 回调中, 需要调用此方法
- (void)setupWithOption:(NSDictionary *)launchingOption;

// 注册APNS的推送类型(登录成功时调用)
- (void)registerForRemoteNotificationTypes:(UIRemoteNotificationType)types;

// 上传deviceToken到服务器(didRegisterForRemoteNotificationsWithDeviceToken 回调中, 需要调用此方法)
- (void)asyncRegisterDeviceToken:(NSData *)deviceToken;

// 注销当前设备 (退出登录时调用)
- (void)unregisterDeviceWithError:(EMError **)error;
- (void)asyncUnregisterDevice;
- (void)asyncUnregisterDeviceWithCompletion:(void (^)(EMError *error))completion 
                                    onQueue:(dispatch_queue_t)aQueue;

// 处理远程通知(didReceiveRemoteNotification 方法中需要调用此方法)
- (void)handleRemoteNotification:(NSDictionary *)remoteInfo;

- (BOOL)isPushReady;

@end
