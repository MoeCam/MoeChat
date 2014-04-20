//
//  ContactManager.m
//  ChatDemo-UI
//
//  Created by dujiepeng on 14-4-20.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "ContactManager.h"

@interface ContactManager (){
    NSArray *_contacts;
}

@end

@implementation ContactManager
+(ContactManager *)shareInstance{
    static dispatch_once_t onceToken;
    __strong static ContactManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[ContactManager alloc] init];
    });
    return manager;
}

+(NSArray *)contacts{
    return [[ContactManager shareInstance] contacts];
}
+(void)setContacts:(NSArray *)contacts{
    [[ContactManager shareInstance] setContacts:contacts];
}

-(NSArray *)contacts{
    return _contacts;
}
-(void)setContacts:(NSArray *)contacts{
    _contacts = contacts;
}
@end
