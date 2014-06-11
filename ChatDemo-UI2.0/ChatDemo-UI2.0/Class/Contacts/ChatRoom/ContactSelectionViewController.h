//
//  ContactSelectionViewController.h
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-31.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "EMChooseViewController.h"

@interface ContactSelectionViewController : EMChooseViewController

@property (copy) void (^SelectedContactsFinished)(ContactSelectionViewController *viewController, NSArray *selectedContacts);

//已有选中的成员username，在该页面，这些成员不能被取消选择
- (instancetype)initWithBlockSelectedUsernames:(NSArray *)blockUsernames;

@end
