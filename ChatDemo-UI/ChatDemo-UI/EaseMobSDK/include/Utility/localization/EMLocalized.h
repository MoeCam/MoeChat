//
//  EMLocalized.h
//  EaseMob
//
//  Created by Ji Fang on 6/11/13.
//  Copyright (c) 2013 Ji Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

NSString * EMLocalizedString(NSString *key);
NSString * EMLocalizedStringWithComment(NSString *key, NSString *comment);
NSString * EMLocalizedStringFromTable(NSString *key, NSString *table, NSString *comment);

#ifdef __cplusplus
}
#endif
