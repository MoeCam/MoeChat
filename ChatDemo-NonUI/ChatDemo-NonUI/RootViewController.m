//
//  RootViewController.m
//  ChatDemo-NonUI
//
//  Created by dujiepeng on 14-4-1.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "RootViewController.h"
#import "RootViewController+sendChat.h"
#import "EaseMob.h"
#import "RandViewController.h"

@interface RootViewController (){
    UITextView *_textView;
    UITextField *_textField;
}

@property (nonatomic, strong) RandViewController *randVC;
@end

@implementation RootViewController

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
    [self registerNotification];
    if([UIDevice currentDevice].systemVersion.floatValue >= 7.0){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self addBgTapEvent];
    [self instanceUIeElement];
    
    [self addRandVC];
}

-(void)addRandVC{
    // 随机生成账号页面
    _randVC = [[RandViewController alloc] init];
    _randVC.view.frame = self.view.bounds;
    [self addChildViewController:_randVC];
    [self.view addSubview:_randVC.view];
}

-(void)instanceUIeElement{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 20, self.view.bounds.size.width - 60, 30)];
    _textField.placeholder = @"请输入消息";
    [self uiElementBoard:_textField];
    [self.view addSubview:_textField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = _textField.frame;
    frame.origin.y += frame.size.height + 20;
    btn.frame = frame;
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"发送文本消息" forState:UIControlStateNormal];
    [btn addTarget:self
            action:@selector(sendMessageBtnPressed:)
  forControlEvents:UIControlEventTouchUpInside];
    
    [self uiElementBoard:btn];
    [self.view addSubview:btn];
    
    frame.origin.y += frame.size.height + 10;
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"接收到的消息:";
    [self.view addSubview:label];
    
    frame.origin.y += frame.size.height + 2;
    frame.size.height = 240;
    _textView = [[UITextView alloc] initWithFrame:frame];
    _textView.userInteractionEnabled = NO;
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.backgroundColor = [UIColor blackColor];
    _textView.textColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.8];
    [self.view addSubview:_textView];
}

// 设置UI
-(void)uiElementBoard:(UIView *)view{
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.clipsToBounds = YES;
}

// 添加背景点击事件
-(void)addBgTapEvent{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(bgPressed:)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)bgPressed:(UIGestureRecognizer *)sender{
    [self.view endEditing:YES];
}

-(void)sendMessageBtnPressed:(UIButton *)sender{
    [self.view endEditing:YES];
    if (_textField.text.length > 0) {
        [self sendMessage:_textField.text];
        _textField.text = @"";
    }
}

-(void)receiveMessage:(NSString *)message{
    _textView.text = message;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 注册chat回调函数，以便能接收消息
-(void)registerNotification{
    [[EaseMob sharedInstance].chatManager addDelegate:self
                                        delegateQueue:nil];
}

// 该类对象dealloc之前，反注册chat回调函数。
-(void)unregisterNotifiaction{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

-(void)dealloc{
    [self unregisterNotifiaction];
}

#pragma mark - EMChatManagerDelegate
-(void)didReceiveMessage:(EMMessage *)message{
 
    EMMessageBody *body = message.messageBodies.lastObject;
    if (body.messageBodyType == eMessageBodyType_Text) {
        if (!_textView.text || _textView.text.length == 0) {
            _textView.text = ((EMTextMessageBody *)body).text;
        }else{
            _textView.text = [NSString stringWithFormat:@"%@\n%@",_textView.text,((EMTextMessageBody *)body).text];
        }
    }
}

// 登陆成功后调用，将randVC移除
-(void)removeRandVC{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.randVC.view.frame;
        frame.origin.y = self.randVC.view.frame.size.height;
        self.randVC.view.frame = frame;
    } completion:^(BOOL finished) {
        [self.randVC.view removeFromSuperview];
        self.randVC = nil;
    }];
}
@end
