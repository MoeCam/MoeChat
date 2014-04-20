//
//  LocalAddressbookUtils.h
//  LocalAddressbook
//
//  Created by Ji Fang on 8/18/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalAddressbookUtils : NSObject

+(NSArray *)getLocalContactsByPhoneNumber:(NSString *)phone;

@end
