//
//  EMChatManagerLoginDelegate.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 3/26/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMError;

/**
 *  本协议包括：登录成功的回调、登录失败的回调、修改密码的回调、账号在其它设置上登录时的回调操作
 */
@protocol EMChatManagerLoginDelegate <NSObject>

@optional
/**
 *  用户登录后的回调
 *
 *  @param loginInfo 登录的用户信息
 *  @param error     错误信息
 */
-(void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error;

/**
 *  用户注销后的回调
 *
 *  @param error 错误信息
 */
-(void)didLogoffWithError:(EMError *)error;

/**
 *  修改密码后的回调
 *
 *  @param aLoginInfo 登录的用户信息
 *  @param aError     错误信息
 */
-(void)didChangePassword:(NSDictionary *)aLoginInfo
                   error:(EMError *)aError;

/**
 *  当前登录账号在其它设备登录时的通知回调
 */
-(void)didLoginFromOtherDevice;

@end
