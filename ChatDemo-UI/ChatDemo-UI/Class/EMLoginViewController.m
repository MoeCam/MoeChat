//
//  EMLoginViewController.m
//  ChatDemo-UI
//
//  Created by dhcdht on 14-5-2.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "EMLoginViewController.h"

#import "MBProgressHUD+Add.h"
#import "UIViewController+HUD.h"

@interface EMLoginViewController ()
{
    UITextField *_nameField;
    UITextField *_passwordField;
}

@end

@implementation EMLoginViewController

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
    // Do any additional setup after loading the view.
    self.title = @"登录";
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:tap];
    
    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(40, 40, self.view.frame.size.width - 140, 35)];
    _nameField.borderStyle = UITextBorderStyleRoundedRect;
    _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameField.placeholder = @"用户名";
    UIImageView *nameLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 16)];
    nameLeftView.image = [UIImage imageNamed:@"user"];
    nameLeftView.contentMode = UIViewContentModeScaleAspectFit;
    _nameField.leftView = nameLeftView;
    _nameField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_nameField];
    
    UIButton *resigerButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameField.frame) + 10, 45, 60, 30)];
    resigerButton.layer.cornerRadius = 3.0;
    resigerButton.clipsToBounds = YES;
    [resigerButton setTitle:@"自动生成" forState:UIControlStateNormal];
    [resigerButton addTarget:self action:@selector(resigerAction) forControlEvents:UIControlEventTouchUpInside];
    [resigerButton setBackgroundImage:[[UIImage imageNamed:@"blueImage"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    resigerButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:resigerButton];
    
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
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(_passwordField.frame) + 20, self.view.frame.size.width - 100, 35)];
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

- (void)autoUserAction
{
    
}

- (void)resigerAction
{
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
    _nameField.text = randString;
    
    [self showHudInView:self.view hint:@"注册中..."];
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:randString password:_passwordField.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        [self hideHud];
        if (!error) {
            [self loginAction];
        }
        else {
            _passwordField.text = @"";
            _nameField.text = @"";
            [MBProgressHUD showError:@"注册失败,请重新生成账号" toView:self.view];
        }
    } onQueue:nil];
}

- (void)loginAction
{
    if (_nameField.text.length == 0 || _passwordField.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名和密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    //检测XXInfo.plist中得AppKey是否填写
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appKey = [infoDict objectForKey:@"EASEMOB_APPKEY"];
    if (appKey == nil || appKey.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请在工程XXInfo.plist文件中添加AppKey。如果您还没有AppKey，请前往。。。注册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
//    if ([appKey isEqualToString:@"weiquan9849682"]) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您使用了测试的AppKey,请填写您申请的AppKey" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//        
//        return;
//    }
    [_nameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [self showHudInView:self.view hint:@"登录中..."];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:_nameField.text password:_passwordField.text completion:^(NSDictionary *loginInfo, EMError *error) {
         [self hideHud];
         if (!error) {
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:nil];
         }
         else {
             [MBProgressHUD showError:@"登录失败" toView:self.view];
         }
     } onQueue:nil];
}

@end
