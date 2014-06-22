/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "RandViewController+Login.h"
#import "RootViewController.h"
#import "UIViewController+HUD.h"
#import "WCAlertView.h"
#import "EMError.h"
#import "EaseMob.h"
#import "AppDelegate.h"

@implementation RandViewController (Login)

// 登陆
-(void)login{
    if (self.usernameTextField.text.length == 0) {
        [WCAlertView showAlertWithTitle:@"登录失败"
                                message:@"请生成登陆账号"
                     customizationBlock:nil
                        completionBlock:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles:nil];
        return;
    }
    [self showHudInView:self.view hint:@"正在登录中..."];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.usernameTextField.text
                                                        password:@"123456"
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         [self hideHud];
         if (error) {
             [self errorMsgShowAlert:error];
         }else {
             NSLog(@"登录成功");
             RootViewController *rootVC = (RootViewController *)[self parentViewController];
             [rootVC removeRandVC];
         }
     } onQueue:nil];
}

-(void)errorMsgShowAlert:(EMError *)error{
    NSString *errorMsg = [NSString
                          stringWithFormat:@"responseCode:%d",error.errorCode];
    
    [WCAlertView showAlertWithTitle:@"登录失败"
                            message:errorMsg
                 customizationBlock:nil
                    completionBlock:nil
                  cancelButtonTitle:@"确定"
                  otherButtonTitles:nil];
}

-(void)logout{
    [[EaseMob sharedInstance].chatManager asyncLogoff];
}


@end
