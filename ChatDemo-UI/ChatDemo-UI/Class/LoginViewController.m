//
//  LoginViewController.m
//  ChatDemo-UI
//
//  Created by xieyajie on 14-5-2.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "LoginViewController.h"

#import "UIViewController+HUD.h"
#import "EMError.h"
@interface LoginViewController ()
{
    UITextField *_nameField;
    UITextField *_passwordField;
    
    UIBarButtonItem *_autoItem;
}

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
    self.title = @"登录";
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _autoItem = [[UIBarButtonItem alloc] initWithTitle:@"自动登录" style:UIBarButtonItemStyleBordered target:self action:@selector(autoResigerAction)];
    [self.navigationItem setRightBarButtonItem:_autoItem];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:tap];
    
    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(40, 40, self.view.frame.size.width - 80, 35)];
    _nameField.borderStyle = UITextBorderStyleRoundedRect;
    _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameField.placeholder = @"用户名";
    UIImageView *nameLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 16)];
    nameLeftView.image = [UIImage imageNamed:@"user"];
    nameLeftView.contentMode = UIViewContentModeScaleAspectFit;
    _nameField.leftView = nameLeftView;
    _nameField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_nameField];
    
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(_nameField.frame) + 20, self.view.frame.size.width - 80, 35)];
    _passwordField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordField.layer.cornerRadius = 3.0;
    _passwordField.placeholder = @"密码";
//    _passwordField.secureTextEntry = YES;
    UIImageView *pswdLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 16)];
    pswdLeftView.contentMode = UIViewContentModeScaleAspectFit;
    pswdLeftView.image = [UIImage imageNamed:@"password"];
    _passwordField.leftView = pswdLeftView;
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_passwordField];
    
    UIButton *resigerButton = [[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(_passwordField.frame) + 20, (self.view.frame.size.width - 100) / 2, 35)];
    resigerButton.layer.cornerRadius = 3.0;
    resigerButton.clipsToBounds = YES;
    [resigerButton setTitle:@"注册" forState:UIControlStateNormal];
    [resigerButton addTarget:self action:@selector(resigerAction) forControlEvents:UIControlEventTouchUpInside];
    [resigerButton setBackgroundImage:[[UIImage imageNamed:@"blueImage"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [self.view addSubview:resigerButton];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(resigerButton.frame) + 20, CGRectGetMaxY(_passwordField.frame) + 20, CGRectGetWidth(resigerButton.frame), 35)];
    loginButton.layer.cornerRadius = 3.0;
    loginButton.clipsToBounds = YES;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setBackgroundImage:[[UIImage imageNamed:@"blueImage"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [_nameField resignFirstResponder];
        [_passwordField resignFirstResponder];
    }
}

- (void)autoResigerAction
{
    [self.view endEditing:YES];
    _autoItem.enabled = NO;
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
    _passwordField.text = @"123456";
    _nameField.text = [randString lowercaseString];
    
    [self showHudInView:self.view hint:@"注册中..."];
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:_nameField.text password:_passwordField.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        [self hideHud];
        if (!error) {
            [self loginAction];
        }
        else {
            _autoItem.enabled = YES;
            _passwordField.text = @"";
            _nameField.text = @"";
            [self showHint:@"注册失败,请重新生成账号"];
        }
    } onQueue:nil];
}

- (void)resigerAction
{
    _autoItem.enabled = NO;
    if (_nameField.text.length == 0 || _passwordField.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名和密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    [self.view endEditing:YES];
    [self showHudInView:self.view hint:@"注册中..."];
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:_nameField.text password:_passwordField.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        [self hideHud];
        _autoItem.enabled = YES;
        if (!error) {
            [self loginAction];
        }
        else {
            [self showHint:@"注册失败,请重试"];
        }
    } onQueue:nil];
}

- (void)loginAction
{
    _autoItem.enabled = NO;
    if (_nameField.text.length == 0 || _passwordField.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名和密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    [self.view endEditing:YES];
    [self showHudInView:self.view hint:@"登录中..."];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:_nameField.text password:_passwordField.text completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         [self hideHud];
         _autoItem.enabled = YES;
         if (error == nil && loginInfo != nil && [loginInfo count] > 0) {
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
         }
         else {
             [self showHint:@"登录失败"];
         }
     } onQueue:nil];
}

@end
