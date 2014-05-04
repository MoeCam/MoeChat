//
//  RandViewController.h
//  ChatDemo-NonUI
//
//  Created by dujiepeng on 14-5-3.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandViewController : UIViewController
@property (nonatomic) BOOL isRegister;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end
