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

#import "RandViewController+Register.h"
#import "UIViewController+HUD.h"
#import "WCAlertView.h"
#import "EaseMob.h"

@implementation RandViewController (Register)
-(void)registerRandUsername{
    if (self.isRegister) {
        [WCAlertView showAlertWithTitle:nil
                                message:@"已生成成功，请直接登录"
                     customizationBlock:nil
                        completionBlock:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles:nil];

        return;
    }
    NSString *randString = @"";
    int i,j,k,b;
    char a[10][10],tmp[10];
    srand((unsigned)time(NULL));
    for (j=1;j<10;j++)
    {
        for (i=0;i<10;i++)
        {
            b=rand()%93+48;
            if ((b>='0' && b<='9')||
                (b>='a' && b<='z')||
                (b>='A' && b<='Z'))
            {
                tmp[i] =(char) b;
                for (k=0;k<j;k++)
                {
                    if (strcmp(tmp,a[0])==0)
                    {
                        i--;
                        break;
                    }
                }
            }
            else
            {
                i--;
            }
        }
    }
    randString = [NSString stringWithFormat:@"%s",tmp];
    randString = [randString substringToIndex:10];
    [self showHudInView:self.view hint:@"正在生成..."];
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:randString
                                                         password:@"123456"
                                                   withCompletion:
     ^(NSString *username, NSString *password, EMError *error) {
         [self hideHud];
         if (!error) {
             self.usernameTextField.text = randString;
             self.passwordTextField.text = @"123456";
             self.isRegister = YES;
         }else{
             NSLog(@"注册失败");
         }
     } onQueue:nil];
    
}
@end
