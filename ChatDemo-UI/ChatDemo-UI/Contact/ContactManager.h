//
//  ContactManager.h
//  ChatDemo-UI
//
//  Created by dujiepeng on 14-4-20.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactManager : NSObject
+(NSArray *)contacts;
+(void)setContacts:(NSArray *)contacts;
@end
