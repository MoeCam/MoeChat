//
//  AddressBookManager.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 8/20/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookManager : NSObject

+(AddressBookManager *)sharedInstance;

-(NSArray *)findPersonsByPhoneNumber:(NSString *)phoneNumber;

@end
