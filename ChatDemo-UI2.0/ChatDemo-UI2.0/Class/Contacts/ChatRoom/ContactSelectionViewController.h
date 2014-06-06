//
//  ContactSelectionViewController.h
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-5-31.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import "EMChooseViewController.h"

@interface ContactSelectionViewController : EMChooseViewController

@property (strong, nonatomic) NSMutableArray *selectedContacts;
@property (strong, nonatomic) NSString *groupName;
@property (strong, nonatomic) NSString *groupBrief;

@property (copy) void (^CreateRoomFinished)(BOOL success);

@end
