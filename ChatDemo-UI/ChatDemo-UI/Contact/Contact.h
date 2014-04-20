//
//  XDContact.h
//  leCar
//
//  Created by dujiepeng on 14-1-24.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *author_active_region;
@property (nonatomic, copy) NSString *friendMomentPicture;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *memo;

-(id)initWithRawUser:(id<IUserBase>)user;
@end
