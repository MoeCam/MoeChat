//
//  UserGridDef.h
//  EaseMob
//
//  Created by Ji Fang on 6/11/13.
//  Copyright (c) 2013 Ji Fang. All rights reserved.
//

#ifndef EaseMob_UserGridDef_h
#define EaseMob_UserGridDef_h

#import "commonDefs.h"

#define kEaseMobAppKey [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_APPKEY"]

#define kEaseMobAPIUrl [[NSDictionary dictionaryWithContentsOfURL:\
                        [[NSBundle bundleWithURL:[[NSBundle mainBundle] \
                        URLForResource:@"EaseMob" withExtension:@"bundle"]] \
                        URLForResource:@"SDKConfig" withExtension:@"plist"]] \
                        objectForKey:@"EASEMOB_API_URL"]

#define kEaseMobCloudCodeUrl [[NSDictionary dictionaryWithContentsOfURL:\
                        [[NSBundle bundleWithURL:[[NSBundle mainBundle] \
                        URLForResource:@"EaseMob" withExtension:@"bundle"]] \
                        URLForResource:@"SDKConfig" withExtension:@"plist"]] \
                        objectForKey:@"EASEMOB_CLOUDCODE_URL"]

#define kEaseMobOrgKey [[NSDictionary dictionaryWithContentsOfURL:\
                        [[NSBundle bundleWithURL:[[NSBundle mainBundle] \
                        URLForResource:@"EaseMob" withExtension:@"bundle"]] \
                        URLForResource:@"SDKConfig" withExtension:@"plist"]] \
                        objectForKey:@"EASEMOB_ORGKEY"]

// login info keys
#define kUserLoginInfoUsername     @"kUserLoginInfoUsername"
#define kUserLoginInfoPassword     @"kUserLoginInfoPassword"
#define kUserLoginInfoCompany      @"kUserLoginInfoCompany"
#define kUserLoginInfoAppkey       @"kUserLoginInfoAppkey"
#define kUserLoginInfoToken        @"kUserLoginInfoToken"
#define kUserLoginInfoOrganization @"kUserLoginInfoOrganization"

#endif
