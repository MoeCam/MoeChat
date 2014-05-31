//
//  CreateChatRoomViewController.m
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-30.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "CreateChatRoomViewController.h"

#import "ContactSelectionViewController.h"

@interface CreateChatRoomViewController ()<UITextFieldDelegate, EMChooseViewDelegate>

@property (strong, nonatomic) UITextField *textField;

@end

@implementation CreateChatRoomViewController

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
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.title = @"创建群组";
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"添加成员" style:UIBarButtonItemStylePlain target:self action:@selector(addContacts:)]];
    
    [self.view addSubview:self.textField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 40)];
        _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 3;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:15.0];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = @"请输入群组名称";
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
    }
    
    return _textField;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - EMChooseViewDelegate

- (void)viewController:(EMChooseViewController *)viewController didFinishSelectedSources:(NSArray *)selectedSources
{
    
}

#pragma mark - action

- (void)addContacts:(id)sender
{
    ContactSelectionViewController *selectionController = [[ContactSelectionViewController alloc] init];
    selectionController.delegate = self;
    [self.navigationController pushViewController:selectionController animated:YES];
}

@end
