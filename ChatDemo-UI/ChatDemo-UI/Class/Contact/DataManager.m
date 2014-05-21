//
//  DataManager.m
//  ChatDemo-UI
//
//  Created by dhcdht on 14-5-15.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "DataManager.h"

static DataManager *defaultManager = nil;

@implementation DataManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _applyArray = [NSMutableArray array];
        
#warning 以下两行代码必须写，注册为SDK的ChatManager的delegate
        [[EaseMob sharedInstance].chatManager removeDelegate:self];
        //注册为SDK的ChatManager的delegate
        [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    }
    
    return self;
}

+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[DataManager alloc] init];
    });
    
    return defaultManager;
}

- (void)dealloc
{
#warning 以下第一行代码必须写，将self从ChatManager的代理中移除
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)clear
{
    [_applyArray removeAllObjects];
}

#pragma mark - EMChatManagerBuddyDelegate

- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    if (!username) {
        return;
    }
    if (!message) {
        message = @"";
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"username":username, @"applyMessage":message, @"acceptState":@NO}];
    [_applyArray addObject:dic];
    
    if (_contactsController) {
        [_contactsController reloadContacts];
    }
}

- (void)didUpdateBuddyList:(NSArray *)buddyList
            changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd
{
    for (EMBuddy *tmpBuudy in changedBuddies) {
        for (EMBuddy *buudy in buddyList) {
            if ([tmpBuudy.username isEqualToString:buudy.username]) {
                buudy.isPendingApproval = isAdd;
            }
        }
    }
    if (_contactsController) {
        [_contactsController reloadContacts];
    }
}


@end
