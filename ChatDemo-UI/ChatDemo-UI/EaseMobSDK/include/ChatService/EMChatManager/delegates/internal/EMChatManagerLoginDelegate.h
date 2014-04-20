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
-(void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error;
-(void)didLogoffWithError:(EMError *)error;
-(void)didChangePassword:(NSDictionary *)aLoginInfo
                   error:(EMError *)aError;

-(void)didLoginFromOtherDevice;

@end
