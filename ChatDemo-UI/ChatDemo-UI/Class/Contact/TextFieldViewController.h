//
//  TextFieldViewController.h
//  ChatDemo-UI
//
//  Created by xieyajie on 14-3-10.
//  Copyright (c) 2014年 xieyajie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldViewController : UIViewController

@property (strong, nonatomic) UITextField *textField;
@property (copy) void (^saveFinishCompletion)(NSString *string);
@property (copy) void (^viewDidLoadCompletion)(TextFieldViewController *);

- (void)setViewDidLoadCompletion:(void (^)(TextFieldViewController *))viewDidLoadCompletion;
- (void)setSaveFinishCompletion:(void (^)(NSString *string))saveFinishCompletion;

@end
