//
//  EMLocalDefault.h
//  ChatDemo-UI
//
//  Created by dhcdht on 14-5-2.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#ifndef ChatDemo_UI_EMLocalDefault_h
#define ChatDemo_UI_EMLocalDefault_h

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define KMESSAGEKEY @"Message"
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define NTF_WILLSENDMESSAGETOUSERNAME                       @"NTF_WILLSENDMESSAGETOUSERNAME"
#define WILLSENDMESSAGETOUSERNAME                           @"WILLSENDMESSAGETOUSERNAME"
#define WILLSENDMESSAGETOUSERNAME_CHATROOMMESSAGE           @"WILLSENDMESSAGETOUSERNAME_CHATROOMMESSAGE"

// 联系人信息
#define CONTACT_AVATAR @"avatar"
#define CONTACT_NICKNAME @"nick"
#define CONTACT_USERNAME @"username"
#define CONTACT_SIGNATURE @"signature"
#define CONTACT_SEX @"sex"
#define CONTACT_ADDRESS @"author_active_region"
#define CONTACT_BGPICTURE @"friendMomentPicture"
#define CONTACT_MOBILE @"mobile"
#define CONTACT_EMAIL @"email"
#define CONTACT_MEMO @"memo"

#endif
