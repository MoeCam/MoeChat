//
//  Contact.m
//  demoApp
//
//  Created by dujiepeng on 14-3-19.
//  Copyright (c) 2014年 EaseMob. All rights reserved.
//

#import "Contact.h"
#import "IUserBase.h"


@interface Contact (){
    id<IUserBase> rawUser;
}

@end

@implementation Contact


-(id)initWithRawUser:(id<IUserBase>)user{
    if (self = [super init]) {
        rawUser = user;
        if (rawUser) {
            self.username = [rawUser attributeForKey:CONTACT_USERNAME];
            self.nickname = [rawUser attributeForKey:CONTACT_NICKNAME];
            self.author_active_region = [rawUser attributeForKey:CONTACT_ADDRESS];
            self.avatar = [rawUser attributeForKey:CONTACT_AVATAR];
            self.signature = [rawUser attributeForKey:CONTACT_SIGNATURE];
            self.friendMomentPicture = [rawUser attributeForKey:CONTACT_BGPICTURE];
            self.mobile = [rawUser attributeForKey:CONTACT_MOBILE];
            self.email = [rawUser attributeForKey:CONTACT_EMAIL];
        }
    }
    return  self;
}

#pragma mark - actions
-(BOOL)isEqual:(id)object {
    BOOL ret = NO;
    Contact *contact = (Contact *)object;
    if([self.username isEqualToString:contact.username]) {
        ret = YES;
    }
    
    return ret;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@",self.username,self.nickname,self.avatar];
}

@end
