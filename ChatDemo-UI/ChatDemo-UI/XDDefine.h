//
//  XDDefine.h
//  leCar
//
//  Created by Li Zhiping on 14-1-6.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#ifndef leCar_XDDefine_h
#define leCar_XDDefine_h

#define kLeCarOrgKey [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_ORGKEY"]
#define kLeCarAppKey [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_APPKEY"]
#define kLeCarApiUrl [NSString stringWithFormat:@"http://%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EASEMOB_API_URL"]]

#define NoLoginUsername @"guest"
#define kOrgName kLeCarOrgKey
#define kAppName kLeCarAppKey
#define kHost kLeCarApiUrl

#define kDefaultRequestCount 10

typedef enum {
    XDPrivateTypeOnlyFriend,
    XDPrivateTypeAllPeople,
    XDPrivateTypeOnlySelf,
}XDPrivateType;

typedef enum {
    XDSearchStoreTypeNone   = -1,
    XDSearchStoreType4S     = 0,
    XDSearchStoreTypeMaintain,
    XDSearchStoreTypeDecorate,
    XDSearchStoreTypeWash,
}XDSearchStoreType;

typedef enum{
    XDFriendMomentCollect,  //朋友圈的收藏
    XDFriendMomentFeed,     //朋友圈列表(包括自己发表的朋友圈说说)
    XDFriendMomentNearby,  //朋友圈列表(附近发表的说说)
}XDFriendMomentType;

#define EMLogVerbose(fmt, ...) DDLogVerbose((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define EMLogInfo(fmt, ...) DDLogInfo((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define EMLogWarn(fmt, ...) DDLogWarn((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define EMLogError(fmt, ...) DDLogError((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//button title normal color(default)
#define BUTTONTITLEDETAILCOLOR_NORMAL [UIColor colorWithRed:84 / 255.0 green:105 / 255.0 blue:116 / 255.0 alpha:1.0]
//textField color (detail)
#define TEXTFIELDDETAILCOLOR [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1.0]

//button titleLable font
//#define BUTTON_TITLE_BIG [UIFont systemFontOfSize:14.0]
#define BUTTON_TITLE_FONT_NORMAL [UIFont boldSystemFontOfSize:14.0]

//text font
#define TEXT_FONT [UIFont systemFontOfSize:14.0]
#define TITLE_FONT [UIFont systemFontOfSize:16.0]
#define MIN_FONT [UIFont systemFontOfSize:12.0]

#define kSqlLimitCount 20
#define kCountOfPage 10
#define KGridViewCol 3
#define KSearchNearbyRadius 10000000

#define kCompanyName @"leCar"
#define AccountID [XDContactManager username]
#define AccountToken [XDContactManager token]
#define AccountName [XDContactManager username]

//notification
#define KNOTIFICATION_PART @"partNotification"
#define KNOTIFICATION_ATTENTION @"attentionNotification"

//data
#define DATA_ID @"uuid"
#define DATA_COUNT @"count"
#define DATA_BODY @"entities"
#define DATA_PARAMS @"params"
#define DATA_CURSOR @"cursor"

//小喇叭
#define NOTIFICATION_IMAGEPATH @"companyAvator"
#define NOTIFICATION_TITLE @"companyName"
#define NOTIFICATION_SUBJECT @"activitySubject"
#define NOTIFICATION_CONTENT @"activityContent"
#define NOTIFICATION_MESSAGETYPE @"messageType"
#define NOTIFICATION_ACTIVITYDATE @"activityTime"

#define NOTIFICATION_MESSAGETYPE_ACTIVITY @"activity"
#define NOTIFICATION_MESSAGETYPE_COUPON @"coupon"

//用户
#define USER_NAME @"username"
#define USER_NICKNAME @"author_nickname"
#define USER_HEADERIMAGEPATH @"author_avator"
#define USER_GENDER @"author_gender"

//店铺
#define STORE_NAME @"cName"
#define STORE_TYPE @"cType"
#define STORE_HEADERIMAGEPATH @"cAvatorSmall"
#define STORE_BIGIMAGEPATH @"cAvatorBig"
#define STORE_BRAND @"brand"
#define STORE_MOBILEPHONE @"cTel"
#define STORE_LANDLINEPHONE @"mobile"
#define STORE_LOCATION @"location"
#define STORE_ADDRESS @"address"
#define STORE_LAT @"latitude"
#define STORE_LON @"longitude"
#define STORE_CADDRESS @"cAddress"
#define STORE_PROVINCE @"cProvince"
#define STORE_CITY @"cCity"

//产品组
#define PRODUCT_GROUP_IMAGEPATH @"picture"
#define PRODUCT_GROUP_TITLE @"title"
#define PRODUCT_GROUP_SUBIMAGES @"subProducts"

//业务员Salesman
#define DATA_SALESMANS_REPLACE @"displaceConsultants"
#define DATA_SALESMANS_PRODUCT @"productConsultants"
#define SALESMAN_ID @"jid"
#define SALESMAN_NAME @"username"
#define SALESMAN_NICKNAME @"nickname"
#define SALESMAN_HEADERIMAGEPATH @"picture"

//置换
#define REPLACE_TITLE @"title"
#define REPLACE_STOREID @"carStoreUUID"
#define REPLACE_BEGINDATE @"fromeDate"
#define REPLACE_ENDDATE @"toDate"

//设置
#define kUserimageHeight 60.0f
#define kUserimageWidth 60.0f
#define kContactImageHeight 44.0f
#define kContactImageWidth 44.0f
#define leftPadding 10.0f
#define topPadding 10.0f

#define MinimumFontSize 13.0f

#define friendTableViewBGColor RGBCOLOR(244, 247, 249)

// 发送消息
#define NTF_WILLSENDMESSAGETOUSERNAME                       @"NTF_WILLSENDMESSAGETOUSERNAME"
#define WILLSENDMESSAGETOUSERNAME                           @"WILLSENDMESSAGETOUSERNAME"
#define WILLSENDMESSAGETOUSERNAME_CHATROOMMESSAGE           @"WILLSENDMESSAGETOUSERNAME_CHATROOMMESSAGE"
//#define WILLSENDMESSAGETOJID_CHATDATA                       @"WILLSENDMESSAGETOJID_CHATDATA"

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
