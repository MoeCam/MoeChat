//
//  HttpStatusCodeDefs.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 9/28/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#ifndef EaseMobClientSDK_HttpStatusCodeDefs_h
#define EaseMobClientSDK_HttpStatusCodeDefs_h

#define HTTP_OK 200
#define HTTP_OK_NOCONTENT 204
#define HTTP_UNAUTHORIZED 401

#define VALIDATE_HTTPSTATUS_CODE(x) ((x)>=200&&(x)<=299)

#endif
