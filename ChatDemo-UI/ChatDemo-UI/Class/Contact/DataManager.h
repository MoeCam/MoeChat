//
//  DataManager.h
//  ChatDemo-UI
//
//  Created by dhcdht on 14-5-15.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ContactsViewController.h"

@interface DataManager : NSObject<IChatManagerDelegate>

@property (strong, nonatomic, readonly) NSMutableArray *applyArray;

@property (strong, nonatomic) ContactsViewController *contactsController;

+ (instancetype)defaultManager;

@end
