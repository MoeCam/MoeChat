//
//  LoginViewController.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "LoginViewController.h"



@interface LoginViewController ()<IChatManagerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)doRegister:(id)sender;
- (IBAction)doLogin:(id)sender;


@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpForDismissKeyboard];
    _usernameTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}
- (IBAction)doRegister:(id)sender {
    if (![self isEmpty]) {
        [self.view endEditing:YES];
        [self showHudInView:self.view hint:@"正在注册..."];
        [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:_usernameTextField.text
                                                             password:_passwordTextField.text
                                                       withCompletion:
         ^(NSString *username, NSString *password, EMError *error) {
             [self hideHud];
             if (!error) {
                 TTAlertNoTitle(@"注册成功,请登录");
             }else{
                 TTAlertNoTitle(@"注册失败");
             }
         } onQueue:nil];
    }
}

- (IBAction)doLogin:(id)sender {
    if (![self isEmpty]) {
        [self.view endEditing:YES];
        [self showHudInView:self.view hint:@"正在登录..."];
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:_usernameTextField.text
                                                            password:_passwordTextField.text
                                                          completion:
         ^(NSDictionary *loginInfo, EMError *error) {
             [self hideHud];
             if (loginInfo && !error) {
                 [[NSNotificationCenter defaultCenter]postNotificationName:KNOTIFICATION_LOGINCHANGE
                                                                    object:nil
                                                                  userInfo:nil];
             }else {
                 TTAlertNoTitle(@"登录失败");
             }
         } onQueue:nil];
    }
}


- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    if (username.length == 0 || password.length == 0) {
        ret = YES;
        [WCAlertView showAlertWithTitle:@"提示"
                                message:@"请输入账号和密码"
                     customizationBlock:nil
                        completionBlock:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles: nil];
    }
    
    return ret;
}


#pragma  mark - TextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _usernameTextField) {
        _passwordTextField.text = @"";
    }
    
    return YES;
}

@end
