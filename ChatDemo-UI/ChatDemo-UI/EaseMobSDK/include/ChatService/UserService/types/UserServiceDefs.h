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

#define kEaseMobAPIUrl [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_API_URL"]
#define kEaseMobCloudCodeUrl [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_CLOUDCODE_URL"]
#define kEaseMobOrgKey [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_ORGKEY"]
#define kEaseMobAppKey [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_APPKEY"]

// login info keys
#define kUserLoginInfoUsername     @"kUserLoginInfoUsername"
#define kUserLoginInfoPassword     @"kUserLoginInfoPassword"
#define kUserLoginInfoCompany      @"kUserLoginInfoCompany"
#define kUserLoginInfoAppkey       @"kUserLoginInfoAppkey"
#define kUserLoginInfoToken        @"kUserLoginInfoToken"
#define kUserLoginInfoOrganization @"kUserLoginInfoOrganization"

#endif
